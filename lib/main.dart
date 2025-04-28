import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'models/vehicle_model.dart';
import 'models/maintenance_component_model.dart';
import 'models/maintenance_record_model.dart';
import 'repositories/local_vehicle_repository.dart';
import 'repositories/local_component_repository.dart';
import 'repositories/local_record_repository.dart';
import 'screens/home_screen.dart';
import 'screens/vehicle_list_screen.dart';
import 'screens/maintenance_screen.dart';
import 'screens/profile_screen.dart';
import 'providers/vehicle_list_provider.dart';
import 'providers/maintenance_provider.dart';

late Isar isar;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String directory = '';
  if (!kIsWeb) {
  final dir = await getApplicationDocumentsDirectory();
    directory = dir.path;
    print('数据库路径: $directory');
  }

  try {
  isar = await Isar.open(
      [
      VehicleSchema,
      MaintenanceComponentSchema,
      MaintenanceRecordSchema,
    ],
      directory: directory,
    name: 'carsaveDb',
      inspector: true,
    );
    print('Isar 数据库初始化成功！');
  } catch (e, stackTrace) {
    print('Isar 数据库初始化失败：$e');
    print('错误堆栈：$stackTrace');
    rethrow;
  }

  final localVehicleRepository = LocalVehicleRepository(isar);
  final localComponentRepository = LocalComponentRepository(isar);
  final localRecordRepository = LocalRecordRepository(isar);

  runApp(
    MultiProvider(
      providers: [
        Provider<Isar>.value(value: isar),
        Provider<LocalVehicleRepository>.value(value: localVehicleRepository),
        Provider<LocalComponentRepository>.value(value: localComponentRepository),
        Provider<LocalRecordRepository>.value(value: localRecordRepository),
        ChangeNotifierProvider(
          create: (context) => VehicleListProvider(localVehicleRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => MaintenanceProvider(
            localComponentRepository, 
            localRecordRepository,
            localVehicleRepository,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '车辆保养助手',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const VehicleListScreen(),
    const MaintenanceScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
         index: _currentIndex,
         children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: '车辆',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: '保养',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人资料'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '用户名',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  _buildProfileItem(Icons.email, '邮箱', 'user@example.com'),
                  _buildProfileItem(Icons.phone, '手机号', '123-456-7890'),
                  _buildProfileItem(Icons.car_repair, '车辆数量', '3'),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // 实现登出功能
                    },
                    child: const Text('退出登录'),
                  ),
                ],
              ),
            ),
          ),
          // 底部支持按钮和版本号
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: 实现支持功能
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('感谢您的支持！')),
                    );
                  },
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  label: const Text('支持我们'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '版本号: $appVersion',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 20),
          Text(title, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
} 
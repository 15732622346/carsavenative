// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_component_model.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetMaintenanceComponentCollection on Isar {
  IsarCollection<int, MaintenanceComponent> get maintenanceComponents =>
      this.collection();
}

const MaintenanceComponentSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'MaintenanceComponent',
    idName: 'isarId',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'vehicle',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'maintenanceType',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'maintenanceValue',
        type: IsarType.double,
      ),
      IsarPropertySchema(
        name: 'targetMaintenanceMileage',
        type: IsarType.double,
      ),
      IsarPropertySchema(
        name: 'targetMaintenanceDate',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'unit',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'lastMaintenance',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'vehicleIndex',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'typeIndex',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'vehicleIndex',
        properties: [
          "vehicleIndex",
        ],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'typeIndex',
        properties: [
          "typeIndex",
        ],
        unique: false,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, MaintenanceComponent>(
    serialize: serializeMaintenanceComponent,
    deserialize: deserializeMaintenanceComponent,
    deserializeProperty: deserializeMaintenanceComponentProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeMaintenanceComponent(
    IsarWriter writer, MaintenanceComponent object) {
  IsarCore.writeString(writer, 1, object.name);
  IsarCore.writeString(writer, 2, object.vehicle);
  IsarCore.writeString(writer, 3, object.maintenanceType);
  IsarCore.writeDouble(writer, 4, object.maintenanceValue);
  IsarCore.writeDouble(
      writer, 5, object.targetMaintenanceMileage ?? double.nan);
  IsarCore.writeLong(
      writer,
      6,
      object.targetMaintenanceDate?.toUtc().microsecondsSinceEpoch ??
          -9223372036854775808);
  IsarCore.writeString(writer, 7, object.unit);
  IsarCore.writeLong(
      writer,
      8,
      object.lastMaintenance?.toUtc().microsecondsSinceEpoch ??
          -9223372036854775808);
  IsarCore.writeString(writer, 9, object.vehicleIndex);
  IsarCore.writeString(writer, 10, object.typeIndex);
  return object.isarId;
}

@isarProtected
MaintenanceComponent deserializeMaintenanceComponent(IsarReader reader) {
  final String _name;
  _name = IsarCore.readString(reader, 1) ?? '';
  final String _vehicle;
  _vehicle = IsarCore.readString(reader, 2) ?? '';
  final String _maintenanceType;
  _maintenanceType = IsarCore.readString(reader, 3) ?? '';
  final double _maintenanceValue;
  _maintenanceValue = IsarCore.readDouble(reader, 4);
  final double? _targetMaintenanceMileage;
  {
    final value = IsarCore.readDouble(reader, 5);
    if (value.isNaN) {
      _targetMaintenanceMileage = null;
    } else {
      _targetMaintenanceMileage = value;
    }
  }
  final DateTime? _targetMaintenanceDate;
  {
    final value = IsarCore.readLong(reader, 6);
    if (value == -9223372036854775808) {
      _targetMaintenanceDate = null;
    } else {
      _targetMaintenanceDate =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final String _unit;
  _unit = IsarCore.readString(reader, 7) ?? '';
  final DateTime? _lastMaintenance;
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      _lastMaintenance = null;
    } else {
      _lastMaintenance =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final object = MaintenanceComponent(
    name: _name,
    vehicle: _vehicle,
    maintenanceType: _maintenanceType,
    maintenanceValue: _maintenanceValue,
    targetMaintenanceMileage: _targetMaintenanceMileage,
    targetMaintenanceDate: _targetMaintenanceDate,
    unit: _unit,
    lastMaintenance: _lastMaintenance,
  );
  object.isarId = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeMaintenanceComponentProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readDouble(reader, 4);
    case 5:
      {
        final value = IsarCore.readDouble(reader, 5);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 6:
      {
        final value = IsarCore.readLong(reader, 6);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      {
        final value = IsarCore.readLong(reader, 8);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 9:
      return IsarCore.readString(reader, 9) ?? '';
    case 10:
      return IsarCore.readString(reader, 10) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _MaintenanceComponentUpdate {
  bool call({
    required int isarId,
    String? name,
    String? vehicle,
    String? maintenanceType,
    double? maintenanceValue,
    double? targetMaintenanceMileage,
    DateTime? targetMaintenanceDate,
    String? unit,
    DateTime? lastMaintenance,
    String? vehicleIndex,
    String? typeIndex,
  });
}

class _MaintenanceComponentUpdateImpl implements _MaintenanceComponentUpdate {
  const _MaintenanceComponentUpdateImpl(this.collection);

  final IsarCollection<int, MaintenanceComponent> collection;

  @override
  bool call({
    required int isarId,
    Object? name = ignore,
    Object? vehicle = ignore,
    Object? maintenanceType = ignore,
    Object? maintenanceValue = ignore,
    Object? targetMaintenanceMileage = ignore,
    Object? targetMaintenanceDate = ignore,
    Object? unit = ignore,
    Object? lastMaintenance = ignore,
    Object? vehicleIndex = ignore,
    Object? typeIndex = ignore,
  }) {
    return collection.updateProperties([
          isarId
        ], {
          if (name != ignore) 1: name as String?,
          if (vehicle != ignore) 2: vehicle as String?,
          if (maintenanceType != ignore) 3: maintenanceType as String?,
          if (maintenanceValue != ignore) 4: maintenanceValue as double?,
          if (targetMaintenanceMileage != ignore)
            5: targetMaintenanceMileage as double?,
          if (targetMaintenanceDate != ignore)
            6: targetMaintenanceDate as DateTime?,
          if (unit != ignore) 7: unit as String?,
          if (lastMaintenance != ignore) 8: lastMaintenance as DateTime?,
          if (vehicleIndex != ignore) 9: vehicleIndex as String?,
          if (typeIndex != ignore) 10: typeIndex as String?,
        }) >
        0;
  }
}

sealed class _MaintenanceComponentUpdateAll {
  int call({
    required List<int> isarId,
    String? name,
    String? vehicle,
    String? maintenanceType,
    double? maintenanceValue,
    double? targetMaintenanceMileage,
    DateTime? targetMaintenanceDate,
    String? unit,
    DateTime? lastMaintenance,
    String? vehicleIndex,
    String? typeIndex,
  });
}

class _MaintenanceComponentUpdateAllImpl
    implements _MaintenanceComponentUpdateAll {
  const _MaintenanceComponentUpdateAllImpl(this.collection);

  final IsarCollection<int, MaintenanceComponent> collection;

  @override
  int call({
    required List<int> isarId,
    Object? name = ignore,
    Object? vehicle = ignore,
    Object? maintenanceType = ignore,
    Object? maintenanceValue = ignore,
    Object? targetMaintenanceMileage = ignore,
    Object? targetMaintenanceDate = ignore,
    Object? unit = ignore,
    Object? lastMaintenance = ignore,
    Object? vehicleIndex = ignore,
    Object? typeIndex = ignore,
  }) {
    return collection.updateProperties(isarId, {
      if (name != ignore) 1: name as String?,
      if (vehicle != ignore) 2: vehicle as String?,
      if (maintenanceType != ignore) 3: maintenanceType as String?,
      if (maintenanceValue != ignore) 4: maintenanceValue as double?,
      if (targetMaintenanceMileage != ignore)
        5: targetMaintenanceMileage as double?,
      if (targetMaintenanceDate != ignore)
        6: targetMaintenanceDate as DateTime?,
      if (unit != ignore) 7: unit as String?,
      if (lastMaintenance != ignore) 8: lastMaintenance as DateTime?,
      if (vehicleIndex != ignore) 9: vehicleIndex as String?,
      if (typeIndex != ignore) 10: typeIndex as String?,
    });
  }
}

extension MaintenanceComponentUpdate
    on IsarCollection<int, MaintenanceComponent> {
  _MaintenanceComponentUpdate get update =>
      _MaintenanceComponentUpdateImpl(this);

  _MaintenanceComponentUpdateAll get updateAll =>
      _MaintenanceComponentUpdateAllImpl(this);
}

sealed class _MaintenanceComponentQueryUpdate {
  int call({
    String? name,
    String? vehicle,
    String? maintenanceType,
    double? maintenanceValue,
    double? targetMaintenanceMileage,
    DateTime? targetMaintenanceDate,
    String? unit,
    DateTime? lastMaintenance,
    String? vehicleIndex,
    String? typeIndex,
  });
}

class _MaintenanceComponentQueryUpdateImpl
    implements _MaintenanceComponentQueryUpdate {
  const _MaintenanceComponentQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<MaintenanceComponent> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? vehicle = ignore,
    Object? maintenanceType = ignore,
    Object? maintenanceValue = ignore,
    Object? targetMaintenanceMileage = ignore,
    Object? targetMaintenanceDate = ignore,
    Object? unit = ignore,
    Object? lastMaintenance = ignore,
    Object? vehicleIndex = ignore,
    Object? typeIndex = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (name != ignore) 1: name as String?,
      if (vehicle != ignore) 2: vehicle as String?,
      if (maintenanceType != ignore) 3: maintenanceType as String?,
      if (maintenanceValue != ignore) 4: maintenanceValue as double?,
      if (targetMaintenanceMileage != ignore)
        5: targetMaintenanceMileage as double?,
      if (targetMaintenanceDate != ignore)
        6: targetMaintenanceDate as DateTime?,
      if (unit != ignore) 7: unit as String?,
      if (lastMaintenance != ignore) 8: lastMaintenance as DateTime?,
      if (vehicleIndex != ignore) 9: vehicleIndex as String?,
      if (typeIndex != ignore) 10: typeIndex as String?,
    });
  }
}

extension MaintenanceComponentQueryUpdate on IsarQuery<MaintenanceComponent> {
  _MaintenanceComponentQueryUpdate get updateFirst =>
      _MaintenanceComponentQueryUpdateImpl(this, limit: 1);

  _MaintenanceComponentQueryUpdate get updateAll =>
      _MaintenanceComponentQueryUpdateImpl(this);
}

class _MaintenanceComponentQueryBuilderUpdateImpl
    implements _MaintenanceComponentQueryUpdate {
  const _MaintenanceComponentQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<MaintenanceComponent, MaintenanceComponent, QOperations>
      query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? vehicle = ignore,
    Object? maintenanceType = ignore,
    Object? maintenanceValue = ignore,
    Object? targetMaintenanceMileage = ignore,
    Object? targetMaintenanceDate = ignore,
    Object? unit = ignore,
    Object? lastMaintenance = ignore,
    Object? vehicleIndex = ignore,
    Object? typeIndex = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (name != ignore) 1: name as String?,
        if (vehicle != ignore) 2: vehicle as String?,
        if (maintenanceType != ignore) 3: maintenanceType as String?,
        if (maintenanceValue != ignore) 4: maintenanceValue as double?,
        if (targetMaintenanceMileage != ignore)
          5: targetMaintenanceMileage as double?,
        if (targetMaintenanceDate != ignore)
          6: targetMaintenanceDate as DateTime?,
        if (unit != ignore) 7: unit as String?,
        if (lastMaintenance != ignore) 8: lastMaintenance as DateTime?,
        if (vehicleIndex != ignore) 9: vehicleIndex as String?,
        if (typeIndex != ignore) 10: typeIndex as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension MaintenanceComponentQueryBuilderUpdate
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QOperations> {
  _MaintenanceComponentQueryUpdate get updateFirst =>
      _MaintenanceComponentQueryBuilderUpdateImpl(this, limit: 1);

  _MaintenanceComponentQueryUpdate get updateAll =>
      _MaintenanceComponentQueryBuilderUpdateImpl(this);
}

extension MaintenanceComponentQueryFilter on QueryBuilder<MaintenanceComponent,
    MaintenanceComponent, QFilterCondition> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> isarIdEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> isarIdGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> isarIdGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> isarIdLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> isarIdLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> isarIdBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      vehicleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      vehicleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      maintenanceTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      maintenanceTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueGreaterThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueLessThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueBetween(
    double lower,
    double upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      unitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 7,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      vehicleIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      vehicleIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 9,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      typeIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      typeIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 10,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }
}

extension MaintenanceComponentQueryObject on QueryBuilder<MaintenanceComponent,
    MaintenanceComponent, QFilterCondition> {}

extension MaintenanceComponentQuerySortBy
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QSortBy> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByVehicle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByVehicleDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByMaintenanceType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByMaintenanceTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByMaintenanceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByMaintenanceValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTargetMaintenanceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTargetMaintenanceMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTargetMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTargetMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByUnitDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByLastMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByLastMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByVehicleIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByVehicleIndexDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTypeIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTypeIndexDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension MaintenanceComponentQuerySortThenBy
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QSortThenBy> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByVehicle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByVehicleDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByMaintenanceType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByMaintenanceTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByMaintenanceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByMaintenanceValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTargetMaintenanceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTargetMaintenanceMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTargetMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTargetMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByUnitDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByLastMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByLastMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByVehicleIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByVehicleIndexDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTypeIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTypeIndexDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension MaintenanceComponentQueryWhereDistinct
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByVehicle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByMaintenanceType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByMaintenanceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByTargetMaintenanceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByTargetMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByLastMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByVehicleIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterDistinct>
      distinctByTypeIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }
}

extension MaintenanceComponentQueryProperty1
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QProperty> {
  QueryBuilder<MaintenanceComponent, int, QAfterProperty> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<MaintenanceComponent, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MaintenanceComponent, String, QAfterProperty> vehicleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MaintenanceComponent, String, QAfterProperty>
      maintenanceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MaintenanceComponent, double, QAfterProperty>
      maintenanceValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MaintenanceComponent, double?, QAfterProperty>
      targetMaintenanceMileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MaintenanceComponent, DateTime?, QAfterProperty>
      targetMaintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MaintenanceComponent, String, QAfterProperty> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MaintenanceComponent, DateTime?, QAfterProperty>
      lastMaintenanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MaintenanceComponent, String, QAfterProperty>
      vehicleIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MaintenanceComponent, String, QAfterProperty>
      typeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension MaintenanceComponentQueryProperty2<R>
    on QueryBuilder<MaintenanceComponent, R, QAfterProperty> {
  QueryBuilder<MaintenanceComponent, (R, int), QAfterProperty>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, String), QAfterProperty>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, String), QAfterProperty>
      vehicleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, String), QAfterProperty>
      maintenanceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, double), QAfterProperty>
      maintenanceValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, double?), QAfterProperty>
      targetMaintenanceMileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, DateTime?), QAfterProperty>
      targetMaintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, String), QAfterProperty>
      unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, DateTime?), QAfterProperty>
      lastMaintenanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, String), QAfterProperty>
      vehicleIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MaintenanceComponent, (R, String), QAfterProperty>
      typeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension MaintenanceComponentQueryProperty3<R1, R2>
    on QueryBuilder<MaintenanceComponent, (R1, R2), QAfterProperty> {
  QueryBuilder<MaintenanceComponent, (R1, R2, int), QOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, String), QOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, String), QOperations>
      vehicleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, String), QOperations>
      maintenanceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, double), QOperations>
      maintenanceValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, double?), QOperations>
      targetMaintenanceMileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, DateTime?), QOperations>
      targetMaintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, String), QOperations>
      unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, DateTime?), QOperations>
      lastMaintenanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, String), QOperations>
      vehicleIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MaintenanceComponent, (R1, R2, String), QOperations>
      typeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

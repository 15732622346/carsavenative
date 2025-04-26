// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_record_model.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetMaintenanceRecordCollection on Isar {
  IsarCollection<int, MaintenanceRecord> get maintenanceRecords =>
      this.collection();
}

const MaintenanceRecordSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'MaintenanceRecord',
    idName: 'isarId',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'vehicleName',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'componentId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'componentName',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'maintenanceDate',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'mileageAtMaintenance',
        type: IsarType.double,
      ),
      IsarPropertySchema(
        name: 'notes',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'vehicleIndex',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'componentIdIndex',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'formattedDate',
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
        name: 'componentIdIndex',
        properties: [
          "componentIdIndex",
        ],
        unique: false,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, MaintenanceRecord>(
    serialize: serializeMaintenanceRecord,
    deserialize: deserializeMaintenanceRecord,
    deserializeProperty: deserializeMaintenanceRecordProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeMaintenanceRecord(IsarWriter writer, MaintenanceRecord object) {
  IsarCore.writeString(writer, 1, object.vehicleName);
  IsarCore.writeString(writer, 2, object.componentId);
  IsarCore.writeString(writer, 3, object.componentName);
  IsarCore.writeLong(
      writer, 4, object.maintenanceDate.toUtc().microsecondsSinceEpoch);
  IsarCore.writeDouble(writer, 5, object.mileageAtMaintenance ?? double.nan);
  {
    final value = object.notes;
    if (value == null) {
      IsarCore.writeNull(writer, 6);
    } else {
      IsarCore.writeString(writer, 6, value);
    }
  }
  IsarCore.writeString(writer, 7, object.vehicleIndex);
  IsarCore.writeString(writer, 8, object.componentIdIndex);
  IsarCore.writeString(writer, 9, object.formattedDate);
  return object.isarId;
}

@isarProtected
MaintenanceRecord deserializeMaintenanceRecord(IsarReader reader) {
  final String _vehicleName;
  _vehicleName = IsarCore.readString(reader, 1) ?? '';
  final String _componentId;
  _componentId = IsarCore.readString(reader, 2) ?? '';
  final String _componentName;
  _componentName = IsarCore.readString(reader, 3) ?? '';
  final DateTime _maintenanceDate;
  {
    final value = IsarCore.readLong(reader, 4);
    if (value == -9223372036854775808) {
      _maintenanceDate =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      _maintenanceDate =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final double? _mileageAtMaintenance;
  {
    final value = IsarCore.readDouble(reader, 5);
    if (value.isNaN) {
      _mileageAtMaintenance = null;
    } else {
      _mileageAtMaintenance = value;
    }
  }
  final String? _notes;
  _notes = IsarCore.readString(reader, 6);
  final object = MaintenanceRecord(
    vehicleName: _vehicleName,
    componentId: _componentId,
    componentName: _componentName,
    maintenanceDate: _maintenanceDate,
    mileageAtMaintenance: _mileageAtMaintenance,
    notes: _notes,
  );
  object.isarId = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeMaintenanceRecordProp(IsarReader reader, int property) {
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
      {
        final value = IsarCore.readLong(reader, 4);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
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
      return IsarCore.readString(reader, 6);
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      return IsarCore.readString(reader, 8) ?? '';
    case 9:
      return IsarCore.readString(reader, 9) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _MaintenanceRecordUpdate {
  bool call({
    required int isarId,
    String? vehicleName,
    String? componentId,
    String? componentName,
    DateTime? maintenanceDate,
    double? mileageAtMaintenance,
    String? notes,
    String? vehicleIndex,
    String? componentIdIndex,
    String? formattedDate,
  });
}

class _MaintenanceRecordUpdateImpl implements _MaintenanceRecordUpdate {
  const _MaintenanceRecordUpdateImpl(this.collection);

  final IsarCollection<int, MaintenanceRecord> collection;

  @override
  bool call({
    required int isarId,
    Object? vehicleName = ignore,
    Object? componentId = ignore,
    Object? componentName = ignore,
    Object? maintenanceDate = ignore,
    Object? mileageAtMaintenance = ignore,
    Object? notes = ignore,
    Object? vehicleIndex = ignore,
    Object? componentIdIndex = ignore,
    Object? formattedDate = ignore,
  }) {
    return collection.updateProperties([
          isarId
        ], {
          if (vehicleName != ignore) 1: vehicleName as String?,
          if (componentId != ignore) 2: componentId as String?,
          if (componentName != ignore) 3: componentName as String?,
          if (maintenanceDate != ignore) 4: maintenanceDate as DateTime?,
          if (mileageAtMaintenance != ignore)
            5: mileageAtMaintenance as double?,
          if (notes != ignore) 6: notes as String?,
          if (vehicleIndex != ignore) 7: vehicleIndex as String?,
          if (componentIdIndex != ignore) 8: componentIdIndex as String?,
          if (formattedDate != ignore) 9: formattedDate as String?,
        }) >
        0;
  }
}

sealed class _MaintenanceRecordUpdateAll {
  int call({
    required List<int> isarId,
    String? vehicleName,
    String? componentId,
    String? componentName,
    DateTime? maintenanceDate,
    double? mileageAtMaintenance,
    String? notes,
    String? vehicleIndex,
    String? componentIdIndex,
    String? formattedDate,
  });
}

class _MaintenanceRecordUpdateAllImpl implements _MaintenanceRecordUpdateAll {
  const _MaintenanceRecordUpdateAllImpl(this.collection);

  final IsarCollection<int, MaintenanceRecord> collection;

  @override
  int call({
    required List<int> isarId,
    Object? vehicleName = ignore,
    Object? componentId = ignore,
    Object? componentName = ignore,
    Object? maintenanceDate = ignore,
    Object? mileageAtMaintenance = ignore,
    Object? notes = ignore,
    Object? vehicleIndex = ignore,
    Object? componentIdIndex = ignore,
    Object? formattedDate = ignore,
  }) {
    return collection.updateProperties(isarId, {
      if (vehicleName != ignore) 1: vehicleName as String?,
      if (componentId != ignore) 2: componentId as String?,
      if (componentName != ignore) 3: componentName as String?,
      if (maintenanceDate != ignore) 4: maintenanceDate as DateTime?,
      if (mileageAtMaintenance != ignore) 5: mileageAtMaintenance as double?,
      if (notes != ignore) 6: notes as String?,
      if (vehicleIndex != ignore) 7: vehicleIndex as String?,
      if (componentIdIndex != ignore) 8: componentIdIndex as String?,
      if (formattedDate != ignore) 9: formattedDate as String?,
    });
  }
}

extension MaintenanceRecordUpdate on IsarCollection<int, MaintenanceRecord> {
  _MaintenanceRecordUpdate get update => _MaintenanceRecordUpdateImpl(this);

  _MaintenanceRecordUpdateAll get updateAll =>
      _MaintenanceRecordUpdateAllImpl(this);
}

sealed class _MaintenanceRecordQueryUpdate {
  int call({
    String? vehicleName,
    String? componentId,
    String? componentName,
    DateTime? maintenanceDate,
    double? mileageAtMaintenance,
    String? notes,
    String? vehicleIndex,
    String? componentIdIndex,
    String? formattedDate,
  });
}

class _MaintenanceRecordQueryUpdateImpl
    implements _MaintenanceRecordQueryUpdate {
  const _MaintenanceRecordQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<MaintenanceRecord> query;
  final int? limit;

  @override
  int call({
    Object? vehicleName = ignore,
    Object? componentId = ignore,
    Object? componentName = ignore,
    Object? maintenanceDate = ignore,
    Object? mileageAtMaintenance = ignore,
    Object? notes = ignore,
    Object? vehicleIndex = ignore,
    Object? componentIdIndex = ignore,
    Object? formattedDate = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (vehicleName != ignore) 1: vehicleName as String?,
      if (componentId != ignore) 2: componentId as String?,
      if (componentName != ignore) 3: componentName as String?,
      if (maintenanceDate != ignore) 4: maintenanceDate as DateTime?,
      if (mileageAtMaintenance != ignore) 5: mileageAtMaintenance as double?,
      if (notes != ignore) 6: notes as String?,
      if (vehicleIndex != ignore) 7: vehicleIndex as String?,
      if (componentIdIndex != ignore) 8: componentIdIndex as String?,
      if (formattedDate != ignore) 9: formattedDate as String?,
    });
  }
}

extension MaintenanceRecordQueryUpdate on IsarQuery<MaintenanceRecord> {
  _MaintenanceRecordQueryUpdate get updateFirst =>
      _MaintenanceRecordQueryUpdateImpl(this, limit: 1);

  _MaintenanceRecordQueryUpdate get updateAll =>
      _MaintenanceRecordQueryUpdateImpl(this);
}

class _MaintenanceRecordQueryBuilderUpdateImpl
    implements _MaintenanceRecordQueryUpdate {
  const _MaintenanceRecordQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<MaintenanceRecord, MaintenanceRecord, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? vehicleName = ignore,
    Object? componentId = ignore,
    Object? componentName = ignore,
    Object? maintenanceDate = ignore,
    Object? mileageAtMaintenance = ignore,
    Object? notes = ignore,
    Object? vehicleIndex = ignore,
    Object? componentIdIndex = ignore,
    Object? formattedDate = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (vehicleName != ignore) 1: vehicleName as String?,
        if (componentId != ignore) 2: componentId as String?,
        if (componentName != ignore) 3: componentName as String?,
        if (maintenanceDate != ignore) 4: maintenanceDate as DateTime?,
        if (mileageAtMaintenance != ignore) 5: mileageAtMaintenance as double?,
        if (notes != ignore) 6: notes as String?,
        if (vehicleIndex != ignore) 7: vehicleIndex as String?,
        if (componentIdIndex != ignore) 8: componentIdIndex as String?,
        if (formattedDate != ignore) 9: formattedDate as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension MaintenanceRecordQueryBuilderUpdate
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QOperations> {
  _MaintenanceRecordQueryUpdate get updateFirst =>
      _MaintenanceRecordQueryBuilderUpdateImpl(this, limit: 1);

  _MaintenanceRecordQueryUpdate get updateAll =>
      _MaintenanceRecordQueryBuilderUpdateImpl(this);
}

extension MaintenanceRecordQueryFilter
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QFilterCondition> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      isarIdEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      isarIdGreaterThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      isarIdGreaterThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      isarIdLessThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      isarIdLessThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      isarIdBetween(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameGreaterThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameGreaterThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameLessThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameLessThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameBetween(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameStartsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameEndsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdGreaterThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdGreaterThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdLessThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdLessThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdBetween(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdStartsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdEndsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameGreaterThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameGreaterThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameLessThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameLessThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameBetween(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameStartsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameEndsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceGreaterThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceGreaterThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceLessThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceLessThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceBetween(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 6,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexGreaterThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexGreaterThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexLessThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexLessThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexBetween(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexStartsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexEndsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 8,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateGreaterThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateGreaterThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateLessThan(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateLessThanOrEqualTo(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateBetween(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateStartsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateEndsWith(
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }
}

extension MaintenanceRecordQueryObject
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QFilterCondition> {}

extension MaintenanceRecordQuerySortBy
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QSortBy> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByVehicleName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByVehicleNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByMileageAtMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByMileageAtMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy> sortByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByNotesDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByVehicleIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByVehicleIndexDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentIdIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentIdIndexDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByFormattedDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByFormattedDateDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension MaintenanceRecordQuerySortThenBy
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QSortThenBy> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByVehicleName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByVehicleNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByMileageAtMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByMileageAtMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy> thenByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByNotesDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByVehicleIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByVehicleIndexDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentIdIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentIdIndexDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByFormattedDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByFormattedDateDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension MaintenanceRecordQueryWhereDistinct
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterDistinct>
      distinctByVehicleName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterDistinct>
      distinctByComponentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterDistinct>
      distinctByComponentName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterDistinct>
      distinctByMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterDistinct>
      distinctByMileageAtMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterDistinct>
      distinctByVehicleIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterDistinct>
      distinctByComponentIdIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterDistinct>
      distinctByFormattedDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }
}

extension MaintenanceRecordQueryProperty1
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QProperty> {
  QueryBuilder<MaintenanceRecord, int, QAfterProperty> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<MaintenanceRecord, String, QAfterProperty>
      vehicleNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MaintenanceRecord, String, QAfterProperty>
      componentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MaintenanceRecord, String, QAfterProperty>
      componentNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MaintenanceRecord, DateTime, QAfterProperty>
      maintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MaintenanceRecord, double?, QAfterProperty>
      mileageAtMaintenanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MaintenanceRecord, String?, QAfterProperty> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MaintenanceRecord, String, QAfterProperty>
      vehicleIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MaintenanceRecord, String, QAfterProperty>
      componentIdIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MaintenanceRecord, String, QAfterProperty>
      formattedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }
}

extension MaintenanceRecordQueryProperty2<R>
    on QueryBuilder<MaintenanceRecord, R, QAfterProperty> {
  QueryBuilder<MaintenanceRecord, (R, int), QAfterProperty> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<MaintenanceRecord, (R, String), QAfterProperty>
      vehicleNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MaintenanceRecord, (R, String), QAfterProperty>
      componentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MaintenanceRecord, (R, String), QAfterProperty>
      componentNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MaintenanceRecord, (R, DateTime), QAfterProperty>
      maintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MaintenanceRecord, (R, double?), QAfterProperty>
      mileageAtMaintenanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MaintenanceRecord, (R, String?), QAfterProperty>
      notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MaintenanceRecord, (R, String), QAfterProperty>
      vehicleIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MaintenanceRecord, (R, String), QAfterProperty>
      componentIdIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MaintenanceRecord, (R, String), QAfterProperty>
      formattedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }
}

extension MaintenanceRecordQueryProperty3<R1, R2>
    on QueryBuilder<MaintenanceRecord, (R1, R2), QAfterProperty> {
  QueryBuilder<MaintenanceRecord, (R1, R2, int), QOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<MaintenanceRecord, (R1, R2, String), QOperations>
      vehicleNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MaintenanceRecord, (R1, R2, String), QOperations>
      componentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MaintenanceRecord, (R1, R2, String), QOperations>
      componentNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MaintenanceRecord, (R1, R2, DateTime), QOperations>
      maintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MaintenanceRecord, (R1, R2, double?), QOperations>
      mileageAtMaintenanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MaintenanceRecord, (R1, R2, String?), QOperations>
      notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MaintenanceRecord, (R1, R2, String), QOperations>
      vehicleIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MaintenanceRecord, (R1, R2, String), QOperations>
      componentIdIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MaintenanceRecord, (R1, R2, String), QOperations>
      formattedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }
}

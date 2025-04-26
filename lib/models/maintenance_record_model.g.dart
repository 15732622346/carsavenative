// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_record_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMaintenanceRecordCollection on Isar {
  IsarCollection<MaintenanceRecord> get maintenanceRecords => this.collection();
}

const MaintenanceRecordSchema = CollectionSchema(
  name: r'MaintenanceRecord',
  id: 8394037719530270343,
  properties: {
    r'componentId': PropertySchema(
      id: 0,
      name: r'componentId',
      type: IsarType.string,
    ),
    r'componentIdIndex': PropertySchema(
      id: 1,
      name: r'componentIdIndex',
      type: IsarType.string,
    ),
    r'componentName': PropertySchema(
      id: 2,
      name: r'componentName',
      type: IsarType.string,
    ),
    r'formattedDate': PropertySchema(
      id: 3,
      name: r'formattedDate',
      type: IsarType.string,
    ),
    r'maintenanceDate': PropertySchema(
      id: 4,
      name: r'maintenanceDate',
      type: IsarType.dateTime,
    ),
    r'mileageAtMaintenance': PropertySchema(
      id: 5,
      name: r'mileageAtMaintenance',
      type: IsarType.double,
    ),
    r'notes': PropertySchema(
      id: 6,
      name: r'notes',
      type: IsarType.string,
    ),
    r'vehicleIndex': PropertySchema(
      id: 7,
      name: r'vehicleIndex',
      type: IsarType.string,
    ),
    r'vehicleName': PropertySchema(
      id: 8,
      name: r'vehicleName',
      type: IsarType.string,
    )
  },
  estimateSize: _maintenanceRecordEstimateSize,
  serialize: _maintenanceRecordSerialize,
  deserialize: _maintenanceRecordDeserialize,
  deserializeProp: _maintenanceRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'vehicleIndex': IndexSchema(
      id: 6484721052844456263,
      name: r'vehicleIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'vehicleIndex',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'componentIdIndex': IndexSchema(
      id: 7224497827164607412,
      name: r'componentIdIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'componentIdIndex',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _maintenanceRecordGetId,
  getLinks: _maintenanceRecordGetLinks,
  attach: _maintenanceRecordAttach,
  version: '3.1.0+1',
);

int _maintenanceRecordEstimateSize(
  MaintenanceRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.componentId.length * 3;
  bytesCount += 3 + object.componentIdIndex.length * 3;
  bytesCount += 3 + object.componentName.length * 3;
  bytesCount += 3 + object.formattedDate.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.vehicleIndex.length * 3;
  bytesCount += 3 + object.vehicleName.length * 3;
  return bytesCount;
}

void _maintenanceRecordSerialize(
  MaintenanceRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.componentId);
  writer.writeString(offsets[1], object.componentIdIndex);
  writer.writeString(offsets[2], object.componentName);
  writer.writeString(offsets[3], object.formattedDate);
  writer.writeDateTime(offsets[4], object.maintenanceDate);
  writer.writeDouble(offsets[5], object.mileageAtMaintenance);
  writer.writeString(offsets[6], object.notes);
  writer.writeString(offsets[7], object.vehicleIndex);
  writer.writeString(offsets[8], object.vehicleName);
}

MaintenanceRecord _maintenanceRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MaintenanceRecord(
    componentId: reader.readString(offsets[0]),
    componentName: reader.readString(offsets[2]),
    maintenanceDate: reader.readDateTime(offsets[4]),
    mileageAtMaintenance: reader.readDoubleOrNull(offsets[5]),
    notes: reader.readStringOrNull(offsets[6]),
    vehicleName: reader.readString(offsets[8]),
  );
  object.id = id;
  return object;
}

P _maintenanceRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _maintenanceRecordGetId(MaintenanceRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _maintenanceRecordGetLinks(
    MaintenanceRecord object) {
  return [];
}

void _maintenanceRecordAttach(
    IsarCollection<dynamic> col, Id id, MaintenanceRecord object) {
  object.id = id;
}

extension MaintenanceRecordQueryWhereSort
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QWhere> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MaintenanceRecordQueryWhere
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QWhereClause> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhereClause>
      vehicleIndexEqualTo(String vehicleIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'vehicleIndex',
        value: [vehicleIndex],
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhereClause>
      vehicleIndexNotEqualTo(String vehicleIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleIndex',
              lower: [],
              upper: [vehicleIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleIndex',
              lower: [vehicleIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleIndex',
              lower: [vehicleIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleIndex',
              lower: [],
              upper: [vehicleIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhereClause>
      componentIdIndexEqualTo(String componentIdIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'componentIdIndex',
        value: [componentIdIndex],
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterWhereClause>
      componentIdIndexNotEqualTo(String componentIdIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'componentIdIndex',
              lower: [],
              upper: [componentIdIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'componentIdIndex',
              lower: [componentIdIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'componentIdIndex',
              lower: [componentIdIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'componentIdIndex',
              lower: [],
              upper: [componentIdIndex],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MaintenanceRecordQueryFilter
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QFilterCondition> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'componentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'componentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'componentId',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'componentId',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'componentIdIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'componentIdIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'componentIdIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'componentIdIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'componentIdIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'componentIdIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'componentIdIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'componentIdIndex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'componentIdIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentIdIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'componentIdIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'componentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'componentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'componentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'componentName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'componentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'componentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'componentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'componentName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'componentName',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      componentNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'componentName',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formattedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formattedDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedDate',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      formattedDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formattedDate',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      maintenanceDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maintenanceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mileageAtMaintenance',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mileageAtMaintenance',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mileageAtMaintenance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mileageAtMaintenance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mileageAtMaintenance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      mileageAtMaintenanceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mileageAtMaintenance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleIndex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleName',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterFilterCondition>
      vehicleNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleName',
        value: '',
      ));
    });
  }
}

extension MaintenanceRecordQueryObject
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QFilterCondition> {}

extension MaintenanceRecordQueryLinks
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QFilterCondition> {}

extension MaintenanceRecordQuerySortBy
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QSortBy> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentId', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentId', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentIdIndex', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentIdIndex', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentName', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByComponentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentName', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByFormattedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByFormattedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByMileageAtMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileageAtMaintenance', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByMileageAtMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileageAtMaintenance', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByVehicleIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleIndex', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByVehicleIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleIndex', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByVehicleName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      sortByVehicleNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.desc);
    });
  }
}

extension MaintenanceRecordQuerySortThenBy
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QSortThenBy> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentId', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentId', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentIdIndex', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentIdIndex', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentName', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByComponentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentName', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByFormattedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByFormattedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByMileageAtMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileageAtMaintenance', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByMileageAtMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileageAtMaintenance', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByVehicleIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleIndex', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByVehicleIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleIndex', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByVehicleName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QAfterSortBy>
      thenByVehicleNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.desc);
    });
  }
}

extension MaintenanceRecordQueryWhereDistinct
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct> {
  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct>
      distinctByComponentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'componentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct>
      distinctByComponentIdIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'componentIdIndex',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct>
      distinctByComponentName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'componentName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct>
      distinctByFormattedDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formattedDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct>
      distinctByMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maintenanceDate');
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct>
      distinctByMileageAtMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mileageAtMaintenance');
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct>
      distinctByVehicleIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleIndex', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceRecord, MaintenanceRecord, QDistinct>
      distinctByVehicleName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleName', caseSensitive: caseSensitive);
    });
  }
}

extension MaintenanceRecordQueryProperty
    on QueryBuilder<MaintenanceRecord, MaintenanceRecord, QQueryProperty> {
  QueryBuilder<MaintenanceRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MaintenanceRecord, String, QQueryOperations>
      componentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'componentId');
    });
  }

  QueryBuilder<MaintenanceRecord, String, QQueryOperations>
      componentIdIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'componentIdIndex');
    });
  }

  QueryBuilder<MaintenanceRecord, String, QQueryOperations>
      componentNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'componentName');
    });
  }

  QueryBuilder<MaintenanceRecord, String, QQueryOperations>
      formattedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formattedDate');
    });
  }

  QueryBuilder<MaintenanceRecord, DateTime, QQueryOperations>
      maintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maintenanceDate');
    });
  }

  QueryBuilder<MaintenanceRecord, double?, QQueryOperations>
      mileageAtMaintenanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mileageAtMaintenance');
    });
  }

  QueryBuilder<MaintenanceRecord, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<MaintenanceRecord, String, QQueryOperations>
      vehicleIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleIndex');
    });
  }

  QueryBuilder<MaintenanceRecord, String, QQueryOperations>
      vehicleNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleName');
    });
  }
}

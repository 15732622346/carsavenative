// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_component_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMaintenanceComponentCollection on Isar {
  IsarCollection<MaintenanceComponent> get maintenanceComponents =>
      this.collection();
}

const MaintenanceComponentSchema = CollectionSchema(
  name: r'MaintenanceComponent',
  id: -8600859907714171138,
  properties: {
    r'lastMaintenance': PropertySchema(
      id: 0,
      name: r'lastMaintenance',
      type: IsarType.dateTime,
    ),
    r'maintenanceType': PropertySchema(
      id: 1,
      name: r'maintenanceType',
      type: IsarType.string,
    ),
    r'maintenanceValue': PropertySchema(
      id: 2,
      name: r'maintenanceValue',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'targetMaintenanceDate': PropertySchema(
      id: 4,
      name: r'targetMaintenanceDate',
      type: IsarType.dateTime,
    ),
    r'targetMaintenanceMileage': PropertySchema(
      id: 5,
      name: r'targetMaintenanceMileage',
      type: IsarType.double,
    ),
    r'typeIndex': PropertySchema(
      id: 6,
      name: r'typeIndex',
      type: IsarType.string,
    ),
    r'unit': PropertySchema(
      id: 7,
      name: r'unit',
      type: IsarType.string,
    ),
    r'vehicle': PropertySchema(
      id: 8,
      name: r'vehicle',
      type: IsarType.string,
    ),
    r'vehicleIndex': PropertySchema(
      id: 9,
      name: r'vehicleIndex',
      type: IsarType.string,
    )
  },
  estimateSize: _maintenanceComponentEstimateSize,
  serialize: _maintenanceComponentSerialize,
  deserialize: _maintenanceComponentDeserialize,
  deserializeProp: _maintenanceComponentDeserializeProp,
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
    r'typeIndex': IndexSchema(
      id: 259437455522897078,
      name: r'typeIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'typeIndex',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _maintenanceComponentGetId,
  getLinks: _maintenanceComponentGetLinks,
  attach: _maintenanceComponentAttach,
  version: '3.1.0+1',
);

int _maintenanceComponentEstimateSize(
  MaintenanceComponent object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.maintenanceType.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.typeIndex.length * 3;
  bytesCount += 3 + object.unit.length * 3;
  bytesCount += 3 + object.vehicle.length * 3;
  bytesCount += 3 + object.vehicleIndex.length * 3;
  return bytesCount;
}

void _maintenanceComponentSerialize(
  MaintenanceComponent object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastMaintenance);
  writer.writeString(offsets[1], object.maintenanceType);
  writer.writeDouble(offsets[2], object.maintenanceValue);
  writer.writeString(offsets[3], object.name);
  writer.writeDateTime(offsets[4], object.targetMaintenanceDate);
  writer.writeDouble(offsets[5], object.targetMaintenanceMileage);
  writer.writeString(offsets[6], object.typeIndex);
  writer.writeString(offsets[7], object.unit);
  writer.writeString(offsets[8], object.vehicle);
  writer.writeString(offsets[9], object.vehicleIndex);
}

MaintenanceComponent _maintenanceComponentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MaintenanceComponent(
    lastMaintenance: reader.readDateTimeOrNull(offsets[0]),
    maintenanceType: reader.readString(offsets[1]),
    maintenanceValue: reader.readDouble(offsets[2]),
    name: reader.readString(offsets[3]),
    targetMaintenanceDate: reader.readDateTimeOrNull(offsets[4]),
    targetMaintenanceMileage: reader.readDoubleOrNull(offsets[5]),
    unit: reader.readString(offsets[7]),
    vehicle: reader.readString(offsets[8]),
  );
  object.id = id;
  return object;
}

P _maintenanceComponentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _maintenanceComponentGetId(MaintenanceComponent object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _maintenanceComponentGetLinks(
    MaintenanceComponent object) {
  return [];
}

void _maintenanceComponentAttach(
    IsarCollection<dynamic> col, Id id, MaintenanceComponent object) {
  object.id = id;
}

extension MaintenanceComponentQueryWhereSort
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QWhere> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MaintenanceComponentQueryWhere
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QWhereClause> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhereClause>
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhereClause>
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhereClause>
      vehicleIndexEqualTo(String vehicleIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'vehicleIndex',
        value: [vehicleIndex],
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhereClause>
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhereClause>
      typeIndexEqualTo(String typeIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'typeIndex',
        value: [typeIndex],
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterWhereClause>
      typeIndexNotEqualTo(String typeIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'typeIndex',
              lower: [],
              upper: [typeIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'typeIndex',
              lower: [typeIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'typeIndex',
              lower: [typeIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'typeIndex',
              lower: [],
              upper: [typeIndex],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MaintenanceComponentQueryFilter on QueryBuilder<MaintenanceComponent,
    MaintenanceComponent, QFilterCondition> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMaintenance',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMaintenance',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMaintenance',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMaintenance',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMaintenance',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> lastMaintenanceBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMaintenance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maintenanceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maintenanceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maintenanceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maintenanceType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'maintenanceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'maintenanceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      maintenanceTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'maintenanceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      maintenanceTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'maintenanceType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maintenanceType',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maintenanceType',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maintenanceValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maintenanceValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maintenanceValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> maintenanceValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maintenanceValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetMaintenanceDate',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetMaintenanceDate',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetMaintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetMaintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetMaintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetMaintenanceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetMaintenanceMileage',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetMaintenanceMileage',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetMaintenanceMileage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetMaintenanceMileage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetMaintenanceMileage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> targetMaintenanceMileageBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetMaintenanceMileage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'typeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'typeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'typeIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'typeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'typeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      typeIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'typeIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      typeIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'typeIndex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> typeIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'typeIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      unitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      vehicleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      vehicleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicle',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicle',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexEqualTo(
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexGreaterThan(
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexLessThan(
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexBetween(
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexStartsWith(
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexEndsWith(
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

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      vehicleIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
          QAfterFilterCondition>
      vehicleIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleIndex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent,
      QAfterFilterCondition> vehicleIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleIndex',
        value: '',
      ));
    });
  }
}

extension MaintenanceComponentQueryObject on QueryBuilder<MaintenanceComponent,
    MaintenanceComponent, QFilterCondition> {}

extension MaintenanceComponentQueryLinks on QueryBuilder<MaintenanceComponent,
    MaintenanceComponent, QFilterCondition> {}

extension MaintenanceComponentQuerySortBy
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QSortBy> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByLastMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMaintenance', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByLastMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMaintenance', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByMaintenanceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceType', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByMaintenanceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceType', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByMaintenanceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceValue', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByMaintenanceValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceValue', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTargetMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMaintenanceDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTargetMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMaintenanceDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTargetMaintenanceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMaintenanceMileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTargetMaintenanceMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMaintenanceMileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIndex', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIndex', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByVehicle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicle', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByVehicleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicle', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByVehicleIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleIndex', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      sortByVehicleIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleIndex', Sort.desc);
    });
  }
}

extension MaintenanceComponentQuerySortThenBy
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QSortThenBy> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByLastMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMaintenance', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByLastMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMaintenance', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByMaintenanceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceType', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByMaintenanceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceType', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByMaintenanceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceValue', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByMaintenanceValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maintenanceValue', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTargetMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMaintenanceDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTargetMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMaintenanceDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTargetMaintenanceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMaintenanceMileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTargetMaintenanceMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetMaintenanceMileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIndex', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIndex', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByVehicle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicle', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByVehicleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicle', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByVehicleIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleIndex', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QAfterSortBy>
      thenByVehicleIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleIndex', Sort.desc);
    });
  }
}

extension MaintenanceComponentQueryWhereDistinct
    on QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct> {
  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByLastMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMaintenance');
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByMaintenanceType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maintenanceType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByMaintenanceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maintenanceValue');
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByTargetMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetMaintenanceDate');
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByTargetMaintenanceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetMaintenanceMileage');
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByTypeIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeIndex', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByVehicle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceComponent, MaintenanceComponent, QDistinct>
      distinctByVehicleIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleIndex', caseSensitive: caseSensitive);
    });
  }
}

extension MaintenanceComponentQueryProperty on QueryBuilder<
    MaintenanceComponent, MaintenanceComponent, QQueryProperty> {
  QueryBuilder<MaintenanceComponent, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MaintenanceComponent, DateTime?, QQueryOperations>
      lastMaintenanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMaintenance');
    });
  }

  QueryBuilder<MaintenanceComponent, String, QQueryOperations>
      maintenanceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maintenanceType');
    });
  }

  QueryBuilder<MaintenanceComponent, double, QQueryOperations>
      maintenanceValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maintenanceValue');
    });
  }

  QueryBuilder<MaintenanceComponent, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MaintenanceComponent, DateTime?, QQueryOperations>
      targetMaintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetMaintenanceDate');
    });
  }

  QueryBuilder<MaintenanceComponent, double?, QQueryOperations>
      targetMaintenanceMileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetMaintenanceMileage');
    });
  }

  QueryBuilder<MaintenanceComponent, String, QQueryOperations>
      typeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeIndex');
    });
  }

  QueryBuilder<MaintenanceComponent, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }

  QueryBuilder<MaintenanceComponent, String, QQueryOperations>
      vehicleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicle');
    });
  }

  QueryBuilder<MaintenanceComponent, String, QQueryOperations>
      vehicleIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleIndex');
    });
  }
}

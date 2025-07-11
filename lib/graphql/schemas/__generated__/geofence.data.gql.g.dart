// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofence.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GlistAllGeoFencesData> _$glistAllGeoFencesDataSerializer =
    _$GlistAllGeoFencesDataSerializer();
Serializer<GlistAllGeoFencesData_listAllGeoFences>
    _$glistAllGeoFencesDataListAllGeoFencesSerializer =
    _$GlistAllGeoFencesData_listAllGeoFencesSerializer();
Serializer<GlistAllGeoFencesData_listAllGeoFences_data>
    _$glistAllGeoFencesDataListAllGeoFencesDataSerializer =
    _$GlistAllGeoFencesData_listAllGeoFences_dataSerializer();

class _$GlistAllGeoFencesDataSerializer
    implements StructuredSerializer<GlistAllGeoFencesData> {
  @override
  final Iterable<Type> types = const [
    GlistAllGeoFencesData,
    _$GlistAllGeoFencesData
  ];
  @override
  final String wireName = 'GlistAllGeoFencesData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GlistAllGeoFencesData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.listAllGeoFences;
    if (value != null) {
      result
        ..add('listAllGeoFences')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GlistAllGeoFencesData_listAllGeoFences)));
    }
    return result;
  }

  @override
  GlistAllGeoFencesData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GlistAllGeoFencesDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'listAllGeoFences':
          result.listAllGeoFences.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GlistAllGeoFencesData_listAllGeoFences))!
              as GlistAllGeoFencesData_listAllGeoFences);
          break;
      }
    }

    return result.build();
  }
}

class _$GlistAllGeoFencesData_listAllGeoFencesSerializer
    implements StructuredSerializer<GlistAllGeoFencesData_listAllGeoFences> {
  @override
  final Iterable<Type> types = const [
    GlistAllGeoFencesData_listAllGeoFences,
    _$GlistAllGeoFencesData_listAllGeoFences
  ];
  @override
  final String wireName = 'GlistAllGeoFencesData_listAllGeoFences';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GlistAllGeoFencesData_listAllGeoFences object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType.nullable(
                  GlistAllGeoFencesData_listAllGeoFences_data)
            ])));
    }
    value = object.totalCount;
    if (value != null) {
      result
        ..add('totalCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GlistAllGeoFencesData_listAllGeoFences deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GlistAllGeoFencesData_listAllGeoFencesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType.nullable(
                    GlistAllGeoFencesData_listAllGeoFences_data)
              ]))! as BuiltList<Object?>);
          break;
        case 'totalCount':
          result.totalCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GlistAllGeoFencesData_listAllGeoFences_dataSerializer
    implements
        StructuredSerializer<GlistAllGeoFencesData_listAllGeoFences_data> {
  @override
  final Iterable<Type> types = const [
    GlistAllGeoFencesData_listAllGeoFences_data,
    _$GlistAllGeoFencesData_listAllGeoFences_data
  ];
  @override
  final String wireName = 'GlistAllGeoFencesData_listAllGeoFences_data';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GlistAllGeoFencesData_listAllGeoFences_data object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.JsonObject)));
    }
    return result;
  }

  @override
  GlistAllGeoFencesData_listAllGeoFences_data deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GlistAllGeoFencesData_listAllGeoFences_dataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'data':
          result.data = serializers.deserialize(value,
              specifiedType: const FullType(_i2.JsonObject)) as _i2.JsonObject?;
          break;
      }
    }

    return result.build();
  }
}

class _$GlistAllGeoFencesData extends GlistAllGeoFencesData {
  @override
  final String G__typename;
  @override
  final GlistAllGeoFencesData_listAllGeoFences? listAllGeoFences;

  factory _$GlistAllGeoFencesData(
          [void Function(GlistAllGeoFencesDataBuilder)? updates]) =>
      (GlistAllGeoFencesDataBuilder()..update(updates))._build();

  _$GlistAllGeoFencesData._({required this.G__typename, this.listAllGeoFences})
      : super._();
  @override
  GlistAllGeoFencesData rebuild(
          void Function(GlistAllGeoFencesDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GlistAllGeoFencesDataBuilder toBuilder() =>
      GlistAllGeoFencesDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlistAllGeoFencesData &&
        G__typename == other.G__typename &&
        listAllGeoFences == other.listAllGeoFences;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, listAllGeoFences.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GlistAllGeoFencesData')
          ..add('G__typename', G__typename)
          ..add('listAllGeoFences', listAllGeoFences))
        .toString();
  }
}

class GlistAllGeoFencesDataBuilder
    implements Builder<GlistAllGeoFencesData, GlistAllGeoFencesDataBuilder> {
  _$GlistAllGeoFencesData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GlistAllGeoFencesData_listAllGeoFencesBuilder? _listAllGeoFences;
  GlistAllGeoFencesData_listAllGeoFencesBuilder get listAllGeoFences =>
      _$this._listAllGeoFences ??=
          GlistAllGeoFencesData_listAllGeoFencesBuilder();
  set listAllGeoFences(
          GlistAllGeoFencesData_listAllGeoFencesBuilder? listAllGeoFences) =>
      _$this._listAllGeoFences = listAllGeoFences;

  GlistAllGeoFencesDataBuilder() {
    GlistAllGeoFencesData._initializeBuilder(this);
  }

  GlistAllGeoFencesDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _listAllGeoFences = $v.listAllGeoFences?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GlistAllGeoFencesData other) {
    _$v = other as _$GlistAllGeoFencesData;
  }

  @override
  void update(void Function(GlistAllGeoFencesDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GlistAllGeoFencesData build() => _build();

  _$GlistAllGeoFencesData _build() {
    _$GlistAllGeoFencesData _$result;
    try {
      _$result = _$v ??
          _$GlistAllGeoFencesData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GlistAllGeoFencesData', 'G__typename'),
            listAllGeoFences: _listAllGeoFences?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'listAllGeoFences';
        _listAllGeoFences?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GlistAllGeoFencesData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GlistAllGeoFencesData_listAllGeoFences
    extends GlistAllGeoFencesData_listAllGeoFences {
  @override
  final String G__typename;
  @override
  final BuiltList<GlistAllGeoFencesData_listAllGeoFences_data?>? data;
  @override
  final int? totalCount;

  factory _$GlistAllGeoFencesData_listAllGeoFences(
          [void Function(GlistAllGeoFencesData_listAllGeoFencesBuilder)?
              updates]) =>
      (GlistAllGeoFencesData_listAllGeoFencesBuilder()..update(updates))
          ._build();

  _$GlistAllGeoFencesData_listAllGeoFences._(
      {required this.G__typename, this.data, this.totalCount})
      : super._();
  @override
  GlistAllGeoFencesData_listAllGeoFences rebuild(
          void Function(GlistAllGeoFencesData_listAllGeoFencesBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GlistAllGeoFencesData_listAllGeoFencesBuilder toBuilder() =>
      GlistAllGeoFencesData_listAllGeoFencesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlistAllGeoFencesData_listAllGeoFences &&
        G__typename == other.G__typename &&
        data == other.data &&
        totalCount == other.totalCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GlistAllGeoFencesData_listAllGeoFences')
          ..add('G__typename', G__typename)
          ..add('data', data)
          ..add('totalCount', totalCount))
        .toString();
  }
}

class GlistAllGeoFencesData_listAllGeoFencesBuilder
    implements
        Builder<GlistAllGeoFencesData_listAllGeoFences,
            GlistAllGeoFencesData_listAllGeoFencesBuilder> {
  _$GlistAllGeoFencesData_listAllGeoFences? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GlistAllGeoFencesData_listAllGeoFences_data?>? _data;
  ListBuilder<GlistAllGeoFencesData_listAllGeoFences_data?> get data =>
      _$this._data ??=
          ListBuilder<GlistAllGeoFencesData_listAllGeoFences_data?>();
  set data(ListBuilder<GlistAllGeoFencesData_listAllGeoFences_data?>? data) =>
      _$this._data = data;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  GlistAllGeoFencesData_listAllGeoFencesBuilder() {
    GlistAllGeoFencesData_listAllGeoFences._initializeBuilder(this);
  }

  GlistAllGeoFencesData_listAllGeoFencesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _data = $v.data?.toBuilder();
      _totalCount = $v.totalCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GlistAllGeoFencesData_listAllGeoFences other) {
    _$v = other as _$GlistAllGeoFencesData_listAllGeoFences;
  }

  @override
  void update(
      void Function(GlistAllGeoFencesData_listAllGeoFencesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GlistAllGeoFencesData_listAllGeoFences build() => _build();

  _$GlistAllGeoFencesData_listAllGeoFences _build() {
    _$GlistAllGeoFencesData_listAllGeoFences _$result;
    try {
      _$result = _$v ??
          _$GlistAllGeoFencesData_listAllGeoFences._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GlistAllGeoFencesData_listAllGeoFences', 'G__typename'),
            data: _data?.build(),
            totalCount: totalCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GlistAllGeoFencesData_listAllGeoFences',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GlistAllGeoFencesData_listAllGeoFences_data
    extends GlistAllGeoFencesData_listAllGeoFences_data {
  @override
  final String G__typename;
  @override
  final String? type;
  @override
  final _i2.JsonObject? data;

  factory _$GlistAllGeoFencesData_listAllGeoFences_data(
          [void Function(GlistAllGeoFencesData_listAllGeoFences_dataBuilder)?
              updates]) =>
      (GlistAllGeoFencesData_listAllGeoFences_dataBuilder()..update(updates))
          ._build();

  _$GlistAllGeoFencesData_listAllGeoFences_data._(
      {required this.G__typename, this.type, this.data})
      : super._();
  @override
  GlistAllGeoFencesData_listAllGeoFences_data rebuild(
          void Function(GlistAllGeoFencesData_listAllGeoFences_dataBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GlistAllGeoFencesData_listAllGeoFences_dataBuilder toBuilder() =>
      GlistAllGeoFencesData_listAllGeoFences_dataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlistAllGeoFencesData_listAllGeoFences_data &&
        G__typename == other.G__typename &&
        type == other.type &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GlistAllGeoFencesData_listAllGeoFences_data')
          ..add('G__typename', G__typename)
          ..add('type', type)
          ..add('data', data))
        .toString();
  }
}

class GlistAllGeoFencesData_listAllGeoFences_dataBuilder
    implements
        Builder<GlistAllGeoFencesData_listAllGeoFences_data,
            GlistAllGeoFencesData_listAllGeoFences_dataBuilder> {
  _$GlistAllGeoFencesData_listAllGeoFences_data? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  _i2.JsonObject? _data;
  _i2.JsonObject? get data => _$this._data;
  set data(_i2.JsonObject? data) => _$this._data = data;

  GlistAllGeoFencesData_listAllGeoFences_dataBuilder() {
    GlistAllGeoFencesData_listAllGeoFences_data._initializeBuilder(this);
  }

  GlistAllGeoFencesData_listAllGeoFences_dataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _type = $v.type;
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GlistAllGeoFencesData_listAllGeoFences_data other) {
    _$v = other as _$GlistAllGeoFencesData_listAllGeoFences_data;
  }

  @override
  void update(
      void Function(GlistAllGeoFencesData_listAllGeoFences_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GlistAllGeoFencesData_listAllGeoFences_data build() => _build();

  _$GlistAllGeoFencesData_listAllGeoFences_data _build() {
    final _$result = _$v ??
        _$GlistAllGeoFencesData_listAllGeoFences_data._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GlistAllGeoFencesData_listAllGeoFences_data', 'G__typename'),
          type: type,
          data: data,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

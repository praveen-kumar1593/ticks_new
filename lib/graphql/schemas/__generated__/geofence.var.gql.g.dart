// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofence.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GlistAllGeoFencesVars> _$glistAllGeoFencesVarsSerializer =
    _$GlistAllGeoFencesVarsSerializer();

class _$GlistAllGeoFencesVarsSerializer
    implements StructuredSerializer<GlistAllGeoFencesVars> {
  @override
  final Iterable<Type> types = const [
    GlistAllGeoFencesVars,
    _$GlistAllGeoFencesVars
  ];
  @override
  final String wireName = 'GlistAllGeoFencesVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GlistAllGeoFencesVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.GgeofenceList)));
    }
    return result;
  }

  @override
  GlistAllGeoFencesVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GlistAllGeoFencesVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GgeofenceList))!
              as _i1.GgeofenceList);
          break;
      }
    }

    return result.build();
  }
}

class _$GlistAllGeoFencesVars extends GlistAllGeoFencesVars {
  @override
  final _i1.GgeofenceList? data;

  factory _$GlistAllGeoFencesVars(
          [void Function(GlistAllGeoFencesVarsBuilder)? updates]) =>
      (GlistAllGeoFencesVarsBuilder()..update(updates))._build();

  _$GlistAllGeoFencesVars._({this.data}) : super._();
  @override
  GlistAllGeoFencesVars rebuild(
          void Function(GlistAllGeoFencesVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GlistAllGeoFencesVarsBuilder toBuilder() =>
      GlistAllGeoFencesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlistAllGeoFencesVars && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GlistAllGeoFencesVars')
          ..add('data', data))
        .toString();
  }
}

class GlistAllGeoFencesVarsBuilder
    implements Builder<GlistAllGeoFencesVars, GlistAllGeoFencesVarsBuilder> {
  _$GlistAllGeoFencesVars? _$v;

  _i1.GgeofenceListBuilder? _data;
  _i1.GgeofenceListBuilder get data =>
      _$this._data ??= _i1.GgeofenceListBuilder();
  set data(_i1.GgeofenceListBuilder? data) => _$this._data = data;

  GlistAllGeoFencesVarsBuilder();

  GlistAllGeoFencesVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GlistAllGeoFencesVars other) {
    _$v = other as _$GlistAllGeoFencesVars;
  }

  @override
  void update(void Function(GlistAllGeoFencesVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GlistAllGeoFencesVars build() => _build();

  _$GlistAllGeoFencesVars _build() {
    _$GlistAllGeoFencesVars _$result;
    try {
      _$result = _$v ??
          _$GlistAllGeoFencesVars._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GlistAllGeoFencesVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

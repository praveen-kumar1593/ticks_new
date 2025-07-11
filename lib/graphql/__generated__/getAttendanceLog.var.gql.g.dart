// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getAttendanceLog.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GgetAttendanceLogVars> _$ggetAttendanceLogVarsSerializer =
    _$GgetAttendanceLogVarsSerializer();

class _$GgetAttendanceLogVarsSerializer
    implements StructuredSerializer<GgetAttendanceLogVars> {
  @override
  final Iterable<Type> types = const [
    GgetAttendanceLogVars,
    _$GgetAttendanceLogVars
  ];
  @override
  final String wireName = 'GgetAttendanceLogVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetAttendanceLogVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.GAttendanceLogInput)));
    }
    return result;
  }

  @override
  GgetAttendanceLogVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GgetAttendanceLogVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GAttendanceLogInput))!
              as _i1.GAttendanceLogInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetAttendanceLogVars extends GgetAttendanceLogVars {
  @override
  final _i1.GAttendanceLogInput? data;

  factory _$GgetAttendanceLogVars(
          [void Function(GgetAttendanceLogVarsBuilder)? updates]) =>
      (GgetAttendanceLogVarsBuilder()..update(updates))._build();

  _$GgetAttendanceLogVars._({this.data}) : super._();
  @override
  GgetAttendanceLogVars rebuild(
          void Function(GgetAttendanceLogVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetAttendanceLogVarsBuilder toBuilder() =>
      GgetAttendanceLogVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetAttendanceLogVars && data == other.data;
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
    return (newBuiltValueToStringHelper(r'GgetAttendanceLogVars')
          ..add('data', data))
        .toString();
  }
}

class GgetAttendanceLogVarsBuilder
    implements Builder<GgetAttendanceLogVars, GgetAttendanceLogVarsBuilder> {
  _$GgetAttendanceLogVars? _$v;

  _i1.GAttendanceLogInputBuilder? _data;
  _i1.GAttendanceLogInputBuilder get data =>
      _$this._data ??= _i1.GAttendanceLogInputBuilder();
  set data(_i1.GAttendanceLogInputBuilder? data) => _$this._data = data;

  GgetAttendanceLogVarsBuilder();

  GgetAttendanceLogVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetAttendanceLogVars other) {
    _$v = other as _$GgetAttendanceLogVars;
  }

  @override
  void update(void Function(GgetAttendanceLogVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GgetAttendanceLogVars build() => _build();

  _$GgetAttendanceLogVars _build() {
    _$GgetAttendanceLogVars _$result;
    try {
      _$result = _$v ??
          _$GgetAttendanceLogVars._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GgetAttendanceLogVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

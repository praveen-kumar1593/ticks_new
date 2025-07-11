// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markUserAttendance.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkUserAttendanceVars> _$gMarkUserAttendanceVarsSerializer =
    _$GMarkUserAttendanceVarsSerializer();

class _$GMarkUserAttendanceVarsSerializer
    implements StructuredSerializer<GMarkUserAttendanceVars> {
  @override
  final Iterable<Type> types = const [
    GMarkUserAttendanceVars,
    _$GMarkUserAttendanceVars
  ];
  @override
  final String wireName = 'GMarkUserAttendanceVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkUserAttendanceVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(_i1.GUserAttendanceInput)),
    ];

    return result;
  }

  @override
  GMarkUserAttendanceVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkUserAttendanceVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GUserAttendanceInput))!
              as _i1.GUserAttendanceInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkUserAttendanceVars extends GMarkUserAttendanceVars {
  @override
  final _i1.GUserAttendanceInput data;

  factory _$GMarkUserAttendanceVars(
          [void Function(GMarkUserAttendanceVarsBuilder)? updates]) =>
      (GMarkUserAttendanceVarsBuilder()..update(updates))._build();

  _$GMarkUserAttendanceVars._({required this.data}) : super._();
  @override
  GMarkUserAttendanceVars rebuild(
          void Function(GMarkUserAttendanceVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkUserAttendanceVarsBuilder toBuilder() =>
      GMarkUserAttendanceVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkUserAttendanceVars && data == other.data;
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
    return (newBuiltValueToStringHelper(r'GMarkUserAttendanceVars')
          ..add('data', data))
        .toString();
  }
}

class GMarkUserAttendanceVarsBuilder
    implements
        Builder<GMarkUserAttendanceVars, GMarkUserAttendanceVarsBuilder> {
  _$GMarkUserAttendanceVars? _$v;

  _i1.GUserAttendanceInputBuilder? _data;
  _i1.GUserAttendanceInputBuilder get data =>
      _$this._data ??= _i1.GUserAttendanceInputBuilder();
  set data(_i1.GUserAttendanceInputBuilder? data) => _$this._data = data;

  GMarkUserAttendanceVarsBuilder();

  GMarkUserAttendanceVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkUserAttendanceVars other) {
    _$v = other as _$GMarkUserAttendanceVars;
  }

  @override
  void update(void Function(GMarkUserAttendanceVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkUserAttendanceVars build() => _build();

  _$GMarkUserAttendanceVars _build() {
    _$GMarkUserAttendanceVars _$result;
    try {
      _$result = _$v ??
          _$GMarkUserAttendanceVars._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMarkUserAttendanceVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

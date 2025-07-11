// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markAttendanceSync.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GmarkAttendanceSyncVars> _$gmarkAttendanceSyncVarsSerializer =
    _$GmarkAttendanceSyncVarsSerializer();

class _$GmarkAttendanceSyncVarsSerializer
    implements StructuredSerializer<GmarkAttendanceSyncVars> {
  @override
  final Iterable<Type> types = const [
    GmarkAttendanceSyncVars,
    _$GmarkAttendanceSyncVars
  ];
  @override
  final String wireName = 'GmarkAttendanceSyncVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GmarkAttendanceSyncVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList,
                const [const FullType(_i1.GUserAttendanceBulkInput)])));
    }
    return result;
  }

  @override
  GmarkAttendanceSyncVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GmarkAttendanceSyncVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(_i1.GUserAttendanceBulkInput)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GmarkAttendanceSyncVars extends GmarkAttendanceSyncVars {
  @override
  final BuiltList<_i1.GUserAttendanceBulkInput>? data;

  factory _$GmarkAttendanceSyncVars(
          [void Function(GmarkAttendanceSyncVarsBuilder)? updates]) =>
      (GmarkAttendanceSyncVarsBuilder()..update(updates))._build();

  _$GmarkAttendanceSyncVars._({this.data}) : super._();
  @override
  GmarkAttendanceSyncVars rebuild(
          void Function(GmarkAttendanceSyncVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GmarkAttendanceSyncVarsBuilder toBuilder() =>
      GmarkAttendanceSyncVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GmarkAttendanceSyncVars && data == other.data;
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
    return (newBuiltValueToStringHelper(r'GmarkAttendanceSyncVars')
          ..add('data', data))
        .toString();
  }
}

class GmarkAttendanceSyncVarsBuilder
    implements
        Builder<GmarkAttendanceSyncVars, GmarkAttendanceSyncVarsBuilder> {
  _$GmarkAttendanceSyncVars? _$v;

  ListBuilder<_i1.GUserAttendanceBulkInput>? _data;
  ListBuilder<_i1.GUserAttendanceBulkInput> get data =>
      _$this._data ??= ListBuilder<_i1.GUserAttendanceBulkInput>();
  set data(ListBuilder<_i1.GUserAttendanceBulkInput>? data) =>
      _$this._data = data;

  GmarkAttendanceSyncVarsBuilder();

  GmarkAttendanceSyncVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GmarkAttendanceSyncVars other) {
    _$v = other as _$GmarkAttendanceSyncVars;
  }

  @override
  void update(void Function(GmarkAttendanceSyncVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GmarkAttendanceSyncVars build() => _build();

  _$GmarkAttendanceSyncVars _build() {
    _$GmarkAttendanceSyncVars _$result;
    try {
      _$result = _$v ??
          _$GmarkAttendanceSyncVars._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GmarkAttendanceSyncVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

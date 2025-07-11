// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetchUserAttendanceStatus.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GfetchUserAttendanceStatusVars>
    _$gfetchUserAttendanceStatusVarsSerializer =
    _$GfetchUserAttendanceStatusVarsSerializer();

class _$GfetchUserAttendanceStatusVarsSerializer
    implements StructuredSerializer<GfetchUserAttendanceStatusVars> {
  @override
  final Iterable<Type> types = const [
    GfetchUserAttendanceStatusVars,
    _$GfetchUserAttendanceStatusVars
  ];
  @override
  final String wireName = 'GfetchUserAttendanceStatusVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GfetchUserAttendanceStatusVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GfetchUserAttendanceStatusVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GfetchUserAttendanceStatusVarsBuilder().build();
  }
}

class _$GfetchUserAttendanceStatusVars extends GfetchUserAttendanceStatusVars {
  factory _$GfetchUserAttendanceStatusVars(
          [void Function(GfetchUserAttendanceStatusVarsBuilder)? updates]) =>
      (GfetchUserAttendanceStatusVarsBuilder()..update(updates))._build();

  _$GfetchUserAttendanceStatusVars._() : super._();
  @override
  GfetchUserAttendanceStatusVars rebuild(
          void Function(GfetchUserAttendanceStatusVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfetchUserAttendanceStatusVarsBuilder toBuilder() =>
      GfetchUserAttendanceStatusVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GfetchUserAttendanceStatusVars;
  }

  @override
  int get hashCode {
    return 585106980;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GfetchUserAttendanceStatusVars')
        .toString();
  }
}

class GfetchUserAttendanceStatusVarsBuilder
    implements
        Builder<GfetchUserAttendanceStatusVars,
            GfetchUserAttendanceStatusVarsBuilder> {
  _$GfetchUserAttendanceStatusVars? _$v;

  GfetchUserAttendanceStatusVarsBuilder();

  @override
  void replace(GfetchUserAttendanceStatusVars other) {
    _$v = other as _$GfetchUserAttendanceStatusVars;
  }

  @override
  void update(void Function(GfetchUserAttendanceStatusVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GfetchUserAttendanceStatusVars build() => _build();

  _$GfetchUserAttendanceStatusVars _build() {
    final _$result = _$v ?? _$GfetchUserAttendanceStatusVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

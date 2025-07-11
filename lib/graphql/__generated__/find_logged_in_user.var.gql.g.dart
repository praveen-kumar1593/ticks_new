// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_logged_in_user.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GfindLoggedInUserVars> _$gfindLoggedInUserVarsSerializer =
    _$GfindLoggedInUserVarsSerializer();

class _$GfindLoggedInUserVarsSerializer
    implements StructuredSerializer<GfindLoggedInUserVars> {
  @override
  final Iterable<Type> types = const [
    GfindLoggedInUserVars,
    _$GfindLoggedInUserVars
  ];
  @override
  final String wireName = 'GfindLoggedInUserVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GfindLoggedInUserVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GfindLoggedInUserVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GfindLoggedInUserVarsBuilder().build();
  }
}

class _$GfindLoggedInUserVars extends GfindLoggedInUserVars {
  factory _$GfindLoggedInUserVars(
          [void Function(GfindLoggedInUserVarsBuilder)? updates]) =>
      (GfindLoggedInUserVarsBuilder()..update(updates))._build();

  _$GfindLoggedInUserVars._() : super._();
  @override
  GfindLoggedInUserVars rebuild(
          void Function(GfindLoggedInUserVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfindLoggedInUserVarsBuilder toBuilder() =>
      GfindLoggedInUserVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GfindLoggedInUserVars;
  }

  @override
  int get hashCode {
    return 892335410;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GfindLoggedInUserVars').toString();
  }
}

class GfindLoggedInUserVarsBuilder
    implements Builder<GfindLoggedInUserVars, GfindLoggedInUserVarsBuilder> {
  _$GfindLoggedInUserVars? _$v;

  GfindLoggedInUserVarsBuilder();

  @override
  void replace(GfindLoggedInUserVars other) {
    _$v = other as _$GfindLoggedInUserVars;
  }

  @override
  void update(void Function(GfindLoggedInUserVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GfindLoggedInUserVars build() => _build();

  _$GfindLoggedInUserVars _build() {
    final _$result = _$v ?? _$GfindLoggedInUserVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

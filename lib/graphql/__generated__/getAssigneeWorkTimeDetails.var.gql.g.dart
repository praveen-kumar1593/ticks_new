// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getAssigneeWorkTimeDetails.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetAssigneeWorkTimeDetailsVars>
    _$gGetAssigneeWorkTimeDetailsVarsSerializer =
    _$GGetAssigneeWorkTimeDetailsVarsSerializer();

class _$GGetAssigneeWorkTimeDetailsVarsSerializer
    implements StructuredSerializer<GGetAssigneeWorkTimeDetailsVars> {
  @override
  final Iterable<Type> types = const [
    GGetAssigneeWorkTimeDetailsVars,
    _$GGetAssigneeWorkTimeDetailsVars
  ];
  @override
  final String wireName = 'GGetAssigneeWorkTimeDetailsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetAssigneeWorkTimeDetailsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GGetAssigneeWorkTimeDetailsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GGetAssigneeWorkTimeDetailsVarsBuilder().build();
  }
}

class _$GGetAssigneeWorkTimeDetailsVars
    extends GGetAssigneeWorkTimeDetailsVars {
  factory _$GGetAssigneeWorkTimeDetailsVars(
          [void Function(GGetAssigneeWorkTimeDetailsVarsBuilder)? updates]) =>
      (GGetAssigneeWorkTimeDetailsVarsBuilder()..update(updates))._build();

  _$GGetAssigneeWorkTimeDetailsVars._() : super._();
  @override
  GGetAssigneeWorkTimeDetailsVars rebuild(
          void Function(GGetAssigneeWorkTimeDetailsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetAssigneeWorkTimeDetailsVarsBuilder toBuilder() =>
      GGetAssigneeWorkTimeDetailsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetAssigneeWorkTimeDetailsVars;
  }

  @override
  int get hashCode {
    return 861207618;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetAssigneeWorkTimeDetailsVars')
        .toString();
  }
}

class GGetAssigneeWorkTimeDetailsVarsBuilder
    implements
        Builder<GGetAssigneeWorkTimeDetailsVars,
            GGetAssigneeWorkTimeDetailsVarsBuilder> {
  _$GGetAssigneeWorkTimeDetailsVars? _$v;

  GGetAssigneeWorkTimeDetailsVarsBuilder();

  @override
  void replace(GGetAssigneeWorkTimeDetailsVars other) {
    _$v = other as _$GGetAssigneeWorkTimeDetailsVars;
  }

  @override
  void update(void Function(GGetAssigneeWorkTimeDetailsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetAssigneeWorkTimeDetailsVars build() => _build();

  _$GGetAssigneeWorkTimeDetailsVars _build() {
    final _$result = _$v ?? _$GGetAssigneeWorkTimeDetailsVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

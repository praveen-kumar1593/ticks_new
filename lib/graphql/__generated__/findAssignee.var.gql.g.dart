// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'findAssignee.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GfindAssigneeVars> _$gfindAssigneeVarsSerializer =
    _$GfindAssigneeVarsSerializer();

class _$GfindAssigneeVarsSerializer
    implements StructuredSerializer<GfindAssigneeVars> {
  @override
  final Iterable<Type> types = const [GfindAssigneeVars, _$GfindAssigneeVars];
  @override
  final String wireName = 'GfindAssigneeVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GfindAssigneeVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GfindAssigneeVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GfindAssigneeVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GfindAssigneeVars extends GfindAssigneeVars {
  @override
  final String id;

  factory _$GfindAssigneeVars(
          [void Function(GfindAssigneeVarsBuilder)? updates]) =>
      (GfindAssigneeVarsBuilder()..update(updates))._build();

  _$GfindAssigneeVars._({required this.id}) : super._();
  @override
  GfindAssigneeVars rebuild(void Function(GfindAssigneeVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfindAssigneeVarsBuilder toBuilder() =>
      GfindAssigneeVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GfindAssigneeVars && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GfindAssigneeVars')..add('id', id))
        .toString();
  }
}

class GfindAssigneeVarsBuilder
    implements Builder<GfindAssigneeVars, GfindAssigneeVarsBuilder> {
  _$GfindAssigneeVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GfindAssigneeVarsBuilder();

  GfindAssigneeVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GfindAssigneeVars other) {
    _$v = other as _$GfindAssigneeVars;
  }

  @override
  void update(void Function(GfindAssigneeVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GfindAssigneeVars build() => _build();

  _$GfindAssigneeVars _build() {
    final _$result = _$v ??
        _$GfindAssigneeVars._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GfindAssigneeVars', 'id'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

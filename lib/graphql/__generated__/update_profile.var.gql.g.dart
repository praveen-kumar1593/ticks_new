// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GupdateProfileVars> _$gupdateProfileVarsSerializer =
    _$GupdateProfileVarsSerializer();

class _$GupdateProfileVarsSerializer
    implements StructuredSerializer<GupdateProfileVars> {
  @override
  final Iterable<Type> types = const [GupdateProfileVars, _$GupdateProfileVars];
  @override
  final String wireName = 'GupdateProfileVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GupdateProfileVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.JsonObject)));
    }
    return result;
  }

  @override
  GupdateProfileVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GupdateProfileVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(_i1.JsonObject)) as _i1.JsonObject?;
          break;
      }
    }

    return result.build();
  }
}

class _$GupdateProfileVars extends GupdateProfileVars {
  @override
  final _i1.JsonObject? user;

  factory _$GupdateProfileVars(
          [void Function(GupdateProfileVarsBuilder)? updates]) =>
      (GupdateProfileVarsBuilder()..update(updates))._build();

  _$GupdateProfileVars._({this.user}) : super._();
  @override
  GupdateProfileVars rebuild(
          void Function(GupdateProfileVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GupdateProfileVarsBuilder toBuilder() =>
      GupdateProfileVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GupdateProfileVars && user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GupdateProfileVars')
          ..add('user', user))
        .toString();
  }
}

class GupdateProfileVarsBuilder
    implements Builder<GupdateProfileVars, GupdateProfileVarsBuilder> {
  _$GupdateProfileVars? _$v;

  _i1.JsonObject? _user;
  _i1.JsonObject? get user => _$this._user;
  set user(_i1.JsonObject? user) => _$this._user = user;

  GupdateProfileVarsBuilder();

  GupdateProfileVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GupdateProfileVars other) {
    _$v = other as _$GupdateProfileVars;
  }

  @override
  void update(void Function(GupdateProfileVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GupdateProfileVars build() => _build();

  _$GupdateProfileVars _build() {
    final _$result = _$v ??
        _$GupdateProfileVars._(
          user: user,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

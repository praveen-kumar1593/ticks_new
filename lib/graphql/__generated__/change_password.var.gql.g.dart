// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GchangePasswordVars> _$gchangePasswordVarsSerializer =
    _$GchangePasswordVarsSerializer();

class _$GchangePasswordVarsSerializer
    implements StructuredSerializer<GchangePasswordVars> {
  @override
  final Iterable<Type> types = const [
    GchangePasswordVars,
    _$GchangePasswordVars
  ];
  @override
  final String wireName = 'GchangePasswordVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GchangePasswordVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'newPassword',
      serializers.serialize(object.newPassword,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GchangePasswordVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GchangePasswordVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'newPassword':
          result.newPassword = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GchangePasswordVars extends GchangePasswordVars {
  @override
  final String password;
  @override
  final String newPassword;

  factory _$GchangePasswordVars(
          [void Function(GchangePasswordVarsBuilder)? updates]) =>
      (GchangePasswordVarsBuilder()..update(updates))._build();

  _$GchangePasswordVars._({required this.password, required this.newPassword})
      : super._();
  @override
  GchangePasswordVars rebuild(
          void Function(GchangePasswordVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GchangePasswordVarsBuilder toBuilder() =>
      GchangePasswordVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GchangePasswordVars &&
        password == other.password &&
        newPassword == other.newPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GchangePasswordVars')
          ..add('password', password)
          ..add('newPassword', newPassword))
        .toString();
  }
}

class GchangePasswordVarsBuilder
    implements Builder<GchangePasswordVars, GchangePasswordVarsBuilder> {
  _$GchangePasswordVars? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  GchangePasswordVarsBuilder();

  GchangePasswordVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _newPassword = $v.newPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GchangePasswordVars other) {
    _$v = other as _$GchangePasswordVars;
  }

  @override
  void update(void Function(GchangePasswordVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GchangePasswordVars build() => _build();

  _$GchangePasswordVars _build() {
    final _$result = _$v ??
        _$GchangePasswordVars._(
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'GchangePasswordVars', 'password'),
          newPassword: BuiltValueNullFieldError.checkNotNull(
              newPassword, r'GchangePasswordVars', 'newPassword'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

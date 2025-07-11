// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRefreshVars> _$gRefreshVarsSerializer = _$GRefreshVarsSerializer();

class _$GRefreshVarsSerializer implements StructuredSerializer<GRefreshVars> {
  @override
  final Iterable<Type> types = const [GRefreshVars, _$GRefreshVars];
  @override
  final String wireName = 'GRefreshVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GRefreshVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'refreshToken',
      serializers.serialize(object.refreshToken,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRefreshVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRefreshVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'refreshToken':
          result.refreshToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshVars extends GRefreshVars {
  @override
  final String refreshToken;

  factory _$GRefreshVars([void Function(GRefreshVarsBuilder)? updates]) =>
      (GRefreshVarsBuilder()..update(updates))._build();

  _$GRefreshVars._({required this.refreshToken}) : super._();
  @override
  GRefreshVars rebuild(void Function(GRefreshVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshVarsBuilder toBuilder() => GRefreshVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshVars && refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRefreshVars')
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class GRefreshVarsBuilder
    implements Builder<GRefreshVars, GRefreshVarsBuilder> {
  _$GRefreshVars? _$v;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  GRefreshVarsBuilder();

  GRefreshVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshVars other) {
    _$v = other as _$GRefreshVars;
  }

  @override
  void update(void Function(GRefreshVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshVars build() => _build();

  _$GRefreshVars _build() {
    final _$result = _$v ??
        _$GRefreshVars._(
          refreshToken: BuiltValueNullFieldError.checkNotNull(
              refreshToken, r'GRefreshVars', 'refreshToken'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

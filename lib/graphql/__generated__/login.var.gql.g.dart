// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GloginVars> _$gloginVarsSerializer = _$GloginVarsSerializer();

class _$GloginVarsSerializer implements StructuredSerializer<GloginVars> {
  @override
  final Iterable<Type> types = const [GloginVars, _$GloginVars];
  @override
  final String wireName = 'GloginVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GloginVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.credentials;
    if (value != null) {
      result
        ..add('credentials')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.JsonObject)));
    }
    value = object.isDevMode;
    if (value != null) {
      result
        ..add('isDevMode')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.origin;
    if (value != null) {
      result
        ..add('origin')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GloginVars deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GloginVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'credentials':
          result.credentials = serializers.deserialize(value,
              specifiedType: const FullType(_i1.JsonObject)) as _i1.JsonObject?;
          break;
        case 'isDevMode':
          result.isDevMode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'origin':
          result.origin = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GloginVars extends GloginVars {
  @override
  final _i1.JsonObject? credentials;
  @override
  final bool? isDevMode;
  @override
  final String? origin;

  factory _$GloginVars([void Function(GloginVarsBuilder)? updates]) =>
      (GloginVarsBuilder()..update(updates))._build();

  _$GloginVars._({this.credentials, this.isDevMode, this.origin}) : super._();
  @override
  GloginVars rebuild(void Function(GloginVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GloginVarsBuilder toBuilder() => GloginVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GloginVars &&
        credentials == other.credentials &&
        isDevMode == other.isDevMode &&
        origin == other.origin;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, credentials.hashCode);
    _$hash = $jc(_$hash, isDevMode.hashCode);
    _$hash = $jc(_$hash, origin.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GloginVars')
          ..add('credentials', credentials)
          ..add('isDevMode', isDevMode)
          ..add('origin', origin))
        .toString();
  }
}

class GloginVarsBuilder implements Builder<GloginVars, GloginVarsBuilder> {
  _$GloginVars? _$v;

  _i1.JsonObject? _credentials;
  _i1.JsonObject? get credentials => _$this._credentials;
  set credentials(_i1.JsonObject? credentials) =>
      _$this._credentials = credentials;

  bool? _isDevMode;
  bool? get isDevMode => _$this._isDevMode;
  set isDevMode(bool? isDevMode) => _$this._isDevMode = isDevMode;

  String? _origin;
  String? get origin => _$this._origin;
  set origin(String? origin) => _$this._origin = origin;

  GloginVarsBuilder();

  GloginVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _credentials = $v.credentials;
      _isDevMode = $v.isDevMode;
      _origin = $v.origin;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GloginVars other) {
    _$v = other as _$GloginVars;
  }

  @override
  void update(void Function(GloginVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GloginVars build() => _build();

  _$GloginVars _build() {
    final _$result = _$v ??
        _$GloginVars._(
          credentials: credentials,
          isDevMode: isDevMode,
          origin: origin,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

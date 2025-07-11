// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GchangePasswordData> _$gchangePasswordDataSerializer =
    _$GchangePasswordDataSerializer();

class _$GchangePasswordDataSerializer
    implements StructuredSerializer<GchangePasswordData> {
  @override
  final Iterable<Type> types = const [
    GchangePasswordData,
    _$GchangePasswordData
  ];
  @override
  final String wireName = 'GchangePasswordData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GchangePasswordData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.changePassword;
    if (value != null) {
      result
        ..add('changePassword')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.JsonObject)));
    }
    return result;
  }

  @override
  GchangePasswordData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GchangePasswordDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'changePassword':
          result.changePassword = serializers.deserialize(value,
              specifiedType: const FullType(_i1.JsonObject)) as _i1.JsonObject?;
          break;
      }
    }

    return result.build();
  }
}

class _$GchangePasswordData extends GchangePasswordData {
  @override
  final String G__typename;
  @override
  final _i1.JsonObject? changePassword;

  factory _$GchangePasswordData(
          [void Function(GchangePasswordDataBuilder)? updates]) =>
      (GchangePasswordDataBuilder()..update(updates))._build();

  _$GchangePasswordData._({required this.G__typename, this.changePassword})
      : super._();
  @override
  GchangePasswordData rebuild(
          void Function(GchangePasswordDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GchangePasswordDataBuilder toBuilder() =>
      GchangePasswordDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GchangePasswordData &&
        G__typename == other.G__typename &&
        changePassword == other.changePassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, changePassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GchangePasswordData')
          ..add('G__typename', G__typename)
          ..add('changePassword', changePassword))
        .toString();
  }
}

class GchangePasswordDataBuilder
    implements Builder<GchangePasswordData, GchangePasswordDataBuilder> {
  _$GchangePasswordData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i1.JsonObject? _changePassword;
  _i1.JsonObject? get changePassword => _$this._changePassword;
  set changePassword(_i1.JsonObject? changePassword) =>
      _$this._changePassword = changePassword;

  GchangePasswordDataBuilder() {
    GchangePasswordData._initializeBuilder(this);
  }

  GchangePasswordDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _changePassword = $v.changePassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GchangePasswordData other) {
    _$v = other as _$GchangePasswordData;
  }

  @override
  void update(void Function(GchangePasswordDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GchangePasswordData build() => _build();

  _$GchangePasswordData _build() {
    final _$result = _$v ??
        _$GchangePasswordData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GchangePasswordData', 'G__typename'),
          changePassword: changePassword,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

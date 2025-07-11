// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_logged_in_user.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GfindLoggedInUserData> _$gfindLoggedInUserDataSerializer =
    _$GfindLoggedInUserDataSerializer();

class _$GfindLoggedInUserDataSerializer
    implements StructuredSerializer<GfindLoggedInUserData> {
  @override
  final Iterable<Type> types = const [
    GfindLoggedInUserData,
    _$GfindLoggedInUserData
  ];
  @override
  final String wireName = 'GfindLoggedInUserData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GfindLoggedInUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.findLoggedInUser;
    if (value != null) {
      result
        ..add('findLoggedInUser')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.JsonObject)));
    }
    return result;
  }

  @override
  GfindLoggedInUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GfindLoggedInUserDataBuilder();

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
        case 'findLoggedInUser':
          result.findLoggedInUser = serializers.deserialize(value,
              specifiedType: const FullType(_i1.JsonObject)) as _i1.JsonObject?;
          break;
      }
    }

    return result.build();
  }
}

class _$GfindLoggedInUserData extends GfindLoggedInUserData {
  @override
  final String G__typename;
  @override
  final _i1.JsonObject? findLoggedInUser;

  factory _$GfindLoggedInUserData(
          [void Function(GfindLoggedInUserDataBuilder)? updates]) =>
      (GfindLoggedInUserDataBuilder()..update(updates))._build();

  _$GfindLoggedInUserData._({required this.G__typename, this.findLoggedInUser})
      : super._();
  @override
  GfindLoggedInUserData rebuild(
          void Function(GfindLoggedInUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfindLoggedInUserDataBuilder toBuilder() =>
      GfindLoggedInUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GfindLoggedInUserData &&
        G__typename == other.G__typename &&
        findLoggedInUser == other.findLoggedInUser;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, findLoggedInUser.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GfindLoggedInUserData')
          ..add('G__typename', G__typename)
          ..add('findLoggedInUser', findLoggedInUser))
        .toString();
  }
}

class GfindLoggedInUserDataBuilder
    implements Builder<GfindLoggedInUserData, GfindLoggedInUserDataBuilder> {
  _$GfindLoggedInUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i1.JsonObject? _findLoggedInUser;
  _i1.JsonObject? get findLoggedInUser => _$this._findLoggedInUser;
  set findLoggedInUser(_i1.JsonObject? findLoggedInUser) =>
      _$this._findLoggedInUser = findLoggedInUser;

  GfindLoggedInUserDataBuilder() {
    GfindLoggedInUserData._initializeBuilder(this);
  }

  GfindLoggedInUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _findLoggedInUser = $v.findLoggedInUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GfindLoggedInUserData other) {
    _$v = other as _$GfindLoggedInUserData;
  }

  @override
  void update(void Function(GfindLoggedInUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GfindLoggedInUserData build() => _build();

  _$GfindLoggedInUserData _build() {
    final _$result = _$v ??
        _$GfindLoggedInUserData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GfindLoggedInUserData', 'G__typename'),
          findLoggedInUser: findLoggedInUser,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

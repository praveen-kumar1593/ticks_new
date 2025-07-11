// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GupdateProfileData> _$gupdateProfileDataSerializer =
    _$GupdateProfileDataSerializer();

class _$GupdateProfileDataSerializer
    implements StructuredSerializer<GupdateProfileData> {
  @override
  final Iterable<Type> types = const [GupdateProfileData, _$GupdateProfileData];
  @override
  final String wireName = 'GupdateProfileData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GupdateProfileData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.updateProfile;
    if (value != null) {
      result
        ..add('updateProfile')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.JsonObject)));
    }
    return result;
  }

  @override
  GupdateProfileData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GupdateProfileDataBuilder();

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
        case 'updateProfile':
          result.updateProfile = serializers.deserialize(value,
              specifiedType: const FullType(_i1.JsonObject)) as _i1.JsonObject?;
          break;
      }
    }

    return result.build();
  }
}

class _$GupdateProfileData extends GupdateProfileData {
  @override
  final String G__typename;
  @override
  final _i1.JsonObject? updateProfile;

  factory _$GupdateProfileData(
          [void Function(GupdateProfileDataBuilder)? updates]) =>
      (GupdateProfileDataBuilder()..update(updates))._build();

  _$GupdateProfileData._({required this.G__typename, this.updateProfile})
      : super._();
  @override
  GupdateProfileData rebuild(
          void Function(GupdateProfileDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GupdateProfileDataBuilder toBuilder() =>
      GupdateProfileDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GupdateProfileData &&
        G__typename == other.G__typename &&
        updateProfile == other.updateProfile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateProfile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GupdateProfileData')
          ..add('G__typename', G__typename)
          ..add('updateProfile', updateProfile))
        .toString();
  }
}

class GupdateProfileDataBuilder
    implements Builder<GupdateProfileData, GupdateProfileDataBuilder> {
  _$GupdateProfileData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i1.JsonObject? _updateProfile;
  _i1.JsonObject? get updateProfile => _$this._updateProfile;
  set updateProfile(_i1.JsonObject? updateProfile) =>
      _$this._updateProfile = updateProfile;

  GupdateProfileDataBuilder() {
    GupdateProfileData._initializeBuilder(this);
  }

  GupdateProfileDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateProfile = $v.updateProfile;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GupdateProfileData other) {
    _$v = other as _$GupdateProfileData;
  }

  @override
  void update(void Function(GupdateProfileDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GupdateProfileData build() => _build();

  _$GupdateProfileData _build() {
    final _$result = _$v ??
        _$GupdateProfileData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GupdateProfileData', 'G__typename'),
          updateProfile: updateProfile,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

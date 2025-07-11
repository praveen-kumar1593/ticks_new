// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'findAssignee.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GfindAssigneeData> _$gfindAssigneeDataSerializer =
    _$GfindAssigneeDataSerializer();

class _$GfindAssigneeDataSerializer
    implements StructuredSerializer<GfindAssigneeData> {
  @override
  final Iterable<Type> types = const [GfindAssigneeData, _$GfindAssigneeData];
  @override
  final String wireName = 'GfindAssigneeData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GfindAssigneeData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.findAssignee;
    if (value != null) {
      result
        ..add('findAssignee')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.JsonObject)));
    }
    return result;
  }

  @override
  GfindAssigneeData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GfindAssigneeDataBuilder();

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
        case 'findAssignee':
          result.findAssignee = serializers.deserialize(value,
              specifiedType: const FullType(_i1.JsonObject)) as _i1.JsonObject?;
          break;
      }
    }

    return result.build();
  }
}

class _$GfindAssigneeData extends GfindAssigneeData {
  @override
  final String G__typename;
  @override
  final _i1.JsonObject? findAssignee;

  factory _$GfindAssigneeData(
          [void Function(GfindAssigneeDataBuilder)? updates]) =>
      (GfindAssigneeDataBuilder()..update(updates))._build();

  _$GfindAssigneeData._({required this.G__typename, this.findAssignee})
      : super._();
  @override
  GfindAssigneeData rebuild(void Function(GfindAssigneeDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfindAssigneeDataBuilder toBuilder() =>
      GfindAssigneeDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GfindAssigneeData &&
        G__typename == other.G__typename &&
        findAssignee == other.findAssignee;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, findAssignee.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GfindAssigneeData')
          ..add('G__typename', G__typename)
          ..add('findAssignee', findAssignee))
        .toString();
  }
}

class GfindAssigneeDataBuilder
    implements Builder<GfindAssigneeData, GfindAssigneeDataBuilder> {
  _$GfindAssigneeData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i1.JsonObject? _findAssignee;
  _i1.JsonObject? get findAssignee => _$this._findAssignee;
  set findAssignee(_i1.JsonObject? findAssignee) =>
      _$this._findAssignee = findAssignee;

  GfindAssigneeDataBuilder() {
    GfindAssigneeData._initializeBuilder(this);
  }

  GfindAssigneeDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _findAssignee = $v.findAssignee;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GfindAssigneeData other) {
    _$v = other as _$GfindAssigneeData;
  }

  @override
  void update(void Function(GfindAssigneeDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GfindAssigneeData build() => _build();

  _$GfindAssigneeData _build() {
    final _$result = _$v ??
        _$GfindAssigneeData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GfindAssigneeData', 'G__typename'),
          findAssignee: findAssignee,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

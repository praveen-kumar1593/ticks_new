// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRefreshData> _$gRefreshDataSerializer = _$GRefreshDataSerializer();

class _$GRefreshDataSerializer implements StructuredSerializer<GRefreshData> {
  @override
  final Iterable<Type> types = const [GRefreshData, _$GRefreshData];
  @override
  final String wireName = 'GRefreshData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GRefreshData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.refresh;
    if (value != null) {
      result
        ..add('refresh')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.JsonObject)));
    }
    return result;
  }

  @override
  GRefreshData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRefreshDataBuilder();

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
        case 'refresh':
          result.refresh = serializers.deserialize(value,
              specifiedType: const FullType(_i1.JsonObject)) as _i1.JsonObject?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshData extends GRefreshData {
  @override
  final String G__typename;
  @override
  final _i1.JsonObject? refresh;

  factory _$GRefreshData([void Function(GRefreshDataBuilder)? updates]) =>
      (GRefreshDataBuilder()..update(updates))._build();

  _$GRefreshData._({required this.G__typename, this.refresh}) : super._();
  @override
  GRefreshData rebuild(void Function(GRefreshDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshDataBuilder toBuilder() => GRefreshDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshData &&
        G__typename == other.G__typename &&
        refresh == other.refresh;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, refresh.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRefreshData')
          ..add('G__typename', G__typename)
          ..add('refresh', refresh))
        .toString();
  }
}

class GRefreshDataBuilder
    implements Builder<GRefreshData, GRefreshDataBuilder> {
  _$GRefreshData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i1.JsonObject? _refresh;
  _i1.JsonObject? get refresh => _$this._refresh;
  set refresh(_i1.JsonObject? refresh) => _$this._refresh = refresh;

  GRefreshDataBuilder() {
    GRefreshData._initializeBuilder(this);
  }

  GRefreshDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _refresh = $v.refresh;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshData other) {
    _$v = other as _$GRefreshData;
  }

  @override
  void update(void Function(GRefreshDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshData build() => _build();

  _$GRefreshData _build() {
    final _$result = _$v ??
        _$GRefreshData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GRefreshData', 'G__typename'),
          refresh: refresh,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

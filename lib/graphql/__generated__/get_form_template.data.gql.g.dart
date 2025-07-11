// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_form_template.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GgetFormTemplateData> _$ggetFormTemplateDataSerializer =
    _$GgetFormTemplateDataSerializer();

class _$GgetFormTemplateDataSerializer
    implements StructuredSerializer<GgetFormTemplateData> {
  @override
  final Iterable<Type> types = const [
    GgetFormTemplateData,
    _$GgetFormTemplateData
  ];
  @override
  final String wireName = 'GgetFormTemplateData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetFormTemplateData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.getFormTemplate;
    if (value != null) {
      result
        ..add('getFormTemplate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.JsonObject)));
    }
    return result;
  }

  @override
  GgetFormTemplateData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GgetFormTemplateDataBuilder();

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
        case 'getFormTemplate':
          result.getFormTemplate = serializers.deserialize(value,
              specifiedType: const FullType(_i1.JsonObject)) as _i1.JsonObject?;
          break;
      }
    }

    return result.build();
  }
}

class _$GgetFormTemplateData extends GgetFormTemplateData {
  @override
  final String G__typename;
  @override
  final _i1.JsonObject? getFormTemplate;

  factory _$GgetFormTemplateData(
          [void Function(GgetFormTemplateDataBuilder)? updates]) =>
      (GgetFormTemplateDataBuilder()..update(updates))._build();

  _$GgetFormTemplateData._({required this.G__typename, this.getFormTemplate})
      : super._();
  @override
  GgetFormTemplateData rebuild(
          void Function(GgetFormTemplateDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetFormTemplateDataBuilder toBuilder() =>
      GgetFormTemplateDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetFormTemplateData &&
        G__typename == other.G__typename &&
        getFormTemplate == other.getFormTemplate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getFormTemplate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GgetFormTemplateData')
          ..add('G__typename', G__typename)
          ..add('getFormTemplate', getFormTemplate))
        .toString();
  }
}

class GgetFormTemplateDataBuilder
    implements Builder<GgetFormTemplateData, GgetFormTemplateDataBuilder> {
  _$GgetFormTemplateData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i1.JsonObject? _getFormTemplate;
  _i1.JsonObject? get getFormTemplate => _$this._getFormTemplate;
  set getFormTemplate(_i1.JsonObject? getFormTemplate) =>
      _$this._getFormTemplate = getFormTemplate;

  GgetFormTemplateDataBuilder() {
    GgetFormTemplateData._initializeBuilder(this);
  }

  GgetFormTemplateDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getFormTemplate = $v.getFormTemplate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetFormTemplateData other) {
    _$v = other as _$GgetFormTemplateData;
  }

  @override
  void update(void Function(GgetFormTemplateDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GgetFormTemplateData build() => _build();

  _$GgetFormTemplateData _build() {
    final _$result = _$v ??
        _$GgetFormTemplateData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GgetFormTemplateData', 'G__typename'),
          getFormTemplate: getFormTemplate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

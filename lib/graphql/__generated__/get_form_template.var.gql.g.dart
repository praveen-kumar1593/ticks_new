// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_form_template.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GgetFormTemplateVars> _$ggetFormTemplateVarsSerializer =
    _$GgetFormTemplateVarsSerializer();

class _$GgetFormTemplateVarsSerializer
    implements StructuredSerializer<GgetFormTemplateVars> {
  @override
  final Iterable<Type> types = const [
    GgetFormTemplateVars,
    _$GgetFormTemplateVars
  ];
  @override
  final String wireName = 'GgetFormTemplateVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetFormTemplateVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'domain',
      serializers.serialize(object.domain,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GgetFormTemplateVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GgetFormTemplateVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'domain':
          result.domain = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GgetFormTemplateVars extends GgetFormTemplateVars {
  @override
  final String domain;
  @override
  final String name;

  factory _$GgetFormTemplateVars(
          [void Function(GgetFormTemplateVarsBuilder)? updates]) =>
      (GgetFormTemplateVarsBuilder()..update(updates))._build();

  _$GgetFormTemplateVars._({required this.domain, required this.name})
      : super._();
  @override
  GgetFormTemplateVars rebuild(
          void Function(GgetFormTemplateVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetFormTemplateVarsBuilder toBuilder() =>
      GgetFormTemplateVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetFormTemplateVars &&
        domain == other.domain &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, domain.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GgetFormTemplateVars')
          ..add('domain', domain)
          ..add('name', name))
        .toString();
  }
}

class GgetFormTemplateVarsBuilder
    implements Builder<GgetFormTemplateVars, GgetFormTemplateVarsBuilder> {
  _$GgetFormTemplateVars? _$v;

  String? _domain;
  String? get domain => _$this._domain;
  set domain(String? domain) => _$this._domain = domain;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GgetFormTemplateVarsBuilder();

  GgetFormTemplateVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _domain = $v.domain;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetFormTemplateVars other) {
    _$v = other as _$GgetFormTemplateVars;
  }

  @override
  void update(void Function(GgetFormTemplateVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GgetFormTemplateVars build() => _build();

  _$GgetFormTemplateVars _build() {
    final _$result = _$v ??
        _$GgetFormTemplateVars._(
          domain: BuiltValueNullFieldError.checkNotNull(
              domain, r'GgetFormTemplateVars', 'domain'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'GgetFormTemplateVars', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

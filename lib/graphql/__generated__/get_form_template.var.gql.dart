// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_form_template.var.gql.g.dart';

abstract class GgetFormTemplateVars
    implements Built<GgetFormTemplateVars, GgetFormTemplateVarsBuilder> {
  GgetFormTemplateVars._();

  factory GgetFormTemplateVars(
          [void Function(GgetFormTemplateVarsBuilder b) updates]) =
      _$GgetFormTemplateVars;

  String get domain;
  String get name;
  static Serializer<GgetFormTemplateVars> get serializer =>
      _$ggetFormTemplateVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GgetFormTemplateVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GgetFormTemplateVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GgetFormTemplateVars.serializer,
        json,
      );
}

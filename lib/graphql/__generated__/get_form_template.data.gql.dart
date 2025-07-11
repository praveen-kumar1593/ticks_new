// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i1;
import 'package:built_value/serializer.dart';

part 'get_form_template.data.gql.g.dart';

abstract class GgetFormTemplateData
    implements Built<GgetFormTemplateData, GgetFormTemplateDataBuilder> {
  GgetFormTemplateData._();

  factory GgetFormTemplateData(
          [void Function(GgetFormTemplateDataBuilder b) updates]) =
      _$GgetFormTemplateData;

  static void _initializeBuilder(GgetFormTemplateDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i1.JsonObject? get getFormTemplate;
  static Serializer<GgetFormTemplateData> get serializer =>
      _$ggetFormTemplateDataSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GgetFormTemplateData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GgetFormTemplateData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GgetFormTemplateData.serializer,
        json,
      );
}

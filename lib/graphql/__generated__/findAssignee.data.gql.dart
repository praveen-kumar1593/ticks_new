// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i1;
import 'package:built_value/serializer.dart';

part 'findAssignee.data.gql.g.dart';

abstract class GfindAssigneeData
    implements Built<GfindAssigneeData, GfindAssigneeDataBuilder> {
  GfindAssigneeData._();

  factory GfindAssigneeData(
          [void Function(GfindAssigneeDataBuilder b) updates]) =
      _$GfindAssigneeData;

  static void _initializeBuilder(GfindAssigneeDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i1.JsonObject? get findAssignee;
  static Serializer<GfindAssigneeData> get serializer =>
      _$gfindAssigneeDataSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GfindAssigneeData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GfindAssigneeData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GfindAssigneeData.serializer,
        json,
      );
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i1;
import 'package:built_value/serializer.dart';

part 'find_logged_in_user.data.gql.g.dart';

abstract class GfindLoggedInUserData
    implements Built<GfindLoggedInUserData, GfindLoggedInUserDataBuilder> {
  GfindLoggedInUserData._();

  factory GfindLoggedInUserData(
          [void Function(GfindLoggedInUserDataBuilder b) updates]) =
      _$GfindLoggedInUserData;

  static void _initializeBuilder(GfindLoggedInUserDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i1.JsonObject? get findLoggedInUser;
  static Serializer<GfindLoggedInUserData> get serializer =>
      _$gfindLoggedInUserDataSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GfindLoggedInUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GfindLoggedInUserData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GfindLoggedInUserData.serializer,
        json,
      );
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i1;
import 'package:built_value/serializer.dart';

part 'update_profile.data.gql.g.dart';

abstract class GupdateProfileData
    implements Built<GupdateProfileData, GupdateProfileDataBuilder> {
  GupdateProfileData._();

  factory GupdateProfileData(
          [void Function(GupdateProfileDataBuilder b) updates]) =
      _$GupdateProfileData;

  static void _initializeBuilder(GupdateProfileDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i1.JsonObject? get updateProfile;
  static Serializer<GupdateProfileData> get serializer =>
      _$gupdateProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GupdateProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GupdateProfileData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GupdateProfileData.serializer,
        json,
      );
}

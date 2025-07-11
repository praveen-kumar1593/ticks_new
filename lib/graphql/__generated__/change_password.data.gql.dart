// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i1;
import 'package:built_value/serializer.dart';

part 'change_password.data.gql.g.dart';

abstract class GchangePasswordData
    implements Built<GchangePasswordData, GchangePasswordDataBuilder> {
  GchangePasswordData._();

  factory GchangePasswordData(
          [void Function(GchangePasswordDataBuilder b) updates]) =
      _$GchangePasswordData;

  static void _initializeBuilder(GchangePasswordDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i1.JsonObject? get changePassword;
  static Serializer<GchangePasswordData> get serializer =>
      _$gchangePasswordDataSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GchangePasswordData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GchangePasswordData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GchangePasswordData.serializer,
        json,
      );
}

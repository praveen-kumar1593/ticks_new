// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i1;
import 'package:built_value/serializer.dart';

part 'login.data.gql.g.dart';

abstract class GloginData implements Built<GloginData, GloginDataBuilder> {
  GloginData._();

  factory GloginData([void Function(GloginDataBuilder b) updates]) =
      _$GloginData;

  static void _initializeBuilder(GloginDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i1.JsonObject? get login;
  static Serializer<GloginData> get serializer => _$gloginDataSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GloginData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GloginData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GloginData.serializer,
        json,
      );
}

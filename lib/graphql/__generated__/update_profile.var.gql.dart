// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i1;
import 'package:built_value/serializer.dart';

part 'update_profile.var.gql.g.dart';

abstract class GupdateProfileVars
    implements Built<GupdateProfileVars, GupdateProfileVarsBuilder> {
  GupdateProfileVars._();

  factory GupdateProfileVars(
          [void Function(GupdateProfileVarsBuilder b) updates]) =
      _$GupdateProfileVars;

  _i1.JsonObject? get user;
  static Serializer<GupdateProfileVars> get serializer =>
      _$gupdateProfileVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GupdateProfileVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GupdateProfileVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GupdateProfileVars.serializer,
        json,
      );
}

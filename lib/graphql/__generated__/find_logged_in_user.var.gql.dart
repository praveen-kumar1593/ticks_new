// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'find_logged_in_user.var.gql.g.dart';

abstract class GfindLoggedInUserVars
    implements Built<GfindLoggedInUserVars, GfindLoggedInUserVarsBuilder> {
  GfindLoggedInUserVars._();

  factory GfindLoggedInUserVars(
          [void Function(GfindLoggedInUserVarsBuilder b) updates]) =
      _$GfindLoggedInUserVars;

  static Serializer<GfindLoggedInUserVars> get serializer =>
      _$gfindLoggedInUserVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GfindLoggedInUserVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GfindLoggedInUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GfindLoggedInUserVars.serializer,
        json,
      );
}

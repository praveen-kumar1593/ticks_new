// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'findAssignee.var.gql.g.dart';

abstract class GfindAssigneeVars
    implements Built<GfindAssigneeVars, GfindAssigneeVarsBuilder> {
  GfindAssigneeVars._();

  factory GfindAssigneeVars(
          [void Function(GfindAssigneeVarsBuilder b) updates]) =
      _$GfindAssigneeVars;

  String get id;
  static Serializer<GfindAssigneeVars> get serializer =>
      _$gfindAssigneeVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GfindAssigneeVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GfindAssigneeVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GfindAssigneeVars.serializer,
        json,
      );
}

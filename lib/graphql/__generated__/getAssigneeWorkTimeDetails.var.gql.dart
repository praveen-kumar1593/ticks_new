// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'getAssigneeWorkTimeDetails.var.gql.g.dart';

abstract class GGetAssigneeWorkTimeDetailsVars
    implements
        Built<GGetAssigneeWorkTimeDetailsVars,
            GGetAssigneeWorkTimeDetailsVarsBuilder> {
  GGetAssigneeWorkTimeDetailsVars._();

  factory GGetAssigneeWorkTimeDetailsVars(
          [void Function(GGetAssigneeWorkTimeDetailsVarsBuilder b) updates]) =
      _$GGetAssigneeWorkTimeDetailsVars;

  static Serializer<GGetAssigneeWorkTimeDetailsVars> get serializer =>
      _$gGetAssigneeWorkTimeDetailsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAssigneeWorkTimeDetailsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAssigneeWorkTimeDetailsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAssigneeWorkTimeDetailsVars.serializer,
        json,
      );
}

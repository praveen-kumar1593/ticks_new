// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fetchUserAttendanceStatus.var.gql.g.dart';

abstract class GfetchUserAttendanceStatusVars
    implements
        Built<GfetchUserAttendanceStatusVars,
            GfetchUserAttendanceStatusVarsBuilder> {
  GfetchUserAttendanceStatusVars._();

  factory GfetchUserAttendanceStatusVars(
          [void Function(GfetchUserAttendanceStatusVarsBuilder b) updates]) =
      _$GfetchUserAttendanceStatusVars;

  static Serializer<GfetchUserAttendanceStatusVars> get serializer =>
      _$gfetchUserAttendanceStatusVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GfetchUserAttendanceStatusVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GfetchUserAttendanceStatusVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GfetchUserAttendanceStatusVars.serializer,
        json,
      );
}

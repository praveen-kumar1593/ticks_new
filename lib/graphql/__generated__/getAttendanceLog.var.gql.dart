// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/schema.schema.gql.dart' as _i1;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'getAttendanceLog.var.gql.g.dart';

abstract class GgetAttendanceLogVars
    implements Built<GgetAttendanceLogVars, GgetAttendanceLogVarsBuilder> {
  GgetAttendanceLogVars._();

  factory GgetAttendanceLogVars(
          [void Function(GgetAttendanceLogVarsBuilder b) updates]) =
      _$GgetAttendanceLogVars;

  _i1.GAttendanceLogInput? get data;
  static Serializer<GgetAttendanceLogVars> get serializer =>
      _$ggetAttendanceLogVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GgetAttendanceLogVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GgetAttendanceLogVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GgetAttendanceLogVars.serializer,
        json,
      );
}

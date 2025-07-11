// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/schema.schema.gql.dart' as _i1;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'markUserAttendance.var.gql.g.dart';

abstract class GMarkUserAttendanceVars
    implements Built<GMarkUserAttendanceVars, GMarkUserAttendanceVarsBuilder> {
  GMarkUserAttendanceVars._();

  factory GMarkUserAttendanceVars(
          [void Function(GMarkUserAttendanceVarsBuilder b) updates]) =
      _$GMarkUserAttendanceVars;

  _i1.GUserAttendanceInput get data;
  static Serializer<GMarkUserAttendanceVars> get serializer =>
      _$gMarkUserAttendanceVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GMarkUserAttendanceVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkUserAttendanceVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GMarkUserAttendanceVars.serializer,
        json,
      );
}

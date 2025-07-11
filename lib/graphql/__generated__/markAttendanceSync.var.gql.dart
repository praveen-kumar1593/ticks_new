// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/schema.schema.gql.dart' as _i1;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'markAttendanceSync.var.gql.g.dart';

abstract class GmarkAttendanceSyncVars
    implements Built<GmarkAttendanceSyncVars, GmarkAttendanceSyncVarsBuilder> {
  GmarkAttendanceSyncVars._();

  factory GmarkAttendanceSyncVars(
          [void Function(GmarkAttendanceSyncVarsBuilder b) updates]) =
      _$GmarkAttendanceSyncVars;

  BuiltList<_i1.GUserAttendanceBulkInput>? get data;
  static Serializer<GmarkAttendanceSyncVars> get serializer =>
      _$gmarkAttendanceSyncVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GmarkAttendanceSyncVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GmarkAttendanceSyncVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GmarkAttendanceSyncVars.serializer,
        json,
      );
}

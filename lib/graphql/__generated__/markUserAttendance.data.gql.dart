// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'markUserAttendance.data.gql.g.dart';

abstract class GMarkUserAttendanceData
    implements Built<GMarkUserAttendanceData, GMarkUserAttendanceDataBuilder> {
  GMarkUserAttendanceData._();

  factory GMarkUserAttendanceData(
          [void Function(GMarkUserAttendanceDataBuilder b) updates]) =
      _$GMarkUserAttendanceData;

  static void _initializeBuilder(GMarkUserAttendanceDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMarkUserAttendanceData_markUserAttendance? get markUserAttendance;
  static Serializer<GMarkUserAttendanceData> get serializer =>
      _$gMarkUserAttendanceDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkUserAttendanceData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkUserAttendanceData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkUserAttendanceData.serializer,
        json,
      );
}

abstract class GMarkUserAttendanceData_markUserAttendance
    implements
        Built<GMarkUserAttendanceData_markUserAttendance,
            GMarkUserAttendanceData_markUserAttendanceBuilder> {
  GMarkUserAttendanceData_markUserAttendance._();

  factory GMarkUserAttendanceData_markUserAttendance(
      [void Function(GMarkUserAttendanceData_markUserAttendanceBuilder b)
          updates]) = _$GMarkUserAttendanceData_markUserAttendance;

  static void _initializeBuilder(
          GMarkUserAttendanceData_markUserAttendanceBuilder b) =>
      b..G__typename = 'MarkUserAttendanceResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get newStatus;
  String? get attendanceId;
  static Serializer<GMarkUserAttendanceData_markUserAttendance>
      get serializer => _$gMarkUserAttendanceDataMarkUserAttendanceSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkUserAttendanceData_markUserAttendance.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkUserAttendanceData_markUserAttendance? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkUserAttendanceData_markUserAttendance.serializer,
        json,
      );
}

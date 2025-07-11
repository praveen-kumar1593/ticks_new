// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i3;
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i1;

part 'schema.schema.gql.g.dart';

abstract class GDatetime implements Built<GDatetime, GDatetimeBuilder> {
  GDatetime._();

  factory GDatetime([String? value]) =>
      _$GDatetime((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GDatetime> get serializer =>
      _i1.DefaultScalarSerializer<GDatetime>(
          (Object serialized) => GDatetime((serialized as String?)));
}

abstract class GUserAttendanceInput
    implements Built<GUserAttendanceInput, GUserAttendanceInputBuilder> {
  GUserAttendanceInput._();

  factory GUserAttendanceInput(
          [void Function(GUserAttendanceInputBuilder b) updates]) =
      _$GUserAttendanceInput;

  String? get userId;
  String? get newStatus;
  GDatetime? get date;
  String? get location;
  String? get locationName;
  String? get geofence;
  int? get attendanceId;
  int? get breakId;
  double? get statusSince;
  int? get batteryLevel;
  String? get deviceId;
  static Serializer<GUserAttendanceInput> get serializer =>
      _$gUserAttendanceInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUserAttendanceInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserAttendanceInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUserAttendanceInput.serializer,
        json,
      );
}

abstract class GUserAttendanceBulkInput
    implements
        Built<GUserAttendanceBulkInput, GUserAttendanceBulkInputBuilder> {
  GUserAttendanceBulkInput._();

  factory GUserAttendanceBulkInput(
          [void Function(GUserAttendanceBulkInputBuilder b) updates]) =
      _$GUserAttendanceBulkInput;

  double get userId;
  String? get newStatus;
  GDatetime? get date;
  String? get location;
  String? get locationName;
  String? get geofence;
  int? get attendanceId;
  int? get breakId;
  double? get statusSince;
  int? get batteryLevel;
  String? get deviceId;
  static Serializer<GUserAttendanceBulkInput> get serializer =>
      _$gUserAttendanceBulkInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUserAttendanceBulkInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserAttendanceBulkInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUserAttendanceBulkInput.serializer,
        json,
      );
}

abstract class GAttendanceLogInput
    implements Built<GAttendanceLogInput, GAttendanceLogInputBuilder> {
  GAttendanceLogInput._();

  factory GAttendanceLogInput(
          [void Function(GAttendanceLogInputBuilder b) updates]) =
      _$GAttendanceLogInput;

  String? get userId;
  String? get fromDate;
  String? get toDate;
  String? get attendanceStatus;
  static Serializer<GAttendanceLogInput> get serializer =>
      _$gAttendanceLogInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GAttendanceLogInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAttendanceLogInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GAttendanceLogInput.serializer,
        json,
      );
}

abstract class GgeofenceList
    implements Built<GgeofenceList, GgeofenceListBuilder> {
  GgeofenceList._();

  factory GgeofenceList([void Function(GgeofenceListBuilder b) updates]) =
      _$GgeofenceList;

  String? get domain;
  _i3.JsonObject? get searchFields;
  int? get page;
  int? get limit;
  String? get order;
  String? get sortField;
  static Serializer<GgeofenceList> get serializer => _$ggeofenceListSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GgeofenceList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GgeofenceList? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GgeofenceList.serializer,
        json,
      );
}

const Map<String, Set<String>> possibleTypesMap = {};

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'getAttendanceLog.data.gql.g.dart';

abstract class GgetAttendanceLogData
    implements Built<GgetAttendanceLogData, GgetAttendanceLogDataBuilder> {
  GgetAttendanceLogData._();

  factory GgetAttendanceLogData(
          [void Function(GgetAttendanceLogDataBuilder b) updates]) =
      _$GgetAttendanceLogData;

  static void _initializeBuilder(GgetAttendanceLogDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GgetAttendanceLogData_getAttendanceLog? get getAttendanceLog;
  static Serializer<GgetAttendanceLogData> get serializer =>
      _$ggetAttendanceLogDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GgetAttendanceLogData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GgetAttendanceLogData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GgetAttendanceLogData.serializer,
        json,
      );
}

abstract class GgetAttendanceLogData_getAttendanceLog
    implements
        Built<GgetAttendanceLogData_getAttendanceLog,
            GgetAttendanceLogData_getAttendanceLogBuilder> {
  GgetAttendanceLogData_getAttendanceLog._();

  factory GgetAttendanceLogData_getAttendanceLog(
      [void Function(GgetAttendanceLogData_getAttendanceLogBuilder b)
          updates]) = _$GgetAttendanceLogData_getAttendanceLog;

  static void _initializeBuilder(
          GgetAttendanceLogData_getAttendanceLogBuilder b) =>
      b..G__typename = 'AttendanceLogResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GgetAttendanceLogData_getAttendanceLog_items?>? get items;
  static Serializer<GgetAttendanceLogData_getAttendanceLog> get serializer =>
      _$ggetAttendanceLogDataGetAttendanceLogSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GgetAttendanceLogData_getAttendanceLog.serializer,
        this,
      ) as Map<String, dynamic>);

  static GgetAttendanceLogData_getAttendanceLog? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GgetAttendanceLogData_getAttendanceLog.serializer,
        json,
      );
}

abstract class GgetAttendanceLogData_getAttendanceLog_items
    implements
        Built<GgetAttendanceLogData_getAttendanceLog_items,
            GgetAttendanceLogData_getAttendanceLog_itemsBuilder> {
  GgetAttendanceLogData_getAttendanceLog_items._();

  factory GgetAttendanceLogData_getAttendanceLog_items(
      [void Function(GgetAttendanceLogData_getAttendanceLog_itemsBuilder b)
          updates]) = _$GgetAttendanceLogData_getAttendanceLog_items;

  static void _initializeBuilder(
          GgetAttendanceLogData_getAttendanceLog_itemsBuilder b) =>
      b..G__typename = 'LogItem';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get id;
  _i2.GDatetime? get date;
  _i2.GDatetime? get checkInTime;
  _i2.GDatetime? get checkOutTime;
  int? get duration;
  String? get attendance_status;
  BuiltList<GgetAttendanceLogData_getAttendanceLog_items_breaks?>? get breaks;
  static Serializer<GgetAttendanceLogData_getAttendanceLog_items>
      get serializer => _$ggetAttendanceLogDataGetAttendanceLogItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GgetAttendanceLogData_getAttendanceLog_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GgetAttendanceLogData_getAttendanceLog_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GgetAttendanceLogData_getAttendanceLog_items.serializer,
        json,
      );
}

abstract class GgetAttendanceLogData_getAttendanceLog_items_breaks
    implements
        Built<GgetAttendanceLogData_getAttendanceLog_items_breaks,
            GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder> {
  GgetAttendanceLogData_getAttendanceLog_items_breaks._();

  factory GgetAttendanceLogData_getAttendanceLog_items_breaks(
      [void Function(
              GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder b)
          updates]) = _$GgetAttendanceLogData_getAttendanceLog_items_breaks;

  static void _initializeBuilder(
          GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder b) =>
      b..G__typename = 'AttendanceBreak';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get breakId;
  _i2.GDatetime? get startTime;
  _i2.GDatetime? get endTime;
  int? get duration;
  static Serializer<GgetAttendanceLogData_getAttendanceLog_items_breaks>
      get serializer =>
          _$ggetAttendanceLogDataGetAttendanceLogItemsBreaksSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GgetAttendanceLogData_getAttendanceLog_items_breaks.serializer,
        this,
      ) as Map<String, dynamic>);

  static GgetAttendanceLogData_getAttendanceLog_items_breaks? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GgetAttendanceLogData_getAttendanceLog_items_breaks.serializer,
        json,
      );
}

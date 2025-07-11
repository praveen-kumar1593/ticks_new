// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i3;
import 'package:built_value/serializer.dart';

part 'fetchUserAttendanceStatus.data.gql.g.dart';

abstract class GfetchUserAttendanceStatusData
    implements
        Built<GfetchUserAttendanceStatusData,
            GfetchUserAttendanceStatusDataBuilder> {
  GfetchUserAttendanceStatusData._();

  factory GfetchUserAttendanceStatusData(
          [void Function(GfetchUserAttendanceStatusDataBuilder b) updates]) =
      _$GfetchUserAttendanceStatusData;

  static void _initializeBuilder(GfetchUserAttendanceStatusDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus?
      get fetchUserAttendanceStatus;
  static Serializer<GfetchUserAttendanceStatusData> get serializer =>
      _$gfetchUserAttendanceStatusDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GfetchUserAttendanceStatusData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GfetchUserAttendanceStatusData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GfetchUserAttendanceStatusData.serializer,
        json,
      );
}

abstract class GfetchUserAttendanceStatusData_fetchUserAttendanceStatus
    implements
        Built<GfetchUserAttendanceStatusData_fetchUserAttendanceStatus,
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder> {
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus._();

  factory GfetchUserAttendanceStatusData_fetchUserAttendanceStatus(
      [void Function(
              GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder b)
          updates]) = _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus;

  static void _initializeBuilder(
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder b) =>
      b..G__typename = 'FetchUserAttendanceStatusResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get attendanceId;
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user? get user;
  _i2.GDatetime? get date;
  _i2.GDatetime? get checkInTime;
  _i2.GDatetime? get checkOutTime;
  _i2.GDatetime? get expectedCheckInTime;
  _i2.GDatetime? get expectedCheckOutTime;
  String? get currentStatus;
  int? get allowedBreak;
  int? get bufferTime;
  _i3.JsonObject? get attendanceStatusesObj;
  BuiltList<
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak?>?
      get attendanceBreak;
  _i2.GDatetime? get createdOn;
  _i2.GDatetime? get updatedOn;
  static Serializer<GfetchUserAttendanceStatusData_fetchUserAttendanceStatus>
      get serializer =>
          _$gfetchUserAttendanceStatusDataFetchUserAttendanceStatusSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus.serializer,
        this,
      ) as Map<String, dynamic>);

  static GfetchUserAttendanceStatusData_fetchUserAttendanceStatus? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus.serializer,
        json,
      );
}

abstract class GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user
    implements
        Built<GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user,
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder> {
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user._();

  factory GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user(
          [void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder
                      b)
              updates]) =
      _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user;

  static void _initializeBuilder(
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder
              b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String? get name;
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type? get type;
  String? get referenceId;
  String? get contactNumber;
  String? get emailId;
  String? get status;
  String? get employeeId;
  static Serializer<
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user>
      get serializer =>
          _$gfetchUserAttendanceStatusDataFetchUserAttendanceStatusUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user
                .serializer,
            json,
          );
}

abstract class GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
    implements
        Built<
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type,
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder> {
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type._();

  factory GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type(
          [void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder
                      b)
              updates]) =
      _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type;

  static void _initializeBuilder(
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder
              b) =>
      b..G__typename = 'UserType';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get name;
  String? get status;
  static Serializer<
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type>
      get serializer =>
          _$gfetchUserAttendanceStatusDataFetchUserAttendanceStatusUserTypeSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
                .serializer,
            json,
          );
}

abstract class GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
    implements
        Built<
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak,
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder> {
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak._();

  factory GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak(
          [void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder
                      b)
              updates]) =
      _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak;

  static void _initializeBuilder(
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder
              b) =>
      b..G__typename = 'AttendanceBreak';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get breakId;
  _i2.GDatetime? get startTime;
  _i2.GDatetime? get endTime;
  int? get duration;
  static Serializer<
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak>
      get serializer =>
          _$gfetchUserAttendanceStatusDataFetchUserAttendanceStatusAttendanceBreakSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
                .serializer,
            json,
          );
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'getAssigneeWorkTimeDetails.data.gql.g.dart';

abstract class GGetAssigneeWorkTimeDetailsData
    implements
        Built<GGetAssigneeWorkTimeDetailsData,
            GGetAssigneeWorkTimeDetailsDataBuilder> {
  GGetAssigneeWorkTimeDetailsData._();

  factory GGetAssigneeWorkTimeDetailsData(
          [void Function(GGetAssigneeWorkTimeDetailsDataBuilder b) updates]) =
      _$GGetAssigneeWorkTimeDetailsData;

  static void _initializeBuilder(GGetAssigneeWorkTimeDetailsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails?
      get getAssigneeWorkTimeDetails;
  static Serializer<GGetAssigneeWorkTimeDetailsData> get serializer =>
      _$gGetAssigneeWorkTimeDetailsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAssigneeWorkTimeDetailsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAssigneeWorkTimeDetailsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAssigneeWorkTimeDetailsData.serializer,
        json,
      );
}

abstract class GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails
    implements
        Built<GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails,
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder> {
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails._();

  factory GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails(
      [void Function(
              GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder
                  b)
          updates]) = _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails;

  static void _initializeBuilder(
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder
              b) =>
      b..G__typename = 'AssigneeWorkTimeDetails';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift? get shift;
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour?
      get clientWorkingHour;
  static Serializer<GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails>
      get serializer =>
          _$gGetAssigneeWorkTimeDetailsDataGetAssigneeWorkTimeDetailsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails.serializer,
        json,
      );
}

abstract class GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift
    implements
        Built<GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift,
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder> {
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift._();

  factory GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift(
          [void Function(
                  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder
                      b)
              updates]) =
      _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift;

  static void _initializeBuilder(
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder
              b) =>
      b..G__typename = 'Shift';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get identifier;
  String? get startTime;
  String? get endTime;
  int? get duration;
  String? get domain;
  String? get name;
  String? get description;
  String? get status;
  int? get allowedBreak;
  int? get bufferTime;
  static Serializer<
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift>
      get serializer =>
          _$gGetAssigneeWorkTimeDetailsDataGetAssigneeWorkTimeDetailsShiftSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift
                .serializer,
            json,
          );
}

abstract class GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
    implements
        Built<
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour,
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder> {
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour._();

  factory GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour(
          [void Function(
                  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder
                      b)
              updates]) =
      _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour;

  static void _initializeBuilder(
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder
              b) =>
      b..G__typename = 'ClientWorkingHour';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get id;
  String? get name;
  String? get sundayStartTime;
  String? get sundayEndTime;
  String? get mondayStartTime;
  String? get mondayEndTime;
  String? get tuesdayStartTime;
  String? get tuesdayEndTime;
  String? get wednesdayStartTime;
  String? get wednesdayEndTime;
  String? get thursdayStartTime;
  String? get thursdayEndTime;
  String? get fridayStartTime;
  String? get fridayEndTime;
  String? get saturdayStartTime;
  String? get saturdayEndTime;
  int? get allowedBreak;
  int? get bufferTime;
  String? get client;
  static Serializer<
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour>
      get serializer =>
          _$gGetAssigneeWorkTimeDetailsDataGetAssigneeWorkTimeDetailsClientWorkingHourSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
                .serializer,
            json,
          );
}

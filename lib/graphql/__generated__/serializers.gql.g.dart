// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add(FetchPolicy.serializer)
      ..add(GAttendanceLogInput.serializer)
      ..add(GDatetime.serializer)
      ..add(GGetAssigneeWorkTimeDetailsData.serializer)
      ..add(
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails.serializer)
      ..add(
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
              .serializer)
      ..add(GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift
          .serializer)
      ..add(GGetAssigneeWorkTimeDetailsReq.serializer)
      ..add(GGetAssigneeWorkTimeDetailsVars.serializer)
      ..add(GMarkUserAttendanceData.serializer)
      ..add(GMarkUserAttendanceData_markUserAttendance.serializer)
      ..add(GMarkUserAttendanceReq.serializer)
      ..add(GMarkUserAttendanceVars.serializer)
      ..add(GRefreshData.serializer)
      ..add(GRefreshReq.serializer)
      ..add(GRefreshVars.serializer)
      ..add(GUserAttendanceBulkInput.serializer)
      ..add(GUserAttendanceInput.serializer)
      ..add(GchangePasswordData.serializer)
      ..add(GchangePasswordReq.serializer)
      ..add(GchangePasswordVars.serializer)
      ..add(GfetchUserAttendanceStatusData.serializer)
      ..add(GfetchUserAttendanceStatusData_fetchUserAttendanceStatus.serializer)
      ..add(
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
              .serializer)
      ..add(GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user
          .serializer)
      ..add(GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
          .serializer)
      ..add(GfetchUserAttendanceStatusReq.serializer)
      ..add(GfetchUserAttendanceStatusVars.serializer)
      ..add(GfindAssigneeData.serializer)
      ..add(GfindAssigneeReq.serializer)
      ..add(GfindAssigneeVars.serializer)
      ..add(GfindLoggedInUserData.serializer)
      ..add(GfindLoggedInUserReq.serializer)
      ..add(GfindLoggedInUserVars.serializer)
      ..add(GgeofenceList.serializer)
      ..add(GgetAttendanceLogData.serializer)
      ..add(GgetAttendanceLogData_getAttendanceLog.serializer)
      ..add(GgetAttendanceLogData_getAttendanceLog_items.serializer)
      ..add(GgetAttendanceLogData_getAttendanceLog_items_breaks.serializer)
      ..add(GgetAttendanceLogReq.serializer)
      ..add(GgetAttendanceLogVars.serializer)
      ..add(GgetFormTemplateData.serializer)
      ..add(GgetFormTemplateReq.serializer)
      ..add(GgetFormTemplateVars.serializer)
      ..add(GlistAllGeoFencesData.serializer)
      ..add(GlistAllGeoFencesData_listAllGeoFences.serializer)
      ..add(GlistAllGeoFencesData_listAllGeoFences_data.serializer)
      ..add(GlistAllGeoFencesReq.serializer)
      ..add(GlistAllGeoFencesVars.serializer)
      ..add(GloginData.serializer)
      ..add(GloginReq.serializer)
      ..add(GloginVars.serializer)
      ..add(GmarkAttendanceSyncData.serializer)
      ..add(GmarkAttendanceSyncData_markAttendanceSync.serializer)
      ..add(GmarkAttendanceSyncReq.serializer)
      ..add(GmarkAttendanceSyncVars.serializer)
      ..add(GupdateProfileData.serializer)
      ..add(GupdateProfileReq.serializer)
      ..add(GupdateProfileVars.serializer)
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GUserAttendanceBulkInput)]),
          () => ListBuilder<GUserAttendanceBulkInput>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType.nullable(
                GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak)
          ]),
          () => ListBuilder<
              GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak?>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType.nullable(
                GgetAttendanceLogData_getAttendanceLog_items)
          ]),
          () => ListBuilder<GgetAttendanceLogData_getAttendanceLog_items?>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType.nullable(
                GgetAttendanceLogData_getAttendanceLog_items_breaks)
          ]),
          () => ListBuilder<
              GgetAttendanceLogData_getAttendanceLog_items_breaks?>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType.nullable(GlistAllGeoFencesData_listAllGeoFences_data)
          ]),
          () => ListBuilder<GlistAllGeoFencesData_listAllGeoFences_data?>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

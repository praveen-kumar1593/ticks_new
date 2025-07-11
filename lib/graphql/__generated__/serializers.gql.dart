// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:ticks_new/graphql/__generated__/change_password.data.gql.dart'
    show GchangePasswordData;
import 'package:ticks_new/graphql/__generated__/change_password.req.gql.dart'
    show GchangePasswordReq;
import 'package:ticks_new/graphql/__generated__/change_password.var.gql.dart'
    show GchangePasswordVars;
import 'package:ticks_new/graphql/__generated__/fetchUserAttendanceStatus.data.gql.dart'
    show
        GfetchUserAttendanceStatusData,
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus,
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak,
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user,
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type;
import 'package:ticks_new/graphql/__generated__/fetchUserAttendanceStatus.req.gql.dart'
    show GfetchUserAttendanceStatusReq;
import 'package:ticks_new/graphql/__generated__/fetchUserAttendanceStatus.var.gql.dart'
    show GfetchUserAttendanceStatusVars;
import 'package:ticks_new/graphql/__generated__/find_logged_in_user.data.gql.dart'
    show GfindLoggedInUserData;
import 'package:ticks_new/graphql/__generated__/find_logged_in_user.req.gql.dart'
    show GfindLoggedInUserReq;
import 'package:ticks_new/graphql/__generated__/find_logged_in_user.var.gql.dart'
    show GfindLoggedInUserVars;
import 'package:ticks_new/graphql/__generated__/findAssignee.data.gql.dart'
    show GfindAssigneeData;
import 'package:ticks_new/graphql/__generated__/findAssignee.req.gql.dart'
    show GfindAssigneeReq;
import 'package:ticks_new/graphql/__generated__/findAssignee.var.gql.dart'
    show GfindAssigneeVars;
import 'package:ticks_new/graphql/__generated__/get_form_template.data.gql.dart'
    show GgetFormTemplateData;
import 'package:ticks_new/graphql/__generated__/get_form_template.req.gql.dart'
    show GgetFormTemplateReq;
import 'package:ticks_new/graphql/__generated__/get_form_template.var.gql.dart'
    show GgetFormTemplateVars;
import 'package:ticks_new/graphql/__generated__/getAssigneeWorkTimeDetails.data.gql.dart'
    show
        GGetAssigneeWorkTimeDetailsData,
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails,
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour,
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift;
import 'package:ticks_new/graphql/__generated__/getAssigneeWorkTimeDetails.req.gql.dart'
    show GGetAssigneeWorkTimeDetailsReq;
import 'package:ticks_new/graphql/__generated__/getAssigneeWorkTimeDetails.var.gql.dart'
    show GGetAssigneeWorkTimeDetailsVars;
import 'package:ticks_new/graphql/__generated__/getAttendanceLog.data.gql.dart'
    show
        GgetAttendanceLogData,
        GgetAttendanceLogData_getAttendanceLog,
        GgetAttendanceLogData_getAttendanceLog_items,
        GgetAttendanceLogData_getAttendanceLog_items_breaks;
import 'package:ticks_new/graphql/__generated__/getAttendanceLog.req.gql.dart'
    show GgetAttendanceLogReq;
import 'package:ticks_new/graphql/__generated__/getAttendanceLog.var.gql.dart'
    show GgetAttendanceLogVars;
import 'package:ticks_new/graphql/__generated__/login.data.gql.dart'
    show GloginData;
import 'package:ticks_new/graphql/__generated__/login.req.gql.dart'
    show GloginReq;
import 'package:ticks_new/graphql/__generated__/login.var.gql.dart'
    show GloginVars;
import 'package:ticks_new/graphql/__generated__/markAttendanceSync.data.gql.dart'
    show GmarkAttendanceSyncData, GmarkAttendanceSyncData_markAttendanceSync;
import 'package:ticks_new/graphql/__generated__/markAttendanceSync.req.gql.dart'
    show GmarkAttendanceSyncReq;
import 'package:ticks_new/graphql/__generated__/markAttendanceSync.var.gql.dart'
    show GmarkAttendanceSyncVars;
import 'package:ticks_new/graphql/__generated__/markUserAttendance.data.gql.dart'
    show GMarkUserAttendanceData, GMarkUserAttendanceData_markUserAttendance;
import 'package:ticks_new/graphql/__generated__/markUserAttendance.req.gql.dart'
    show GMarkUserAttendanceReq;
import 'package:ticks_new/graphql/__generated__/markUserAttendance.var.gql.dart'
    show GMarkUserAttendanceVars;
import 'package:ticks_new/graphql/__generated__/refresh.data.gql.dart'
    show GRefreshData;
import 'package:ticks_new/graphql/__generated__/refresh.req.gql.dart'
    show GRefreshReq;
import 'package:ticks_new/graphql/__generated__/refresh.var.gql.dart'
    show GRefreshVars;
import 'package:ticks_new/graphql/__generated__/schema.schema.gql.dart'
    show
        GAttendanceLogInput,
        GDatetime,
        GUserAttendanceBulkInput,
        GUserAttendanceInput,
        GgeofenceList;
import 'package:ticks_new/graphql/__generated__/update_profile.data.gql.dart'
    show GupdateProfileData;
import 'package:ticks_new/graphql/__generated__/update_profile.req.gql.dart'
    show GupdateProfileReq;
import 'package:ticks_new/graphql/__generated__/update_profile.var.gql.dart'
    show GupdateProfileVars;
import 'package:ticks_new/graphql/schemas/__generated__/geofence.data.gql.dart'
    show
        GlistAllGeoFencesData,
        GlistAllGeoFencesData_listAllGeoFences,
        GlistAllGeoFencesData_listAllGeoFences_data;
import 'package:ticks_new/graphql/schemas/__generated__/geofence.req.gql.dart'
    show GlistAllGeoFencesReq;
import 'package:ticks_new/graphql/schemas/__generated__/geofence.var.gql.dart'
    show GlistAllGeoFencesVars;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAttendanceLogInput,
  GDatetime,
  GGetAssigneeWorkTimeDetailsData,
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails,
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour,
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift,
  GGetAssigneeWorkTimeDetailsReq,
  GGetAssigneeWorkTimeDetailsVars,
  GMarkUserAttendanceData,
  GMarkUserAttendanceData_markUserAttendance,
  GMarkUserAttendanceReq,
  GMarkUserAttendanceVars,
  GRefreshData,
  GRefreshReq,
  GRefreshVars,
  GUserAttendanceBulkInput,
  GUserAttendanceInput,
  GchangePasswordData,
  GchangePasswordReq,
  GchangePasswordVars,
  GfetchUserAttendanceStatusData,
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus,
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak,
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user,
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type,
  GfetchUserAttendanceStatusReq,
  GfetchUserAttendanceStatusVars,
  GfindAssigneeData,
  GfindAssigneeReq,
  GfindAssigneeVars,
  GfindLoggedInUserData,
  GfindLoggedInUserReq,
  GfindLoggedInUserVars,
  GgeofenceList,
  GgetAttendanceLogData,
  GgetAttendanceLogData_getAttendanceLog,
  GgetAttendanceLogData_getAttendanceLog_items,
  GgetAttendanceLogData_getAttendanceLog_items_breaks,
  GgetAttendanceLogReq,
  GgetAttendanceLogVars,
  GgetFormTemplateData,
  GgetFormTemplateReq,
  GgetFormTemplateVars,
  GlistAllGeoFencesData,
  GlistAllGeoFencesData_listAllGeoFences,
  GlistAllGeoFencesData_listAllGeoFences_data,
  GlistAllGeoFencesReq,
  GlistAllGeoFencesVars,
  GloginData,
  GloginReq,
  GloginVars,
  GmarkAttendanceSyncData,
  GmarkAttendanceSyncData_markAttendanceSync,
  GmarkAttendanceSyncReq,
  GmarkAttendanceSyncVars,
  GupdateProfileData,
  GupdateProfileReq,
  GupdateProfileVars,
])
final Serializers serializers = _serializersBuilder.build();

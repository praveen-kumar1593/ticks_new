// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/getAttendanceLog.ast.gql.dart'
    as _i5;
import 'package:ticks_new/graphql/__generated__/getAttendanceLog.data.gql.dart'
    as _i2;
import 'package:ticks_new/graphql/__generated__/getAttendanceLog.var.gql.dart'
    as _i3;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'getAttendanceLog.req.gql.g.dart';

abstract class GgetAttendanceLogReq
    implements
        Built<GgetAttendanceLogReq, GgetAttendanceLogReqBuilder>,
        _i1.OperationRequest<_i2.GgetAttendanceLogData,
            _i3.GgetAttendanceLogVars> {
  GgetAttendanceLogReq._();

  factory GgetAttendanceLogReq(
          [void Function(GgetAttendanceLogReqBuilder b) updates]) =
      _$GgetAttendanceLogReq;

  static void _initializeBuilder(GgetAttendanceLogReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'getAttendanceLog',
    )
    ..executeOnListen = true;

  @override
  _i3.GgetAttendanceLogVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GgetAttendanceLogData? Function(
    _i2.GgetAttendanceLogData?,
    _i2.GgetAttendanceLogData?,
  )? get updateResult;
  @override
  _i2.GgetAttendanceLogData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GgetAttendanceLogData? parseData(Map<String, dynamic> json) =>
      _i2.GgetAttendanceLogData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GgetAttendanceLogData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GgetAttendanceLogData, _i3.GgetAttendanceLogVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GgetAttendanceLogReq> get serializer =>
      _$ggetAttendanceLogReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GgetAttendanceLogReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GgetAttendanceLogReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GgetAttendanceLogReq.serializer,
        json,
      );
}

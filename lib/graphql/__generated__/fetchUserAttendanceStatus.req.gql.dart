// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/fetchUserAttendanceStatus.ast.gql.dart'
    as _i5;
import 'package:ticks_new/graphql/__generated__/fetchUserAttendanceStatus.data.gql.dart'
    as _i2;
import 'package:ticks_new/graphql/__generated__/fetchUserAttendanceStatus.var.gql.dart'
    as _i3;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'fetchUserAttendanceStatus.req.gql.g.dart';

abstract class GfetchUserAttendanceStatusReq
    implements
        Built<GfetchUserAttendanceStatusReq,
            GfetchUserAttendanceStatusReqBuilder>,
        _i1.OperationRequest<_i2.GfetchUserAttendanceStatusData,
            _i3.GfetchUserAttendanceStatusVars> {
  GfetchUserAttendanceStatusReq._();

  factory GfetchUserAttendanceStatusReq(
          [void Function(GfetchUserAttendanceStatusReqBuilder b) updates]) =
      _$GfetchUserAttendanceStatusReq;

  static void _initializeBuilder(GfetchUserAttendanceStatusReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'fetchUserAttendanceStatus',
    )
    ..executeOnListen = true;

  @override
  _i3.GfetchUserAttendanceStatusVars get vars;
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
  _i2.GfetchUserAttendanceStatusData? Function(
    _i2.GfetchUserAttendanceStatusData?,
    _i2.GfetchUserAttendanceStatusData?,
  )? get updateResult;
  @override
  _i2.GfetchUserAttendanceStatusData? get optimisticResponse;
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
  _i2.GfetchUserAttendanceStatusData? parseData(Map<String, dynamic> json) =>
      _i2.GfetchUserAttendanceStatusData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GfetchUserAttendanceStatusData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GfetchUserAttendanceStatusData,
      _i3.GfetchUserAttendanceStatusVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GfetchUserAttendanceStatusReq> get serializer =>
      _$gfetchUserAttendanceStatusReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GfetchUserAttendanceStatusReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GfetchUserAttendanceStatusReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GfetchUserAttendanceStatusReq.serializer,
        json,
      );
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/getAssigneeWorkTimeDetails.ast.gql.dart'
    as _i5;
import 'package:ticks_new/graphql/__generated__/getAssigneeWorkTimeDetails.data.gql.dart'
    as _i2;
import 'package:ticks_new/graphql/__generated__/getAssigneeWorkTimeDetails.var.gql.dart'
    as _i3;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'getAssigneeWorkTimeDetails.req.gql.g.dart';

abstract class GGetAssigneeWorkTimeDetailsReq
    implements
        Built<GGetAssigneeWorkTimeDetailsReq,
            GGetAssigneeWorkTimeDetailsReqBuilder>,
        _i1.OperationRequest<_i2.GGetAssigneeWorkTimeDetailsData,
            _i3.GGetAssigneeWorkTimeDetailsVars> {
  GGetAssigneeWorkTimeDetailsReq._();

  factory GGetAssigneeWorkTimeDetailsReq(
          [void Function(GGetAssigneeWorkTimeDetailsReqBuilder b) updates]) =
      _$GGetAssigneeWorkTimeDetailsReq;

  static void _initializeBuilder(GGetAssigneeWorkTimeDetailsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetAssigneeWorkTimeDetails',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetAssigneeWorkTimeDetailsVars get vars;
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
  _i2.GGetAssigneeWorkTimeDetailsData? Function(
    _i2.GGetAssigneeWorkTimeDetailsData?,
    _i2.GGetAssigneeWorkTimeDetailsData?,
  )? get updateResult;
  @override
  _i2.GGetAssigneeWorkTimeDetailsData? get optimisticResponse;
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
  _i2.GGetAssigneeWorkTimeDetailsData? parseData(Map<String, dynamic> json) =>
      _i2.GGetAssigneeWorkTimeDetailsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetAssigneeWorkTimeDetailsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetAssigneeWorkTimeDetailsData,
      _i3.GGetAssigneeWorkTimeDetailsVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetAssigneeWorkTimeDetailsReq> get serializer =>
      _$gGetAssigneeWorkTimeDetailsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetAssigneeWorkTimeDetailsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAssigneeWorkTimeDetailsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetAssigneeWorkTimeDetailsReq.serializer,
        json,
      );
}

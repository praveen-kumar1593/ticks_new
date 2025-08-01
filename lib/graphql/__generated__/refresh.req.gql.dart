// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/refresh.ast.gql.dart' as _i5;
import 'package:ticks_new/graphql/__generated__/refresh.data.gql.dart' as _i2;
import 'package:ticks_new/graphql/__generated__/refresh.var.gql.dart' as _i3;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'refresh.req.gql.g.dart';

abstract class GRefreshReq
    implements
        Built<GRefreshReq, GRefreshReqBuilder>,
        _i1.OperationRequest<_i2.GRefreshData, _i3.GRefreshVars> {
  GRefreshReq._();

  factory GRefreshReq([void Function(GRefreshReqBuilder b) updates]) =
      _$GRefreshReq;

  static void _initializeBuilder(GRefreshReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'Refresh',
    )
    ..executeOnListen = true;

  @override
  _i3.GRefreshVars get vars;
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
  _i2.GRefreshData? Function(
    _i2.GRefreshData?,
    _i2.GRefreshData?,
  )? get updateResult;
  @override
  _i2.GRefreshData? get optimisticResponse;
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
  _i2.GRefreshData? parseData(Map<String, dynamic> json) =>
      _i2.GRefreshData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GRefreshData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GRefreshData, _i3.GRefreshVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GRefreshReq> get serializer => _$gRefreshReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GRefreshReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GRefreshReq.serializer,
        json,
      );
}

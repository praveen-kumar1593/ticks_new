// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/change_password.ast.gql.dart'
    as _i5;
import 'package:ticks_new/graphql/__generated__/change_password.data.gql.dart'
    as _i2;
import 'package:ticks_new/graphql/__generated__/change_password.var.gql.dart'
    as _i3;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'change_password.req.gql.g.dart';

abstract class GchangePasswordReq
    implements
        Built<GchangePasswordReq, GchangePasswordReqBuilder>,
        _i1.OperationRequest<_i2.GchangePasswordData, _i3.GchangePasswordVars> {
  GchangePasswordReq._();

  factory GchangePasswordReq(
          [void Function(GchangePasswordReqBuilder b) updates]) =
      _$GchangePasswordReq;

  static void _initializeBuilder(GchangePasswordReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'changePassword',
    )
    ..executeOnListen = true;

  @override
  _i3.GchangePasswordVars get vars;
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
  _i2.GchangePasswordData? Function(
    _i2.GchangePasswordData?,
    _i2.GchangePasswordData?,
  )? get updateResult;
  @override
  _i2.GchangePasswordData? get optimisticResponse;
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
  _i2.GchangePasswordData? parseData(Map<String, dynamic> json) =>
      _i2.GchangePasswordData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GchangePasswordData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GchangePasswordData, _i3.GchangePasswordVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GchangePasswordReq> get serializer =>
      _$gchangePasswordReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GchangePasswordReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GchangePasswordReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GchangePasswordReq.serializer,
        json,
      );
}

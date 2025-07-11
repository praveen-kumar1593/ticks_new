// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/find_logged_in_user.ast.gql.dart'
    as _i5;
import 'package:ticks_new/graphql/__generated__/find_logged_in_user.data.gql.dart'
    as _i2;
import 'package:ticks_new/graphql/__generated__/find_logged_in_user.var.gql.dart'
    as _i3;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'find_logged_in_user.req.gql.g.dart';

abstract class GfindLoggedInUserReq
    implements
        Built<GfindLoggedInUserReq, GfindLoggedInUserReqBuilder>,
        _i1.OperationRequest<_i2.GfindLoggedInUserData,
            _i3.GfindLoggedInUserVars> {
  GfindLoggedInUserReq._();

  factory GfindLoggedInUserReq(
          [void Function(GfindLoggedInUserReqBuilder b) updates]) =
      _$GfindLoggedInUserReq;

  static void _initializeBuilder(GfindLoggedInUserReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'findLoggedInUser',
    )
    ..executeOnListen = true;

  @override
  _i3.GfindLoggedInUserVars get vars;
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
  _i2.GfindLoggedInUserData? Function(
    _i2.GfindLoggedInUserData?,
    _i2.GfindLoggedInUserData?,
  )? get updateResult;
  @override
  _i2.GfindLoggedInUserData? get optimisticResponse;
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
  _i2.GfindLoggedInUserData? parseData(Map<String, dynamic> json) =>
      _i2.GfindLoggedInUserData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GfindLoggedInUserData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GfindLoggedInUserData, _i3.GfindLoggedInUserVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GfindLoggedInUserReq> get serializer =>
      _$gfindLoggedInUserReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GfindLoggedInUserReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GfindLoggedInUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GfindLoggedInUserReq.serializer,
        json,
      );
}

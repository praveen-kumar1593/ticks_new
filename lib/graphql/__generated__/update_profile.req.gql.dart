// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:ticks_new/graphql/__generated__/update_profile.ast.gql.dart'
    as _i5;
import 'package:ticks_new/graphql/__generated__/update_profile.data.gql.dart'
    as _i2;
import 'package:ticks_new/graphql/__generated__/update_profile.var.gql.dart'
    as _i3;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'update_profile.req.gql.g.dart';

abstract class GupdateProfileReq
    implements
        Built<GupdateProfileReq, GupdateProfileReqBuilder>,
        _i1.OperationRequest<_i2.GupdateProfileData, _i3.GupdateProfileVars> {
  GupdateProfileReq._();

  factory GupdateProfileReq(
          [void Function(GupdateProfileReqBuilder b) updates]) =
      _$GupdateProfileReq;

  static void _initializeBuilder(GupdateProfileReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'updateProfile',
    )
    ..executeOnListen = true;

  @override
  _i3.GupdateProfileVars get vars;
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
  _i2.GupdateProfileData? Function(
    _i2.GupdateProfileData?,
    _i2.GupdateProfileData?,
  )? get updateResult;
  @override
  _i2.GupdateProfileData? get optimisticResponse;
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
  _i2.GupdateProfileData? parseData(Map<String, dynamic> json) =>
      _i2.GupdateProfileData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GupdateProfileData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GupdateProfileData, _i3.GupdateProfileVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GupdateProfileReq> get serializer =>
      _$gupdateProfileReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GupdateProfileReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GupdateProfileReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GupdateProfileReq.serializer,
        json,
      );
}

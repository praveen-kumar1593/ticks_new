// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:ticks_new/graphql/schemas/__generated__/geofence.ast.gql.dart'
    as _i5;
import 'package:ticks_new/graphql/schemas/__generated__/geofence.data.gql.dart'
    as _i2;
import 'package:ticks_new/graphql/schemas/__generated__/geofence.var.gql.dart'
    as _i3;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'geofence.req.gql.g.dart';

abstract class GlistAllGeoFencesReq
    implements
        Built<GlistAllGeoFencesReq, GlistAllGeoFencesReqBuilder>,
        _i1.OperationRequest<_i2.GlistAllGeoFencesData,
            _i3.GlistAllGeoFencesVars> {
  GlistAllGeoFencesReq._();

  factory GlistAllGeoFencesReq(
          [void Function(GlistAllGeoFencesReqBuilder b) updates]) =
      _$GlistAllGeoFencesReq;

  static void _initializeBuilder(GlistAllGeoFencesReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'listAllGeoFences',
    )
    ..executeOnListen = true;

  @override
  _i3.GlistAllGeoFencesVars get vars;
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
  _i2.GlistAllGeoFencesData? Function(
    _i2.GlistAllGeoFencesData?,
    _i2.GlistAllGeoFencesData?,
  )? get updateResult;
  @override
  _i2.GlistAllGeoFencesData? get optimisticResponse;
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
  _i2.GlistAllGeoFencesData? parseData(Map<String, dynamic> json) =>
      _i2.GlistAllGeoFencesData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GlistAllGeoFencesData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GlistAllGeoFencesData, _i3.GlistAllGeoFencesVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GlistAllGeoFencesReq> get serializer =>
      _$glistAllGeoFencesReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GlistAllGeoFencesReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GlistAllGeoFencesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GlistAllGeoFencesReq.serializer,
        json,
      );
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/schema.schema.gql.dart' as _i1;
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'geofence.var.gql.g.dart';

abstract class GlistAllGeoFencesVars
    implements Built<GlistAllGeoFencesVars, GlistAllGeoFencesVarsBuilder> {
  GlistAllGeoFencesVars._();

  factory GlistAllGeoFencesVars(
          [void Function(GlistAllGeoFencesVarsBuilder b) updates]) =
      _$GlistAllGeoFencesVars;

  _i1.GgeofenceList? get data;
  static Serializer<GlistAllGeoFencesVars> get serializer =>
      _$glistAllGeoFencesVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GlistAllGeoFencesVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GlistAllGeoFencesVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GlistAllGeoFencesVars.serializer,
        json,
      );
}

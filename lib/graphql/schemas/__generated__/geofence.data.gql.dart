// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i2;
import 'package:built_value/serializer.dart';

part 'geofence.data.gql.g.dart';

abstract class GlistAllGeoFencesData
    implements Built<GlistAllGeoFencesData, GlistAllGeoFencesDataBuilder> {
  GlistAllGeoFencesData._();

  factory GlistAllGeoFencesData(
          [void Function(GlistAllGeoFencesDataBuilder b) updates]) =
      _$GlistAllGeoFencesData;

  static void _initializeBuilder(GlistAllGeoFencesDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GlistAllGeoFencesData_listAllGeoFences? get listAllGeoFences;
  static Serializer<GlistAllGeoFencesData> get serializer =>
      _$glistAllGeoFencesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GlistAllGeoFencesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GlistAllGeoFencesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GlistAllGeoFencesData.serializer,
        json,
      );
}

abstract class GlistAllGeoFencesData_listAllGeoFences
    implements
        Built<GlistAllGeoFencesData_listAllGeoFences,
            GlistAllGeoFencesData_listAllGeoFencesBuilder> {
  GlistAllGeoFencesData_listAllGeoFences._();

  factory GlistAllGeoFencesData_listAllGeoFences(
      [void Function(GlistAllGeoFencesData_listAllGeoFencesBuilder b)
          updates]) = _$GlistAllGeoFencesData_listAllGeoFences;

  static void _initializeBuilder(
          GlistAllGeoFencesData_listAllGeoFencesBuilder b) =>
      b..G__typename = 'ListAllGeoFencesResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GlistAllGeoFencesData_listAllGeoFences_data?>? get data;
  int? get totalCount;
  static Serializer<GlistAllGeoFencesData_listAllGeoFences> get serializer =>
      _$glistAllGeoFencesDataListAllGeoFencesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GlistAllGeoFencesData_listAllGeoFences.serializer,
        this,
      ) as Map<String, dynamic>);

  static GlistAllGeoFencesData_listAllGeoFences? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GlistAllGeoFencesData_listAllGeoFences.serializer,
        json,
      );
}

abstract class GlistAllGeoFencesData_listAllGeoFences_data
    implements
        Built<GlistAllGeoFencesData_listAllGeoFences_data,
            GlistAllGeoFencesData_listAllGeoFences_dataBuilder> {
  GlistAllGeoFencesData_listAllGeoFences_data._();

  factory GlistAllGeoFencesData_listAllGeoFences_data(
      [void Function(GlistAllGeoFencesData_listAllGeoFences_dataBuilder b)
          updates]) = _$GlistAllGeoFencesData_listAllGeoFences_data;

  static void _initializeBuilder(
          GlistAllGeoFencesData_listAllGeoFences_dataBuilder b) =>
      b..G__typename = 'GeofenceData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get type;
  _i2.JsonObject? get data;
  static Serializer<GlistAllGeoFencesData_listAllGeoFences_data>
      get serializer => _$glistAllGeoFencesDataListAllGeoFencesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GlistAllGeoFencesData_listAllGeoFences_data.serializer,
        this,
      ) as Map<String, dynamic>);

  static GlistAllGeoFencesData_listAllGeoFences_data? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GlistAllGeoFencesData_listAllGeoFences_data.serializer,
        json,
      );
}

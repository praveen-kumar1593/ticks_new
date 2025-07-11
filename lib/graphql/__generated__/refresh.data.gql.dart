// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i1;
import 'package:built_value/serializer.dart';

part 'refresh.data.gql.g.dart';

abstract class GRefreshData
    implements Built<GRefreshData, GRefreshDataBuilder> {
  GRefreshData._();

  factory GRefreshData([void Function(GRefreshDataBuilder b) updates]) =
      _$GRefreshData;

  static void _initializeBuilder(GRefreshDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i1.JsonObject? get refresh;
  static Serializer<GRefreshData> get serializer => _$gRefreshDataSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GRefreshData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GRefreshData.serializer,
        json,
      );
}

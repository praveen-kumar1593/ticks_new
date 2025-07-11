// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'refresh.var.gql.g.dart';

abstract class GRefreshVars
    implements Built<GRefreshVars, GRefreshVarsBuilder> {
  GRefreshVars._();

  factory GRefreshVars([void Function(GRefreshVarsBuilder b) updates]) =
      _$GRefreshVars;

  String get refreshToken;
  static Serializer<GRefreshVars> get serializer => _$gRefreshVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshVars.serializer,
        json,
      );
}

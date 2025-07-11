// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i1;
import 'package:built_value/serializer.dart';

part 'login.var.gql.g.dart';

abstract class GloginVars implements Built<GloginVars, GloginVarsBuilder> {
  GloginVars._();

  factory GloginVars([void Function(GloginVarsBuilder b) updates]) =
      _$GloginVars;

  _i1.JsonObject? get credentials;
  bool? get isDevMode;
  String? get origin;
  static Serializer<GloginVars> get serializer => _$gloginVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GloginVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GloginVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GloginVars.serializer,
        json,
      );
}

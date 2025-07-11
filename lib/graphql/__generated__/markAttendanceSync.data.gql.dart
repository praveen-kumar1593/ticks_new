// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'markAttendanceSync.data.gql.g.dart';

abstract class GmarkAttendanceSyncData
    implements Built<GmarkAttendanceSyncData, GmarkAttendanceSyncDataBuilder> {
  GmarkAttendanceSyncData._();

  factory GmarkAttendanceSyncData(
          [void Function(GmarkAttendanceSyncDataBuilder b) updates]) =
      _$GmarkAttendanceSyncData;

  static void _initializeBuilder(GmarkAttendanceSyncDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GmarkAttendanceSyncData_markAttendanceSync? get markAttendanceSync;
  static Serializer<GmarkAttendanceSyncData> get serializer =>
      _$gmarkAttendanceSyncDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GmarkAttendanceSyncData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GmarkAttendanceSyncData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GmarkAttendanceSyncData.serializer,
        json,
      );
}

abstract class GmarkAttendanceSyncData_markAttendanceSync
    implements
        Built<GmarkAttendanceSyncData_markAttendanceSync,
            GmarkAttendanceSyncData_markAttendanceSyncBuilder> {
  GmarkAttendanceSyncData_markAttendanceSync._();

  factory GmarkAttendanceSyncData_markAttendanceSync(
      [void Function(GmarkAttendanceSyncData_markAttendanceSyncBuilder b)
          updates]) = _$GmarkAttendanceSyncData_markAttendanceSync;

  static void _initializeBuilder(
          GmarkAttendanceSyncData_markAttendanceSyncBuilder b) =>
      b..G__typename = 'SyncResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get status;
  static Serializer<GmarkAttendanceSyncData_markAttendanceSync>
      get serializer => _$gmarkAttendanceSyncDataMarkAttendanceSyncSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GmarkAttendanceSyncData_markAttendanceSync.serializer,
        this,
      ) as Map<String, dynamic>);

  static GmarkAttendanceSyncData_markAttendanceSync? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GmarkAttendanceSyncData_markAttendanceSync.serializer,
        json,
      );
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markUserAttendance.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkUserAttendanceData> _$gMarkUserAttendanceDataSerializer =
    _$GMarkUserAttendanceDataSerializer();
Serializer<GMarkUserAttendanceData_markUserAttendance>
    _$gMarkUserAttendanceDataMarkUserAttendanceSerializer =
    _$GMarkUserAttendanceData_markUserAttendanceSerializer();

class _$GMarkUserAttendanceDataSerializer
    implements StructuredSerializer<GMarkUserAttendanceData> {
  @override
  final Iterable<Type> types = const [
    GMarkUserAttendanceData,
    _$GMarkUserAttendanceData
  ];
  @override
  final String wireName = 'GMarkUserAttendanceData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkUserAttendanceData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.markUserAttendance;
    if (value != null) {
      result
        ..add('markUserAttendance')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GMarkUserAttendanceData_markUserAttendance)));
    }
    return result;
  }

  @override
  GMarkUserAttendanceData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkUserAttendanceDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'markUserAttendance':
          result.markUserAttendance.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GMarkUserAttendanceData_markUserAttendance))!
              as GMarkUserAttendanceData_markUserAttendance);
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkUserAttendanceData_markUserAttendanceSerializer
    implements
        StructuredSerializer<GMarkUserAttendanceData_markUserAttendance> {
  @override
  final Iterable<Type> types = const [
    GMarkUserAttendanceData_markUserAttendance,
    _$GMarkUserAttendanceData_markUserAttendance
  ];
  @override
  final String wireName = 'GMarkUserAttendanceData_markUserAttendance';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMarkUserAttendanceData_markUserAttendance object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.newStatus;
    if (value != null) {
      result
        ..add('newStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.attendanceId;
    if (value != null) {
      result
        ..add('attendanceId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GMarkUserAttendanceData_markUserAttendance deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkUserAttendanceData_markUserAttendanceBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'newStatus':
          result.newStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'attendanceId':
          result.attendanceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkUserAttendanceData extends GMarkUserAttendanceData {
  @override
  final String G__typename;
  @override
  final GMarkUserAttendanceData_markUserAttendance? markUserAttendance;

  factory _$GMarkUserAttendanceData(
          [void Function(GMarkUserAttendanceDataBuilder)? updates]) =>
      (GMarkUserAttendanceDataBuilder()..update(updates))._build();

  _$GMarkUserAttendanceData._(
      {required this.G__typename, this.markUserAttendance})
      : super._();
  @override
  GMarkUserAttendanceData rebuild(
          void Function(GMarkUserAttendanceDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkUserAttendanceDataBuilder toBuilder() =>
      GMarkUserAttendanceDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkUserAttendanceData &&
        G__typename == other.G__typename &&
        markUserAttendance == other.markUserAttendance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, markUserAttendance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkUserAttendanceData')
          ..add('G__typename', G__typename)
          ..add('markUserAttendance', markUserAttendance))
        .toString();
  }
}

class GMarkUserAttendanceDataBuilder
    implements
        Builder<GMarkUserAttendanceData, GMarkUserAttendanceDataBuilder> {
  _$GMarkUserAttendanceData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMarkUserAttendanceData_markUserAttendanceBuilder? _markUserAttendance;
  GMarkUserAttendanceData_markUserAttendanceBuilder get markUserAttendance =>
      _$this._markUserAttendance ??=
          GMarkUserAttendanceData_markUserAttendanceBuilder();
  set markUserAttendance(
          GMarkUserAttendanceData_markUserAttendanceBuilder?
              markUserAttendance) =>
      _$this._markUserAttendance = markUserAttendance;

  GMarkUserAttendanceDataBuilder() {
    GMarkUserAttendanceData._initializeBuilder(this);
  }

  GMarkUserAttendanceDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _markUserAttendance = $v.markUserAttendance?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkUserAttendanceData other) {
    _$v = other as _$GMarkUserAttendanceData;
  }

  @override
  void update(void Function(GMarkUserAttendanceDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkUserAttendanceData build() => _build();

  _$GMarkUserAttendanceData _build() {
    _$GMarkUserAttendanceData _$result;
    try {
      _$result = _$v ??
          _$GMarkUserAttendanceData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GMarkUserAttendanceData', 'G__typename'),
            markUserAttendance: _markUserAttendance?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'markUserAttendance';
        _markUserAttendance?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMarkUserAttendanceData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMarkUserAttendanceData_markUserAttendance
    extends GMarkUserAttendanceData_markUserAttendance {
  @override
  final String G__typename;
  @override
  final String? newStatus;
  @override
  final String? attendanceId;

  factory _$GMarkUserAttendanceData_markUserAttendance(
          [void Function(GMarkUserAttendanceData_markUserAttendanceBuilder)?
              updates]) =>
      (GMarkUserAttendanceData_markUserAttendanceBuilder()..update(updates))
          ._build();

  _$GMarkUserAttendanceData_markUserAttendance._(
      {required this.G__typename, this.newStatus, this.attendanceId})
      : super._();
  @override
  GMarkUserAttendanceData_markUserAttendance rebuild(
          void Function(GMarkUserAttendanceData_markUserAttendanceBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkUserAttendanceData_markUserAttendanceBuilder toBuilder() =>
      GMarkUserAttendanceData_markUserAttendanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkUserAttendanceData_markUserAttendance &&
        G__typename == other.G__typename &&
        newStatus == other.newStatus &&
        attendanceId == other.attendanceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, newStatus.hashCode);
    _$hash = $jc(_$hash, attendanceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMarkUserAttendanceData_markUserAttendance')
          ..add('G__typename', G__typename)
          ..add('newStatus', newStatus)
          ..add('attendanceId', attendanceId))
        .toString();
  }
}

class GMarkUserAttendanceData_markUserAttendanceBuilder
    implements
        Builder<GMarkUserAttendanceData_markUserAttendance,
            GMarkUserAttendanceData_markUserAttendanceBuilder> {
  _$GMarkUserAttendanceData_markUserAttendance? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _newStatus;
  String? get newStatus => _$this._newStatus;
  set newStatus(String? newStatus) => _$this._newStatus = newStatus;

  String? _attendanceId;
  String? get attendanceId => _$this._attendanceId;
  set attendanceId(String? attendanceId) => _$this._attendanceId = attendanceId;

  GMarkUserAttendanceData_markUserAttendanceBuilder() {
    GMarkUserAttendanceData_markUserAttendance._initializeBuilder(this);
  }

  GMarkUserAttendanceData_markUserAttendanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _newStatus = $v.newStatus;
      _attendanceId = $v.attendanceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkUserAttendanceData_markUserAttendance other) {
    _$v = other as _$GMarkUserAttendanceData_markUserAttendance;
  }

  @override
  void update(
      void Function(GMarkUserAttendanceData_markUserAttendanceBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkUserAttendanceData_markUserAttendance build() => _build();

  _$GMarkUserAttendanceData_markUserAttendance _build() {
    final _$result = _$v ??
        _$GMarkUserAttendanceData_markUserAttendance._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GMarkUserAttendanceData_markUserAttendance', 'G__typename'),
          newStatus: newStatus,
          attendanceId: attendanceId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetchUserAttendanceStatus.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GfetchUserAttendanceStatusData>
    _$gfetchUserAttendanceStatusDataSerializer =
    _$GfetchUserAttendanceStatusDataSerializer();
Serializer<GfetchUserAttendanceStatusData_fetchUserAttendanceStatus>
    _$gfetchUserAttendanceStatusDataFetchUserAttendanceStatusSerializer =
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatusSerializer();
Serializer<GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user>
    _$gfetchUserAttendanceStatusDataFetchUserAttendanceStatusUserSerializer =
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userSerializer();
Serializer<GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type>
    _$gfetchUserAttendanceStatusDataFetchUserAttendanceStatusUserTypeSerializer =
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeSerializer();
Serializer<
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak>
    _$gfetchUserAttendanceStatusDataFetchUserAttendanceStatusAttendanceBreakSerializer =
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakSerializer();

class _$GfetchUserAttendanceStatusDataSerializer
    implements StructuredSerializer<GfetchUserAttendanceStatusData> {
  @override
  final Iterable<Type> types = const [
    GfetchUserAttendanceStatusData,
    _$GfetchUserAttendanceStatusData
  ];
  @override
  final String wireName = 'GfetchUserAttendanceStatusData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GfetchUserAttendanceStatusData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.fetchUserAttendanceStatus;
    if (value != null) {
      result
        ..add('fetchUserAttendanceStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GfetchUserAttendanceStatusData_fetchUserAttendanceStatus)));
    }
    return result;
  }

  @override
  GfetchUserAttendanceStatusData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GfetchUserAttendanceStatusDataBuilder();

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
        case 'fetchUserAttendanceStatus':
          result.fetchUserAttendanceStatus.replace(serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus))!
              as GfetchUserAttendanceStatusData_fetchUserAttendanceStatus);
          break;
      }
    }

    return result.build();
  }
}

class _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatusSerializer
    implements
        StructuredSerializer<
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus> {
  @override
  final Iterable<Type> types = const [
    GfetchUserAttendanceStatusData_fetchUserAttendanceStatus,
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus
  ];
  @override
  final String wireName =
      'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.attendanceId;
    if (value != null) {
      result
        ..add('attendanceId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user)));
    }
    value = object.date;
    if (value != null) {
      result
        ..add('date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDatetime)));
    }
    value = object.checkInTime;
    if (value != null) {
      result
        ..add('checkInTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDatetime)));
    }
    value = object.checkOutTime;
    if (value != null) {
      result
        ..add('checkOutTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDatetime)));
    }
    value = object.expectedCheckInTime;
    if (value != null) {
      result
        ..add('expectedCheckInTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDatetime)));
    }
    value = object.expectedCheckOutTime;
    if (value != null) {
      result
        ..add('expectedCheckOutTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDatetime)));
    }
    value = object.currentStatus;
    if (value != null) {
      result
        ..add('currentStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.allowedBreak;
    if (value != null) {
      result
        ..add('allowedBreak')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.bufferTime;
    if (value != null) {
      result
        ..add('bufferTime')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.attendanceStatusesObj;
    if (value != null) {
      result
        ..add('attendanceStatusesObj')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i3.JsonObject)));
    }
    value = object.attendanceBreak;
    if (value != null) {
      result
        ..add('attendanceBreak')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType.nullable(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak)
            ])));
    }
    value = object.createdOn;
    if (value != null) {
      result
        ..add('createdOn')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDatetime)));
    }
    value = object.updatedOn;
    if (value != null) {
      result
        ..add('updatedOn')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDatetime)));
    }
    return result;
  }

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder();

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
        case 'attendanceId':
          result.attendanceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user))!
              as GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user);
          break;
        case 'date':
          result.date.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDatetime))! as _i2.GDatetime);
          break;
        case 'checkInTime':
          result.checkInTime.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDatetime))! as _i2.GDatetime);
          break;
        case 'checkOutTime':
          result.checkOutTime.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDatetime))! as _i2.GDatetime);
          break;
        case 'expectedCheckInTime':
          result.expectedCheckInTime.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDatetime))! as _i2.GDatetime);
          break;
        case 'expectedCheckOutTime':
          result.expectedCheckOutTime.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDatetime))! as _i2.GDatetime);
          break;
        case 'currentStatus':
          result.currentStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'allowedBreak':
          result.allowedBreak = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'bufferTime':
          result.bufferTime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'attendanceStatusesObj':
          result.attendanceStatusesObj = serializers.deserialize(value,
              specifiedType: const FullType(_i3.JsonObject)) as _i3.JsonObject?;
          break;
        case 'attendanceBreak':
          result.attendanceBreak.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType.nullable(
                    GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak)
              ]))! as BuiltList<Object?>);
          break;
        case 'createdOn':
          result.createdOn.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDatetime))! as _i2.GDatetime);
          break;
        case 'updatedOn':
          result.updatedOn.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDatetime))! as _i2.GDatetime);
          break;
      }
    }

    return result.build();
  }
}

class _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userSerializer
    implements
        StructuredSerializer<
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user> {
  @override
  final Iterable<Type> types = const [
    GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user,
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user
  ];
  @override
  final String wireName =
      'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type)));
    }
    value = object.referenceId;
    if (value != null) {
      result
        ..add('referenceId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.contactNumber;
    if (value != null) {
      result
        ..add('contactNumber')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailId;
    if (value != null) {
      result
        ..add('emailId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.employeeId;
    if (value != null) {
      result
        ..add('employeeId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'type':
          result.type.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type))!
              as GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type);
          break;
        case 'referenceId':
          result.referenceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'contactNumber':
          result.contactNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'emailId':
          result.emailId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'employeeId':
          result.employeeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeSerializer
    implements
        StructuredSerializer<
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type> {
  @override
  final Iterable<Type> types = const [
    GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type,
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
  ];
  @override
  final String wireName =
      'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakSerializer
    implements
        StructuredSerializer<
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak> {
  @override
  final Iterable<Type> types = const [
    GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak,
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
  ];
  @override
  final String wireName =
      'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.breakId;
    if (value != null) {
      result
        ..add('breakId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.startTime;
    if (value != null) {
      result
        ..add('startTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDatetime)));
    }
    value = object.endTime;
    if (value != null) {
      result
        ..add('endTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDatetime)));
    }
    value = object.duration;
    if (value != null) {
      result
        ..add('duration')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder();

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
        case 'breakId':
          result.breakId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'startTime':
          result.startTime.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDatetime))! as _i2.GDatetime);
          break;
        case 'endTime':
          result.endTime.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDatetime))! as _i2.GDatetime);
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GfetchUserAttendanceStatusData extends GfetchUserAttendanceStatusData {
  @override
  final String G__typename;
  @override
  final GfetchUserAttendanceStatusData_fetchUserAttendanceStatus?
      fetchUserAttendanceStatus;

  factory _$GfetchUserAttendanceStatusData(
          [void Function(GfetchUserAttendanceStatusDataBuilder)? updates]) =>
      (GfetchUserAttendanceStatusDataBuilder()..update(updates))._build();

  _$GfetchUserAttendanceStatusData._(
      {required this.G__typename, this.fetchUserAttendanceStatus})
      : super._();
  @override
  GfetchUserAttendanceStatusData rebuild(
          void Function(GfetchUserAttendanceStatusDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfetchUserAttendanceStatusDataBuilder toBuilder() =>
      GfetchUserAttendanceStatusDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GfetchUserAttendanceStatusData &&
        G__typename == other.G__typename &&
        fetchUserAttendanceStatus == other.fetchUserAttendanceStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, fetchUserAttendanceStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GfetchUserAttendanceStatusData')
          ..add('G__typename', G__typename)
          ..add('fetchUserAttendanceStatus', fetchUserAttendanceStatus))
        .toString();
  }
}

class GfetchUserAttendanceStatusDataBuilder
    implements
        Builder<GfetchUserAttendanceStatusData,
            GfetchUserAttendanceStatusDataBuilder> {
  _$GfetchUserAttendanceStatusData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder?
      _fetchUserAttendanceStatus;
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder
      get fetchUserAttendanceStatus => _$this._fetchUserAttendanceStatus ??=
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder();
  set fetchUserAttendanceStatus(
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder?
              fetchUserAttendanceStatus) =>
      _$this._fetchUserAttendanceStatus = fetchUserAttendanceStatus;

  GfetchUserAttendanceStatusDataBuilder() {
    GfetchUserAttendanceStatusData._initializeBuilder(this);
  }

  GfetchUserAttendanceStatusDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _fetchUserAttendanceStatus = $v.fetchUserAttendanceStatus?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GfetchUserAttendanceStatusData other) {
    _$v = other as _$GfetchUserAttendanceStatusData;
  }

  @override
  void update(void Function(GfetchUserAttendanceStatusDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GfetchUserAttendanceStatusData build() => _build();

  _$GfetchUserAttendanceStatusData _build() {
    _$GfetchUserAttendanceStatusData _$result;
    try {
      _$result = _$v ??
          _$GfetchUserAttendanceStatusData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GfetchUserAttendanceStatusData', 'G__typename'),
            fetchUserAttendanceStatus: _fetchUserAttendanceStatus?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'fetchUserAttendanceStatus';
        _fetchUserAttendanceStatus?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GfetchUserAttendanceStatusData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus
    extends GfetchUserAttendanceStatusData_fetchUserAttendanceStatus {
  @override
  final String G__typename;
  @override
  final String? attendanceId;
  @override
  final GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user? user;
  @override
  final _i2.GDatetime? date;
  @override
  final _i2.GDatetime? checkInTime;
  @override
  final _i2.GDatetime? checkOutTime;
  @override
  final _i2.GDatetime? expectedCheckInTime;
  @override
  final _i2.GDatetime? expectedCheckOutTime;
  @override
  final String? currentStatus;
  @override
  final int? allowedBreak;
  @override
  final int? bufferTime;
  @override
  final _i3.JsonObject? attendanceStatusesObj;
  @override
  final BuiltList<
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak?>?
      attendanceBreak;
  @override
  final _i2.GDatetime? createdOn;
  @override
  final _i2.GDatetime? updatedOn;

  factory _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus(
          [void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder)?
              updates]) =>
      (GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder()
            ..update(updates))
          ._build();

  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus._(
      {required this.G__typename,
      this.attendanceId,
      this.user,
      this.date,
      this.checkInTime,
      this.checkOutTime,
      this.expectedCheckInTime,
      this.expectedCheckOutTime,
      this.currentStatus,
      this.allowedBreak,
      this.bufferTime,
      this.attendanceStatusesObj,
      this.attendanceBreak,
      this.createdOn,
      this.updatedOn})
      : super._();
  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus rebuild(
          void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder toBuilder() =>
      GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GfetchUserAttendanceStatusData_fetchUserAttendanceStatus &&
        G__typename == other.G__typename &&
        attendanceId == other.attendanceId &&
        user == other.user &&
        date == other.date &&
        checkInTime == other.checkInTime &&
        checkOutTime == other.checkOutTime &&
        expectedCheckInTime == other.expectedCheckInTime &&
        expectedCheckOutTime == other.expectedCheckOutTime &&
        currentStatus == other.currentStatus &&
        allowedBreak == other.allowedBreak &&
        bufferTime == other.bufferTime &&
        attendanceStatusesObj == other.attendanceStatusesObj &&
        attendanceBreak == other.attendanceBreak &&
        createdOn == other.createdOn &&
        updatedOn == other.updatedOn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, attendanceId.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, checkInTime.hashCode);
    _$hash = $jc(_$hash, checkOutTime.hashCode);
    _$hash = $jc(_$hash, expectedCheckInTime.hashCode);
    _$hash = $jc(_$hash, expectedCheckOutTime.hashCode);
    _$hash = $jc(_$hash, currentStatus.hashCode);
    _$hash = $jc(_$hash, allowedBreak.hashCode);
    _$hash = $jc(_$hash, bufferTime.hashCode);
    _$hash = $jc(_$hash, attendanceStatusesObj.hashCode);
    _$hash = $jc(_$hash, attendanceBreak.hashCode);
    _$hash = $jc(_$hash, createdOn.hashCode);
    _$hash = $jc(_$hash, updatedOn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus')
          ..add('G__typename', G__typename)
          ..add('attendanceId', attendanceId)
          ..add('user', user)
          ..add('date', date)
          ..add('checkInTime', checkInTime)
          ..add('checkOutTime', checkOutTime)
          ..add('expectedCheckInTime', expectedCheckInTime)
          ..add('expectedCheckOutTime', expectedCheckOutTime)
          ..add('currentStatus', currentStatus)
          ..add('allowedBreak', allowedBreak)
          ..add('bufferTime', bufferTime)
          ..add('attendanceStatusesObj', attendanceStatusesObj)
          ..add('attendanceBreak', attendanceBreak)
          ..add('createdOn', createdOn)
          ..add('updatedOn', updatedOn))
        .toString();
  }
}

class GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder
    implements
        Builder<GfetchUserAttendanceStatusData_fetchUserAttendanceStatus,
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder> {
  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _attendanceId;
  String? get attendanceId => _$this._attendanceId;
  set attendanceId(String? attendanceId) => _$this._attendanceId = attendanceId;

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder? _user;
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder
      get user => _$this._user ??=
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder();
  set user(
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder?
              user) =>
      _$this._user = user;

  _i2.GDatetimeBuilder? _date;
  _i2.GDatetimeBuilder get date => _$this._date ??= _i2.GDatetimeBuilder();
  set date(_i2.GDatetimeBuilder? date) => _$this._date = date;

  _i2.GDatetimeBuilder? _checkInTime;
  _i2.GDatetimeBuilder get checkInTime =>
      _$this._checkInTime ??= _i2.GDatetimeBuilder();
  set checkInTime(_i2.GDatetimeBuilder? checkInTime) =>
      _$this._checkInTime = checkInTime;

  _i2.GDatetimeBuilder? _checkOutTime;
  _i2.GDatetimeBuilder get checkOutTime =>
      _$this._checkOutTime ??= _i2.GDatetimeBuilder();
  set checkOutTime(_i2.GDatetimeBuilder? checkOutTime) =>
      _$this._checkOutTime = checkOutTime;

  _i2.GDatetimeBuilder? _expectedCheckInTime;
  _i2.GDatetimeBuilder get expectedCheckInTime =>
      _$this._expectedCheckInTime ??= _i2.GDatetimeBuilder();
  set expectedCheckInTime(_i2.GDatetimeBuilder? expectedCheckInTime) =>
      _$this._expectedCheckInTime = expectedCheckInTime;

  _i2.GDatetimeBuilder? _expectedCheckOutTime;
  _i2.GDatetimeBuilder get expectedCheckOutTime =>
      _$this._expectedCheckOutTime ??= _i2.GDatetimeBuilder();
  set expectedCheckOutTime(_i2.GDatetimeBuilder? expectedCheckOutTime) =>
      _$this._expectedCheckOutTime = expectedCheckOutTime;

  String? _currentStatus;
  String? get currentStatus => _$this._currentStatus;
  set currentStatus(String? currentStatus) =>
      _$this._currentStatus = currentStatus;

  int? _allowedBreak;
  int? get allowedBreak => _$this._allowedBreak;
  set allowedBreak(int? allowedBreak) => _$this._allowedBreak = allowedBreak;

  int? _bufferTime;
  int? get bufferTime => _$this._bufferTime;
  set bufferTime(int? bufferTime) => _$this._bufferTime = bufferTime;

  _i3.JsonObject? _attendanceStatusesObj;
  _i3.JsonObject? get attendanceStatusesObj => _$this._attendanceStatusesObj;
  set attendanceStatusesObj(_i3.JsonObject? attendanceStatusesObj) =>
      _$this._attendanceStatusesObj = attendanceStatusesObj;

  ListBuilder<
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak?>?
      _attendanceBreak;
  ListBuilder<
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak?>
      get attendanceBreak => _$this._attendanceBreak ??= ListBuilder<
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak?>();
  set attendanceBreak(
          ListBuilder<
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak?>?
              attendanceBreak) =>
      _$this._attendanceBreak = attendanceBreak;

  _i2.GDatetimeBuilder? _createdOn;
  _i2.GDatetimeBuilder get createdOn =>
      _$this._createdOn ??= _i2.GDatetimeBuilder();
  set createdOn(_i2.GDatetimeBuilder? createdOn) =>
      _$this._createdOn = createdOn;

  _i2.GDatetimeBuilder? _updatedOn;
  _i2.GDatetimeBuilder get updatedOn =>
      _$this._updatedOn ??= _i2.GDatetimeBuilder();
  set updatedOn(_i2.GDatetimeBuilder? updatedOn) =>
      _$this._updatedOn = updatedOn;

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder() {
    GfetchUserAttendanceStatusData_fetchUserAttendanceStatus._initializeBuilder(
        this);
  }

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _attendanceId = $v.attendanceId;
      _user = $v.user?.toBuilder();
      _date = $v.date?.toBuilder();
      _checkInTime = $v.checkInTime?.toBuilder();
      _checkOutTime = $v.checkOutTime?.toBuilder();
      _expectedCheckInTime = $v.expectedCheckInTime?.toBuilder();
      _expectedCheckOutTime = $v.expectedCheckOutTime?.toBuilder();
      _currentStatus = $v.currentStatus;
      _allowedBreak = $v.allowedBreak;
      _bufferTime = $v.bufferTime;
      _attendanceStatusesObj = $v.attendanceStatusesObj;
      _attendanceBreak = $v.attendanceBreak?.toBuilder();
      _createdOn = $v.createdOn?.toBuilder();
      _updatedOn = $v.updatedOn?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GfetchUserAttendanceStatusData_fetchUserAttendanceStatus other) {
    _$v = other as _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus;
  }

  @override
  void update(
      void Function(
              GfetchUserAttendanceStatusData_fetchUserAttendanceStatusBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus build() => _build();

  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus _build() {
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus _$result;
    try {
      _$result = _$v ??
          _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus',
                'G__typename'),
            attendanceId: attendanceId,
            user: _user?.build(),
            date: _date?.build(),
            checkInTime: _checkInTime?.build(),
            checkOutTime: _checkOutTime?.build(),
            expectedCheckInTime: _expectedCheckInTime?.build(),
            expectedCheckOutTime: _expectedCheckOutTime?.build(),
            currentStatus: currentStatus,
            allowedBreak: allowedBreak,
            bufferTime: bufferTime,
            attendanceStatusesObj: attendanceStatusesObj,
            attendanceBreak: _attendanceBreak?.build(),
            createdOn: _createdOn?.build(),
            updatedOn: _updatedOn?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
        _$failedField = 'date';
        _date?.build();
        _$failedField = 'checkInTime';
        _checkInTime?.build();
        _$failedField = 'checkOutTime';
        _checkOutTime?.build();
        _$failedField = 'expectedCheckInTime';
        _expectedCheckInTime?.build();
        _$failedField = 'expectedCheckOutTime';
        _expectedCheckOutTime?.build();

        _$failedField = 'attendanceBreak';
        _attendanceBreak?.build();
        _$failedField = 'createdOn';
        _createdOn?.build();
        _$failedField = 'updatedOn';
        _updatedOn?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user
    extends GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? name;
  @override
  final GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type?
      type;
  @override
  final String? referenceId;
  @override
  final String? contactNumber;
  @override
  final String? emailId;
  @override
  final String? status;
  @override
  final String? employeeId;

  factory _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user(
          [void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder)?
              updates]) =>
      (GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder()
            ..update(updates))
          ._build();

  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user._(
      {required this.G__typename,
      required this.id,
      this.name,
      this.type,
      this.referenceId,
      this.contactNumber,
      this.emailId,
      this.status,
      this.employeeId})
      : super._();
  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user rebuild(
          void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder
      toBuilder() =>
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        type == other.type &&
        referenceId == other.referenceId &&
        contactNumber == other.contactNumber &&
        emailId == other.emailId &&
        status == other.status &&
        employeeId == other.employeeId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, referenceId.hashCode);
    _$hash = $jc(_$hash, contactNumber.hashCode);
    _$hash = $jc(_$hash, emailId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, employeeId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('type', type)
          ..add('referenceId', referenceId)
          ..add('contactNumber', contactNumber)
          ..add('emailId', emailId)
          ..add('status', status)
          ..add('employeeId', employeeId))
        .toString();
  }
}

class GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder
    implements
        Builder<GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user,
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder> {
  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder?
      _type;
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder
      get type => _$this._type ??=
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder();
  set type(
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder?
              type) =>
      _$this._type = type;

  String? _referenceId;
  String? get referenceId => _$this._referenceId;
  set referenceId(String? referenceId) => _$this._referenceId = referenceId;

  String? _contactNumber;
  String? get contactNumber => _$this._contactNumber;
  set contactNumber(String? contactNumber) =>
      _$this._contactNumber = contactNumber;

  String? _emailId;
  String? get emailId => _$this._emailId;
  set emailId(String? emailId) => _$this._emailId = emailId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _employeeId;
  String? get employeeId => _$this._employeeId;
  set employeeId(String? employeeId) => _$this._employeeId = employeeId;

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder() {
    GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user
        ._initializeBuilder(this);
  }

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _type = $v.type?.toBuilder();
      _referenceId = $v.referenceId;
      _contactNumber = $v.contactNumber;
      _emailId = $v.emailId;
      _status = $v.status;
      _employeeId = $v.employeeId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user other) {
    _$v = other
        as _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user;
  }

  @override
  void update(
      void Function(
              GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_userBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user build() =>
      _build();

  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user _build() {
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user _$result;
    try {
      _$result = _$v ??
          _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id,
                r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user',
                'id'),
            name: name,
            type: _type?.build(),
            referenceId: referenceId,
            contactNumber: contactNumber,
            emailId: emailId,
            status: status,
            employeeId: employeeId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'type';
        _type?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
    extends GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type {
  @override
  final String G__typename;
  @override
  final String? name;
  @override
  final String? status;

  factory _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type(
          [void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder)?
              updates]) =>
      (GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder()
            ..update(updates))
          ._build();

  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type._(
      {required this.G__typename, this.name, this.status})
      : super._();
  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type rebuild(
          void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder
      toBuilder() =>
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type &&
        G__typename == other.G__typename &&
        name == other.name &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type')
          ..add('G__typename', G__typename)
          ..add('name', name)
          ..add('status', status))
        .toString();
  }
}

class GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder
    implements
        Builder<
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type,
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder> {
  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder() {
    GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
        ._initializeBuilder(this);
  }

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _name = $v.name;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
          other) {
    _$v = other
        as _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type;
  }

  @override
  void update(
      void Function(
              GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_typeBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type build() =>
      _build();

  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type
      _build() {
    final _$result = _$v ??
        _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_user_type',
              'G__typename'),
          name: name,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
    extends GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak {
  @override
  final String G__typename;
  @override
  final String? breakId;
  @override
  final _i2.GDatetime? startTime;
  @override
  final _i2.GDatetime? endTime;
  @override
  final int? duration;

  factory _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak(
          [void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder)?
              updates]) =>
      (GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder()
            ..update(updates))
          ._build();

  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak._(
      {required this.G__typename,
      this.breakId,
      this.startTime,
      this.endTime,
      this.duration})
      : super._();
  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak rebuild(
          void Function(
                  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder
      toBuilder() =>
          GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak &&
        G__typename == other.G__typename &&
        breakId == other.breakId &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        duration == other.duration;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, breakId.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, duration.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak')
          ..add('G__typename', G__typename)
          ..add('breakId', breakId)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('duration', duration))
        .toString();
  }
}

class GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder
    implements
        Builder<
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak,
            GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder> {
  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _breakId;
  String? get breakId => _$this._breakId;
  set breakId(String? breakId) => _$this._breakId = breakId;

  _i2.GDatetimeBuilder? _startTime;
  _i2.GDatetimeBuilder get startTime =>
      _$this._startTime ??= _i2.GDatetimeBuilder();
  set startTime(_i2.GDatetimeBuilder? startTime) =>
      _$this._startTime = startTime;

  _i2.GDatetimeBuilder? _endTime;
  _i2.GDatetimeBuilder get endTime =>
      _$this._endTime ??= _i2.GDatetimeBuilder();
  set endTime(_i2.GDatetimeBuilder? endTime) => _$this._endTime = endTime;

  int? _duration;
  int? get duration => _$this._duration;
  set duration(int? duration) => _$this._duration = duration;

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder() {
    GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
        ._initializeBuilder(this);
  }

  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _breakId = $v.breakId;
      _startTime = $v.startTime?.toBuilder();
      _endTime = $v.endTime?.toBuilder();
      _duration = $v.duration;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
          other) {
    _$v = other
        as _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak;
  }

  @override
  void update(
      void Function(
              GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreakBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
      build() => _build();

  _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
      _build() {
    _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
        _$result;
    try {
      _$result = _$v ??
          _$GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak
              ._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak',
                'G__typename'),
            breakId: breakId,
            startTime: _startTime?.build(),
            endTime: _endTime?.build(),
            duration: duration,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'startTime';
        _startTime?.build();
        _$failedField = 'endTime';
        _endTime?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GfetchUserAttendanceStatusData_fetchUserAttendanceStatus_attendanceBreak',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

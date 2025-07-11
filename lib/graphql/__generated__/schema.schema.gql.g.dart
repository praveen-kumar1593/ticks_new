// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUserAttendanceInput> _$gUserAttendanceInputSerializer =
    _$GUserAttendanceInputSerializer();
Serializer<GUserAttendanceBulkInput> _$gUserAttendanceBulkInputSerializer =
    _$GUserAttendanceBulkInputSerializer();
Serializer<GAttendanceLogInput> _$gAttendanceLogInputSerializer =
    _$GAttendanceLogInputSerializer();
Serializer<GgeofenceList> _$ggeofenceListSerializer =
    _$GgeofenceListSerializer();

class _$GUserAttendanceInputSerializer
    implements StructuredSerializer<GUserAttendanceInput> {
  @override
  final Iterable<Type> types = const [
    GUserAttendanceInput,
    _$GUserAttendanceInput
  ];
  @override
  final String wireName = 'GUserAttendanceInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserAttendanceInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.newStatus;
    if (value != null) {
      result
        ..add('newStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.date;
    if (value != null) {
      result
        ..add('date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GDatetime)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.locationName;
    if (value != null) {
      result
        ..add('locationName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.geofence;
    if (value != null) {
      result
        ..add('geofence')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.attendanceId;
    if (value != null) {
      result
        ..add('attendanceId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.breakId;
    if (value != null) {
      result
        ..add('breakId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.statusSince;
    if (value != null) {
      result
        ..add('statusSince')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.batteryLevel;
    if (value != null) {
      result
        ..add('batteryLevel')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.deviceId;
    if (value != null) {
      result
        ..add('deviceId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUserAttendanceInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserAttendanceInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'newStatus':
          result.newStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'date':
          result.date.replace(serializers.deserialize(value,
              specifiedType: const FullType(GDatetime))! as GDatetime);
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'locationName':
          result.locationName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'geofence':
          result.geofence = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'attendanceId':
          result.attendanceId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'breakId':
          result.breakId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'statusSince':
          result.statusSince = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'batteryLevel':
          result.batteryLevel = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'deviceId':
          result.deviceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUserAttendanceBulkInputSerializer
    implements StructuredSerializer<GUserAttendanceBulkInput> {
  @override
  final Iterable<Type> types = const [
    GUserAttendanceBulkInput,
    _$GUserAttendanceBulkInput
  ];
  @override
  final String wireName = 'GUserAttendanceBulkInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserAttendanceBulkInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(double)),
    ];
    Object? value;
    value = object.newStatus;
    if (value != null) {
      result
        ..add('newStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.date;
    if (value != null) {
      result
        ..add('date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GDatetime)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.locationName;
    if (value != null) {
      result
        ..add('locationName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.geofence;
    if (value != null) {
      result
        ..add('geofence')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.attendanceId;
    if (value != null) {
      result
        ..add('attendanceId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.breakId;
    if (value != null) {
      result
        ..add('breakId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.statusSince;
    if (value != null) {
      result
        ..add('statusSince')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.batteryLevel;
    if (value != null) {
      result
        ..add('batteryLevel')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.deviceId;
    if (value != null) {
      result
        ..add('deviceId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUserAttendanceBulkInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserAttendanceBulkInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'newStatus':
          result.newStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'date':
          result.date.replace(serializers.deserialize(value,
              specifiedType: const FullType(GDatetime))! as GDatetime);
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'locationName':
          result.locationName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'geofence':
          result.geofence = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'attendanceId':
          result.attendanceId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'breakId':
          result.breakId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'statusSince':
          result.statusSince = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'batteryLevel':
          result.batteryLevel = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'deviceId':
          result.deviceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GAttendanceLogInputSerializer
    implements StructuredSerializer<GAttendanceLogInput> {
  @override
  final Iterable<Type> types = const [
    GAttendanceLogInput,
    _$GAttendanceLogInput
  ];
  @override
  final String wireName = 'GAttendanceLogInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAttendanceLogInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fromDate;
    if (value != null) {
      result
        ..add('fromDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.toDate;
    if (value != null) {
      result
        ..add('toDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.attendanceStatus;
    if (value != null) {
      result
        ..add('attendanceStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GAttendanceLogInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GAttendanceLogInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fromDate':
          result.fromDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'toDate':
          result.toDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'attendanceStatus':
          result.attendanceStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GgeofenceListSerializer implements StructuredSerializer<GgeofenceList> {
  @override
  final Iterable<Type> types = const [GgeofenceList, _$GgeofenceList];
  @override
  final String wireName = 'GgeofenceList';

  @override
  Iterable<Object?> serialize(Serializers serializers, GgeofenceList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.domain;
    if (value != null) {
      result
        ..add('domain')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.searchFields;
    if (value != null) {
      result
        ..add('searchFields')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i3.JsonObject)));
    }
    value = object.page;
    if (value != null) {
      result
        ..add('page')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.limit;
    if (value != null) {
      result
        ..add('limit')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.order;
    if (value != null) {
      result
        ..add('order')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.sortField;
    if (value != null) {
      result
        ..add('sortField')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GgeofenceList deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GgeofenceListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'domain':
          result.domain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'searchFields':
          result.searchFields = serializers.deserialize(value,
              specifiedType: const FullType(_i3.JsonObject)) as _i3.JsonObject?;
          break;
        case 'page':
          result.page = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'limit':
          result.limit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'order':
          result.order = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'sortField':
          result.sortField = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GDatetime extends GDatetime {
  @override
  final String value;

  factory _$GDatetime([void Function(GDatetimeBuilder)? updates]) =>
      (GDatetimeBuilder()..update(updates))._build();

  _$GDatetime._({required this.value}) : super._();
  @override
  GDatetime rebuild(void Function(GDatetimeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDatetimeBuilder toBuilder() => GDatetimeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDatetime && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDatetime')..add('value', value))
        .toString();
  }
}

class GDatetimeBuilder implements Builder<GDatetime, GDatetimeBuilder> {
  _$GDatetime? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  GDatetimeBuilder();

  GDatetimeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDatetime other) {
    _$v = other as _$GDatetime;
  }

  @override
  void update(void Function(GDatetimeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDatetime build() => _build();

  _$GDatetime _build() {
    final _$result = _$v ??
        _$GDatetime._(
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'GDatetime', 'value'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUserAttendanceInput extends GUserAttendanceInput {
  @override
  final String? userId;
  @override
  final String? newStatus;
  @override
  final GDatetime? date;
  @override
  final String? location;
  @override
  final String? locationName;
  @override
  final String? geofence;
  @override
  final int? attendanceId;
  @override
  final int? breakId;
  @override
  final double? statusSince;
  @override
  final int? batteryLevel;
  @override
  final String? deviceId;

  factory _$GUserAttendanceInput(
          [void Function(GUserAttendanceInputBuilder)? updates]) =>
      (GUserAttendanceInputBuilder()..update(updates))._build();

  _$GUserAttendanceInput._(
      {this.userId,
      this.newStatus,
      this.date,
      this.location,
      this.locationName,
      this.geofence,
      this.attendanceId,
      this.breakId,
      this.statusSince,
      this.batteryLevel,
      this.deviceId})
      : super._();
  @override
  GUserAttendanceInput rebuild(
          void Function(GUserAttendanceInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserAttendanceInputBuilder toBuilder() =>
      GUserAttendanceInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserAttendanceInput &&
        userId == other.userId &&
        newStatus == other.newStatus &&
        date == other.date &&
        location == other.location &&
        locationName == other.locationName &&
        geofence == other.geofence &&
        attendanceId == other.attendanceId &&
        breakId == other.breakId &&
        statusSince == other.statusSince &&
        batteryLevel == other.batteryLevel &&
        deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, newStatus.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, locationName.hashCode);
    _$hash = $jc(_$hash, geofence.hashCode);
    _$hash = $jc(_$hash, attendanceId.hashCode);
    _$hash = $jc(_$hash, breakId.hashCode);
    _$hash = $jc(_$hash, statusSince.hashCode);
    _$hash = $jc(_$hash, batteryLevel.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUserAttendanceInput')
          ..add('userId', userId)
          ..add('newStatus', newStatus)
          ..add('date', date)
          ..add('location', location)
          ..add('locationName', locationName)
          ..add('geofence', geofence)
          ..add('attendanceId', attendanceId)
          ..add('breakId', breakId)
          ..add('statusSince', statusSince)
          ..add('batteryLevel', batteryLevel)
          ..add('deviceId', deviceId))
        .toString();
  }
}

class GUserAttendanceInputBuilder
    implements Builder<GUserAttendanceInput, GUserAttendanceInputBuilder> {
  _$GUserAttendanceInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _newStatus;
  String? get newStatus => _$this._newStatus;
  set newStatus(String? newStatus) => _$this._newStatus = newStatus;

  GDatetimeBuilder? _date;
  GDatetimeBuilder get date => _$this._date ??= GDatetimeBuilder();
  set date(GDatetimeBuilder? date) => _$this._date = date;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _locationName;
  String? get locationName => _$this._locationName;
  set locationName(String? locationName) => _$this._locationName = locationName;

  String? _geofence;
  String? get geofence => _$this._geofence;
  set geofence(String? geofence) => _$this._geofence = geofence;

  int? _attendanceId;
  int? get attendanceId => _$this._attendanceId;
  set attendanceId(int? attendanceId) => _$this._attendanceId = attendanceId;

  int? _breakId;
  int? get breakId => _$this._breakId;
  set breakId(int? breakId) => _$this._breakId = breakId;

  double? _statusSince;
  double? get statusSince => _$this._statusSince;
  set statusSince(double? statusSince) => _$this._statusSince = statusSince;

  int? _batteryLevel;
  int? get batteryLevel => _$this._batteryLevel;
  set batteryLevel(int? batteryLevel) => _$this._batteryLevel = batteryLevel;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  GUserAttendanceInputBuilder();

  GUserAttendanceInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _newStatus = $v.newStatus;
      _date = $v.date?.toBuilder();
      _location = $v.location;
      _locationName = $v.locationName;
      _geofence = $v.geofence;
      _attendanceId = $v.attendanceId;
      _breakId = $v.breakId;
      _statusSince = $v.statusSince;
      _batteryLevel = $v.batteryLevel;
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserAttendanceInput other) {
    _$v = other as _$GUserAttendanceInput;
  }

  @override
  void update(void Function(GUserAttendanceInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserAttendanceInput build() => _build();

  _$GUserAttendanceInput _build() {
    _$GUserAttendanceInput _$result;
    try {
      _$result = _$v ??
          _$GUserAttendanceInput._(
            userId: userId,
            newStatus: newStatus,
            date: _date?.build(),
            location: location,
            locationName: locationName,
            geofence: geofence,
            attendanceId: attendanceId,
            breakId: breakId,
            statusSince: statusSince,
            batteryLevel: batteryLevel,
            deviceId: deviceId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'date';
        _date?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserAttendanceInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUserAttendanceBulkInput extends GUserAttendanceBulkInput {
  @override
  final double userId;
  @override
  final String? newStatus;
  @override
  final GDatetime? date;
  @override
  final String? location;
  @override
  final String? locationName;
  @override
  final String? geofence;
  @override
  final int? attendanceId;
  @override
  final int? breakId;
  @override
  final double? statusSince;
  @override
  final int? batteryLevel;
  @override
  final String? deviceId;

  factory _$GUserAttendanceBulkInput(
          [void Function(GUserAttendanceBulkInputBuilder)? updates]) =>
      (GUserAttendanceBulkInputBuilder()..update(updates))._build();

  _$GUserAttendanceBulkInput._(
      {required this.userId,
      this.newStatus,
      this.date,
      this.location,
      this.locationName,
      this.geofence,
      this.attendanceId,
      this.breakId,
      this.statusSince,
      this.batteryLevel,
      this.deviceId})
      : super._();
  @override
  GUserAttendanceBulkInput rebuild(
          void Function(GUserAttendanceBulkInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserAttendanceBulkInputBuilder toBuilder() =>
      GUserAttendanceBulkInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserAttendanceBulkInput &&
        userId == other.userId &&
        newStatus == other.newStatus &&
        date == other.date &&
        location == other.location &&
        locationName == other.locationName &&
        geofence == other.geofence &&
        attendanceId == other.attendanceId &&
        breakId == other.breakId &&
        statusSince == other.statusSince &&
        batteryLevel == other.batteryLevel &&
        deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, newStatus.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, locationName.hashCode);
    _$hash = $jc(_$hash, geofence.hashCode);
    _$hash = $jc(_$hash, attendanceId.hashCode);
    _$hash = $jc(_$hash, breakId.hashCode);
    _$hash = $jc(_$hash, statusSince.hashCode);
    _$hash = $jc(_$hash, batteryLevel.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUserAttendanceBulkInput')
          ..add('userId', userId)
          ..add('newStatus', newStatus)
          ..add('date', date)
          ..add('location', location)
          ..add('locationName', locationName)
          ..add('geofence', geofence)
          ..add('attendanceId', attendanceId)
          ..add('breakId', breakId)
          ..add('statusSince', statusSince)
          ..add('batteryLevel', batteryLevel)
          ..add('deviceId', deviceId))
        .toString();
  }
}

class GUserAttendanceBulkInputBuilder
    implements
        Builder<GUserAttendanceBulkInput, GUserAttendanceBulkInputBuilder> {
  _$GUserAttendanceBulkInput? _$v;

  double? _userId;
  double? get userId => _$this._userId;
  set userId(double? userId) => _$this._userId = userId;

  String? _newStatus;
  String? get newStatus => _$this._newStatus;
  set newStatus(String? newStatus) => _$this._newStatus = newStatus;

  GDatetimeBuilder? _date;
  GDatetimeBuilder get date => _$this._date ??= GDatetimeBuilder();
  set date(GDatetimeBuilder? date) => _$this._date = date;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _locationName;
  String? get locationName => _$this._locationName;
  set locationName(String? locationName) => _$this._locationName = locationName;

  String? _geofence;
  String? get geofence => _$this._geofence;
  set geofence(String? geofence) => _$this._geofence = geofence;

  int? _attendanceId;
  int? get attendanceId => _$this._attendanceId;
  set attendanceId(int? attendanceId) => _$this._attendanceId = attendanceId;

  int? _breakId;
  int? get breakId => _$this._breakId;
  set breakId(int? breakId) => _$this._breakId = breakId;

  double? _statusSince;
  double? get statusSince => _$this._statusSince;
  set statusSince(double? statusSince) => _$this._statusSince = statusSince;

  int? _batteryLevel;
  int? get batteryLevel => _$this._batteryLevel;
  set batteryLevel(int? batteryLevel) => _$this._batteryLevel = batteryLevel;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  GUserAttendanceBulkInputBuilder();

  GUserAttendanceBulkInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _newStatus = $v.newStatus;
      _date = $v.date?.toBuilder();
      _location = $v.location;
      _locationName = $v.locationName;
      _geofence = $v.geofence;
      _attendanceId = $v.attendanceId;
      _breakId = $v.breakId;
      _statusSince = $v.statusSince;
      _batteryLevel = $v.batteryLevel;
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserAttendanceBulkInput other) {
    _$v = other as _$GUserAttendanceBulkInput;
  }

  @override
  void update(void Function(GUserAttendanceBulkInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserAttendanceBulkInput build() => _build();

  _$GUserAttendanceBulkInput _build() {
    _$GUserAttendanceBulkInput _$result;
    try {
      _$result = _$v ??
          _$GUserAttendanceBulkInput._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GUserAttendanceBulkInput', 'userId'),
            newStatus: newStatus,
            date: _date?.build(),
            location: location,
            locationName: locationName,
            geofence: geofence,
            attendanceId: attendanceId,
            breakId: breakId,
            statusSince: statusSince,
            batteryLevel: batteryLevel,
            deviceId: deviceId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'date';
        _date?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserAttendanceBulkInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAttendanceLogInput extends GAttendanceLogInput {
  @override
  final String? userId;
  @override
  final String? fromDate;
  @override
  final String? toDate;
  @override
  final String? attendanceStatus;

  factory _$GAttendanceLogInput(
          [void Function(GAttendanceLogInputBuilder)? updates]) =>
      (GAttendanceLogInputBuilder()..update(updates))._build();

  _$GAttendanceLogInput._(
      {this.userId, this.fromDate, this.toDate, this.attendanceStatus})
      : super._();
  @override
  GAttendanceLogInput rebuild(
          void Function(GAttendanceLogInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAttendanceLogInputBuilder toBuilder() =>
      GAttendanceLogInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAttendanceLogInput &&
        userId == other.userId &&
        fromDate == other.fromDate &&
        toDate == other.toDate &&
        attendanceStatus == other.attendanceStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, fromDate.hashCode);
    _$hash = $jc(_$hash, toDate.hashCode);
    _$hash = $jc(_$hash, attendanceStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAttendanceLogInput')
          ..add('userId', userId)
          ..add('fromDate', fromDate)
          ..add('toDate', toDate)
          ..add('attendanceStatus', attendanceStatus))
        .toString();
  }
}

class GAttendanceLogInputBuilder
    implements Builder<GAttendanceLogInput, GAttendanceLogInputBuilder> {
  _$GAttendanceLogInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _fromDate;
  String? get fromDate => _$this._fromDate;
  set fromDate(String? fromDate) => _$this._fromDate = fromDate;

  String? _toDate;
  String? get toDate => _$this._toDate;
  set toDate(String? toDate) => _$this._toDate = toDate;

  String? _attendanceStatus;
  String? get attendanceStatus => _$this._attendanceStatus;
  set attendanceStatus(String? attendanceStatus) =>
      _$this._attendanceStatus = attendanceStatus;

  GAttendanceLogInputBuilder();

  GAttendanceLogInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _fromDate = $v.fromDate;
      _toDate = $v.toDate;
      _attendanceStatus = $v.attendanceStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAttendanceLogInput other) {
    _$v = other as _$GAttendanceLogInput;
  }

  @override
  void update(void Function(GAttendanceLogInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAttendanceLogInput build() => _build();

  _$GAttendanceLogInput _build() {
    final _$result = _$v ??
        _$GAttendanceLogInput._(
          userId: userId,
          fromDate: fromDate,
          toDate: toDate,
          attendanceStatus: attendanceStatus,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GgeofenceList extends GgeofenceList {
  @override
  final String? domain;
  @override
  final _i3.JsonObject? searchFields;
  @override
  final int? page;
  @override
  final int? limit;
  @override
  final String? order;
  @override
  final String? sortField;

  factory _$GgeofenceList([void Function(GgeofenceListBuilder)? updates]) =>
      (GgeofenceListBuilder()..update(updates))._build();

  _$GgeofenceList._(
      {this.domain,
      this.searchFields,
      this.page,
      this.limit,
      this.order,
      this.sortField})
      : super._();
  @override
  GgeofenceList rebuild(void Function(GgeofenceListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgeofenceListBuilder toBuilder() => GgeofenceListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgeofenceList &&
        domain == other.domain &&
        searchFields == other.searchFields &&
        page == other.page &&
        limit == other.limit &&
        order == other.order &&
        sortField == other.sortField;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, domain.hashCode);
    _$hash = $jc(_$hash, searchFields.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, order.hashCode);
    _$hash = $jc(_$hash, sortField.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GgeofenceList')
          ..add('domain', domain)
          ..add('searchFields', searchFields)
          ..add('page', page)
          ..add('limit', limit)
          ..add('order', order)
          ..add('sortField', sortField))
        .toString();
  }
}

class GgeofenceListBuilder
    implements Builder<GgeofenceList, GgeofenceListBuilder> {
  _$GgeofenceList? _$v;

  String? _domain;
  String? get domain => _$this._domain;
  set domain(String? domain) => _$this._domain = domain;

  _i3.JsonObject? _searchFields;
  _i3.JsonObject? get searchFields => _$this._searchFields;
  set searchFields(_i3.JsonObject? searchFields) =>
      _$this._searchFields = searchFields;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  String? _order;
  String? get order => _$this._order;
  set order(String? order) => _$this._order = order;

  String? _sortField;
  String? get sortField => _$this._sortField;
  set sortField(String? sortField) => _$this._sortField = sortField;

  GgeofenceListBuilder();

  GgeofenceListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _domain = $v.domain;
      _searchFields = $v.searchFields;
      _page = $v.page;
      _limit = $v.limit;
      _order = $v.order;
      _sortField = $v.sortField;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgeofenceList other) {
    _$v = other as _$GgeofenceList;
  }

  @override
  void update(void Function(GgeofenceListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GgeofenceList build() => _build();

  _$GgeofenceList _build() {
    final _$result = _$v ??
        _$GgeofenceList._(
          domain: domain,
          searchFields: searchFields,
          page: page,
          limit: limit,
          order: order,
          sortField: sortField,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

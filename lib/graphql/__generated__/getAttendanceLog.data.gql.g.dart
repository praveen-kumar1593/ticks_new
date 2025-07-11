// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getAttendanceLog.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GgetAttendanceLogData> _$ggetAttendanceLogDataSerializer =
    _$GgetAttendanceLogDataSerializer();
Serializer<GgetAttendanceLogData_getAttendanceLog>
    _$ggetAttendanceLogDataGetAttendanceLogSerializer =
    _$GgetAttendanceLogData_getAttendanceLogSerializer();
Serializer<GgetAttendanceLogData_getAttendanceLog_items>
    _$ggetAttendanceLogDataGetAttendanceLogItemsSerializer =
    _$GgetAttendanceLogData_getAttendanceLog_itemsSerializer();
Serializer<GgetAttendanceLogData_getAttendanceLog_items_breaks>
    _$ggetAttendanceLogDataGetAttendanceLogItemsBreaksSerializer =
    _$GgetAttendanceLogData_getAttendanceLog_items_breaksSerializer();

class _$GgetAttendanceLogDataSerializer
    implements StructuredSerializer<GgetAttendanceLogData> {
  @override
  final Iterable<Type> types = const [
    GgetAttendanceLogData,
    _$GgetAttendanceLogData
  ];
  @override
  final String wireName = 'GgetAttendanceLogData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetAttendanceLogData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.getAttendanceLog;
    if (value != null) {
      result
        ..add('getAttendanceLog')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GgetAttendanceLogData_getAttendanceLog)));
    }
    return result;
  }

  @override
  GgetAttendanceLogData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GgetAttendanceLogDataBuilder();

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
        case 'getAttendanceLog':
          result.getAttendanceLog.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GgetAttendanceLogData_getAttendanceLog))!
              as GgetAttendanceLogData_getAttendanceLog);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetAttendanceLogData_getAttendanceLogSerializer
    implements StructuredSerializer<GgetAttendanceLogData_getAttendanceLog> {
  @override
  final Iterable<Type> types = const [
    GgetAttendanceLogData_getAttendanceLog,
    _$GgetAttendanceLogData_getAttendanceLog
  ];
  @override
  final String wireName = 'GgetAttendanceLogData_getAttendanceLog';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetAttendanceLogData_getAttendanceLog object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.items;
    if (value != null) {
      result
        ..add('items')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType.nullable(
                  GgetAttendanceLogData_getAttendanceLog_items)
            ])));
    }
    return result;
  }

  @override
  GgetAttendanceLogData_getAttendanceLog deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GgetAttendanceLogData_getAttendanceLogBuilder();

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
        case 'items':
          result.items.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType.nullable(
                    GgetAttendanceLogData_getAttendanceLog_items)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetAttendanceLogData_getAttendanceLog_itemsSerializer
    implements
        StructuredSerializer<GgetAttendanceLogData_getAttendanceLog_items> {
  @override
  final Iterable<Type> types = const [
    GgetAttendanceLogData_getAttendanceLog_items,
    _$GgetAttendanceLogData_getAttendanceLog_items
  ];
  @override
  final String wireName = 'GgetAttendanceLogData_getAttendanceLog_items';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GgetAttendanceLogData_getAttendanceLog_items object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
    value = object.duration;
    if (value != null) {
      result
        ..add('duration')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.attendance_status;
    if (value != null) {
      result
        ..add('attendance_status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.breaks;
    if (value != null) {
      result
        ..add('breaks')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType.nullable(
                  GgetAttendanceLogData_getAttendanceLog_items_breaks)
            ])));
    }
    return result;
  }

  @override
  GgetAttendanceLogData_getAttendanceLog_items deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GgetAttendanceLogData_getAttendanceLog_itemsBuilder();

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
              specifiedType: const FullType(String)) as String?;
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
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'attendance_status':
          result.attendance_status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'breaks':
          result.breaks.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType.nullable(
                    GgetAttendanceLogData_getAttendanceLog_items_breaks)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetAttendanceLogData_getAttendanceLog_items_breaksSerializer
    implements
        StructuredSerializer<
            GgetAttendanceLogData_getAttendanceLog_items_breaks> {
  @override
  final Iterable<Type> types = const [
    GgetAttendanceLogData_getAttendanceLog_items_breaks,
    _$GgetAttendanceLogData_getAttendanceLog_items_breaks
  ];
  @override
  final String wireName = 'GgetAttendanceLogData_getAttendanceLog_items_breaks';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GgetAttendanceLogData_getAttendanceLog_items_breaks object,
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
  GgetAttendanceLogData_getAttendanceLog_items_breaks deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder();

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

class _$GgetAttendanceLogData extends GgetAttendanceLogData {
  @override
  final String G__typename;
  @override
  final GgetAttendanceLogData_getAttendanceLog? getAttendanceLog;

  factory _$GgetAttendanceLogData(
          [void Function(GgetAttendanceLogDataBuilder)? updates]) =>
      (GgetAttendanceLogDataBuilder()..update(updates))._build();

  _$GgetAttendanceLogData._({required this.G__typename, this.getAttendanceLog})
      : super._();
  @override
  GgetAttendanceLogData rebuild(
          void Function(GgetAttendanceLogDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetAttendanceLogDataBuilder toBuilder() =>
      GgetAttendanceLogDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetAttendanceLogData &&
        G__typename == other.G__typename &&
        getAttendanceLog == other.getAttendanceLog;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getAttendanceLog.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GgetAttendanceLogData')
          ..add('G__typename', G__typename)
          ..add('getAttendanceLog', getAttendanceLog))
        .toString();
  }
}

class GgetAttendanceLogDataBuilder
    implements Builder<GgetAttendanceLogData, GgetAttendanceLogDataBuilder> {
  _$GgetAttendanceLogData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GgetAttendanceLogData_getAttendanceLogBuilder? _getAttendanceLog;
  GgetAttendanceLogData_getAttendanceLogBuilder get getAttendanceLog =>
      _$this._getAttendanceLog ??=
          GgetAttendanceLogData_getAttendanceLogBuilder();
  set getAttendanceLog(
          GgetAttendanceLogData_getAttendanceLogBuilder? getAttendanceLog) =>
      _$this._getAttendanceLog = getAttendanceLog;

  GgetAttendanceLogDataBuilder() {
    GgetAttendanceLogData._initializeBuilder(this);
  }

  GgetAttendanceLogDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getAttendanceLog = $v.getAttendanceLog?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetAttendanceLogData other) {
    _$v = other as _$GgetAttendanceLogData;
  }

  @override
  void update(void Function(GgetAttendanceLogDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GgetAttendanceLogData build() => _build();

  _$GgetAttendanceLogData _build() {
    _$GgetAttendanceLogData _$result;
    try {
      _$result = _$v ??
          _$GgetAttendanceLogData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GgetAttendanceLogData', 'G__typename'),
            getAttendanceLog: _getAttendanceLog?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getAttendanceLog';
        _getAttendanceLog?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GgetAttendanceLogData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetAttendanceLogData_getAttendanceLog
    extends GgetAttendanceLogData_getAttendanceLog {
  @override
  final String G__typename;
  @override
  final BuiltList<GgetAttendanceLogData_getAttendanceLog_items?>? items;

  factory _$GgetAttendanceLogData_getAttendanceLog(
          [void Function(GgetAttendanceLogData_getAttendanceLogBuilder)?
              updates]) =>
      (GgetAttendanceLogData_getAttendanceLogBuilder()..update(updates))
          ._build();

  _$GgetAttendanceLogData_getAttendanceLog._(
      {required this.G__typename, this.items})
      : super._();
  @override
  GgetAttendanceLogData_getAttendanceLog rebuild(
          void Function(GgetAttendanceLogData_getAttendanceLogBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetAttendanceLogData_getAttendanceLogBuilder toBuilder() =>
      GgetAttendanceLogData_getAttendanceLogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetAttendanceLogData_getAttendanceLog &&
        G__typename == other.G__typename &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GgetAttendanceLogData_getAttendanceLog')
          ..add('G__typename', G__typename)
          ..add('items', items))
        .toString();
  }
}

class GgetAttendanceLogData_getAttendanceLogBuilder
    implements
        Builder<GgetAttendanceLogData_getAttendanceLog,
            GgetAttendanceLogData_getAttendanceLogBuilder> {
  _$GgetAttendanceLogData_getAttendanceLog? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GgetAttendanceLogData_getAttendanceLog_items?>? _items;
  ListBuilder<GgetAttendanceLogData_getAttendanceLog_items?> get items =>
      _$this._items ??=
          ListBuilder<GgetAttendanceLogData_getAttendanceLog_items?>();
  set items(
          ListBuilder<GgetAttendanceLogData_getAttendanceLog_items?>? items) =>
      _$this._items = items;

  GgetAttendanceLogData_getAttendanceLogBuilder() {
    GgetAttendanceLogData_getAttendanceLog._initializeBuilder(this);
  }

  GgetAttendanceLogData_getAttendanceLogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetAttendanceLogData_getAttendanceLog other) {
    _$v = other as _$GgetAttendanceLogData_getAttendanceLog;
  }

  @override
  void update(
      void Function(GgetAttendanceLogData_getAttendanceLogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GgetAttendanceLogData_getAttendanceLog build() => _build();

  _$GgetAttendanceLogData_getAttendanceLog _build() {
    _$GgetAttendanceLogData_getAttendanceLog _$result;
    try {
      _$result = _$v ??
          _$GgetAttendanceLogData_getAttendanceLog._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GgetAttendanceLogData_getAttendanceLog', 'G__typename'),
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GgetAttendanceLogData_getAttendanceLog',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetAttendanceLogData_getAttendanceLog_items
    extends GgetAttendanceLogData_getAttendanceLog_items {
  @override
  final String G__typename;
  @override
  final String? id;
  @override
  final _i2.GDatetime? date;
  @override
  final _i2.GDatetime? checkInTime;
  @override
  final _i2.GDatetime? checkOutTime;
  @override
  final int? duration;
  @override
  final String? attendance_status;
  @override
  final BuiltList<GgetAttendanceLogData_getAttendanceLog_items_breaks?>? breaks;

  factory _$GgetAttendanceLogData_getAttendanceLog_items(
          [void Function(GgetAttendanceLogData_getAttendanceLog_itemsBuilder)?
              updates]) =>
      (GgetAttendanceLogData_getAttendanceLog_itemsBuilder()..update(updates))
          ._build();

  _$GgetAttendanceLogData_getAttendanceLog_items._(
      {required this.G__typename,
      this.id,
      this.date,
      this.checkInTime,
      this.checkOutTime,
      this.duration,
      this.attendance_status,
      this.breaks})
      : super._();
  @override
  GgetAttendanceLogData_getAttendanceLog_items rebuild(
          void Function(GgetAttendanceLogData_getAttendanceLog_itemsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetAttendanceLogData_getAttendanceLog_itemsBuilder toBuilder() =>
      GgetAttendanceLogData_getAttendanceLog_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetAttendanceLogData_getAttendanceLog_items &&
        G__typename == other.G__typename &&
        id == other.id &&
        date == other.date &&
        checkInTime == other.checkInTime &&
        checkOutTime == other.checkOutTime &&
        duration == other.duration &&
        attendance_status == other.attendance_status &&
        breaks == other.breaks;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, checkInTime.hashCode);
    _$hash = $jc(_$hash, checkOutTime.hashCode);
    _$hash = $jc(_$hash, duration.hashCode);
    _$hash = $jc(_$hash, attendance_status.hashCode);
    _$hash = $jc(_$hash, breaks.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GgetAttendanceLogData_getAttendanceLog_items')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('date', date)
          ..add('checkInTime', checkInTime)
          ..add('checkOutTime', checkOutTime)
          ..add('duration', duration)
          ..add('attendance_status', attendance_status)
          ..add('breaks', breaks))
        .toString();
  }
}

class GgetAttendanceLogData_getAttendanceLog_itemsBuilder
    implements
        Builder<GgetAttendanceLogData_getAttendanceLog_items,
            GgetAttendanceLogData_getAttendanceLog_itemsBuilder> {
  _$GgetAttendanceLogData_getAttendanceLog_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

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

  int? _duration;
  int? get duration => _$this._duration;
  set duration(int? duration) => _$this._duration = duration;

  String? _attendance_status;
  String? get attendance_status => _$this._attendance_status;
  set attendance_status(String? attendance_status) =>
      _$this._attendance_status = attendance_status;

  ListBuilder<GgetAttendanceLogData_getAttendanceLog_items_breaks?>? _breaks;
  ListBuilder<GgetAttendanceLogData_getAttendanceLog_items_breaks?>
      get breaks => _$this._breaks ??=
          ListBuilder<GgetAttendanceLogData_getAttendanceLog_items_breaks?>();
  set breaks(
          ListBuilder<GgetAttendanceLogData_getAttendanceLog_items_breaks?>?
              breaks) =>
      _$this._breaks = breaks;

  GgetAttendanceLogData_getAttendanceLog_itemsBuilder() {
    GgetAttendanceLogData_getAttendanceLog_items._initializeBuilder(this);
  }

  GgetAttendanceLogData_getAttendanceLog_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _date = $v.date?.toBuilder();
      _checkInTime = $v.checkInTime?.toBuilder();
      _checkOutTime = $v.checkOutTime?.toBuilder();
      _duration = $v.duration;
      _attendance_status = $v.attendance_status;
      _breaks = $v.breaks?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetAttendanceLogData_getAttendanceLog_items other) {
    _$v = other as _$GgetAttendanceLogData_getAttendanceLog_items;
  }

  @override
  void update(
      void Function(GgetAttendanceLogData_getAttendanceLog_itemsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GgetAttendanceLogData_getAttendanceLog_items build() => _build();

  _$GgetAttendanceLogData_getAttendanceLog_items _build() {
    _$GgetAttendanceLogData_getAttendanceLog_items _$result;
    try {
      _$result = _$v ??
          _$GgetAttendanceLogData_getAttendanceLog_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GgetAttendanceLogData_getAttendanceLog_items', 'G__typename'),
            id: id,
            date: _date?.build(),
            checkInTime: _checkInTime?.build(),
            checkOutTime: _checkOutTime?.build(),
            duration: duration,
            attendance_status: attendance_status,
            breaks: _breaks?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'date';
        _date?.build();
        _$failedField = 'checkInTime';
        _checkInTime?.build();
        _$failedField = 'checkOutTime';
        _checkOutTime?.build();

        _$failedField = 'breaks';
        _breaks?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GgetAttendanceLogData_getAttendanceLog_items',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetAttendanceLogData_getAttendanceLog_items_breaks
    extends GgetAttendanceLogData_getAttendanceLog_items_breaks {
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

  factory _$GgetAttendanceLogData_getAttendanceLog_items_breaks(
          [void Function(
                  GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder)?
              updates]) =>
      (GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder()
            ..update(updates))
          ._build();

  _$GgetAttendanceLogData_getAttendanceLog_items_breaks._(
      {required this.G__typename,
      this.breakId,
      this.startTime,
      this.endTime,
      this.duration})
      : super._();
  @override
  GgetAttendanceLogData_getAttendanceLog_items_breaks rebuild(
          void Function(
                  GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder toBuilder() =>
      GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetAttendanceLogData_getAttendanceLog_items_breaks &&
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
            r'GgetAttendanceLogData_getAttendanceLog_items_breaks')
          ..add('G__typename', G__typename)
          ..add('breakId', breakId)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('duration', duration))
        .toString();
  }
}

class GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder
    implements
        Builder<GgetAttendanceLogData_getAttendanceLog_items_breaks,
            GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder> {
  _$GgetAttendanceLogData_getAttendanceLog_items_breaks? _$v;

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

  GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder() {
    GgetAttendanceLogData_getAttendanceLog_items_breaks._initializeBuilder(
        this);
  }

  GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder get _$this {
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
  void replace(GgetAttendanceLogData_getAttendanceLog_items_breaks other) {
    _$v = other as _$GgetAttendanceLogData_getAttendanceLog_items_breaks;
  }

  @override
  void update(
      void Function(GgetAttendanceLogData_getAttendanceLog_items_breaksBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GgetAttendanceLogData_getAttendanceLog_items_breaks build() => _build();

  _$GgetAttendanceLogData_getAttendanceLog_items_breaks _build() {
    _$GgetAttendanceLogData_getAttendanceLog_items_breaks _$result;
    try {
      _$result = _$v ??
          _$GgetAttendanceLogData_getAttendanceLog_items_breaks._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GgetAttendanceLogData_getAttendanceLog_items_breaks',
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
            r'GgetAttendanceLogData_getAttendanceLog_items_breaks',
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

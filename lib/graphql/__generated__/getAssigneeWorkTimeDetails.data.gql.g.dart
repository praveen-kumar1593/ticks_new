// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getAssigneeWorkTimeDetails.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetAssigneeWorkTimeDetailsData>
    _$gGetAssigneeWorkTimeDetailsDataSerializer =
    _$GGetAssigneeWorkTimeDetailsDataSerializer();
Serializer<GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails>
    _$gGetAssigneeWorkTimeDetailsDataGetAssigneeWorkTimeDetailsSerializer =
    _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsSerializer();
Serializer<GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift>
    _$gGetAssigneeWorkTimeDetailsDataGetAssigneeWorkTimeDetailsShiftSerializer =
    _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftSerializer();
Serializer<
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour>
    _$gGetAssigneeWorkTimeDetailsDataGetAssigneeWorkTimeDetailsClientWorkingHourSerializer =
    _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourSerializer();

class _$GGetAssigneeWorkTimeDetailsDataSerializer
    implements StructuredSerializer<GGetAssigneeWorkTimeDetailsData> {
  @override
  final Iterable<Type> types = const [
    GGetAssigneeWorkTimeDetailsData,
    _$GGetAssigneeWorkTimeDetailsData
  ];
  @override
  final String wireName = 'GGetAssigneeWorkTimeDetailsData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetAssigneeWorkTimeDetailsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.getAssigneeWorkTimeDetails;
    if (value != null) {
      result
        ..add('getAssigneeWorkTimeDetails')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails)));
    }
    return result;
  }

  @override
  GGetAssigneeWorkTimeDetailsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GGetAssigneeWorkTimeDetailsDataBuilder();

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
        case 'getAssigneeWorkTimeDetails':
          result.getAssigneeWorkTimeDetails.replace(serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails))!
              as GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsSerializer
    implements
        StructuredSerializer<
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails> {
  @override
  final Iterable<Type> types = const [
    GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails,
    _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails
  ];
  @override
  final String wireName =
      'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.shift;
    if (value != null) {
      result
        ..add('shift')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift)));
    }
    value = object.clientWorkingHour;
    if (value != null) {
      result
        ..add('clientWorkingHour')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour)));
    }
    return result;
  }

  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder();

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
        case 'shift':
          result.shift.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift))!
              as GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift);
          break;
        case 'clientWorkingHour':
          result.clientWorkingHour.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour))!
              as GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftSerializer
    implements
        StructuredSerializer<
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift> {
  @override
  final Iterable<Type> types = const [
    GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift,
    _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift
  ];
  @override
  final String wireName =
      'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.identifier;
    if (value != null) {
      result
        ..add('identifier')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.startTime;
    if (value != null) {
      result
        ..add('startTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.endTime;
    if (value != null) {
      result
        ..add('endTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.duration;
    if (value != null) {
      result
        ..add('duration')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.domain;
    if (value != null) {
      result
        ..add('domain')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
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
    return result;
  }

  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder();

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
        case 'identifier':
          result.identifier = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'startTime':
          result.startTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'endTime':
          result.endTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'domain':
          result.domain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
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
      }
    }

    return result.build();
  }
}

class _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourSerializer
    implements
        StructuredSerializer<
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour> {
  @override
  final Iterable<Type> types = const [
    GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour,
    _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
  ];
  @override
  final String wireName =
      'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
          object,
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
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.sundayStartTime;
    if (value != null) {
      result
        ..add('sundayStartTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.sundayEndTime;
    if (value != null) {
      result
        ..add('sundayEndTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mondayStartTime;
    if (value != null) {
      result
        ..add('mondayStartTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mondayEndTime;
    if (value != null) {
      result
        ..add('mondayEndTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.tuesdayStartTime;
    if (value != null) {
      result
        ..add('tuesdayStartTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.tuesdayEndTime;
    if (value != null) {
      result
        ..add('tuesdayEndTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.wednesdayStartTime;
    if (value != null) {
      result
        ..add('wednesdayStartTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.wednesdayEndTime;
    if (value != null) {
      result
        ..add('wednesdayEndTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.thursdayStartTime;
    if (value != null) {
      result
        ..add('thursdayStartTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.thursdayEndTime;
    if (value != null) {
      result
        ..add('thursdayEndTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fridayStartTime;
    if (value != null) {
      result
        ..add('fridayStartTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fridayEndTime;
    if (value != null) {
      result
        ..add('fridayEndTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.saturdayStartTime;
    if (value != null) {
      result
        ..add('saturdayStartTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.saturdayEndTime;
    if (value != null) {
      result
        ..add('saturdayEndTime')
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
    value = object.client;
    if (value != null) {
      result
        ..add('client')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'sundayStartTime':
          result.sundayStartTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'sundayEndTime':
          result.sundayEndTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mondayStartTime':
          result.mondayStartTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mondayEndTime':
          result.mondayEndTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tuesdayStartTime':
          result.tuesdayStartTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tuesdayEndTime':
          result.tuesdayEndTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'wednesdayStartTime':
          result.wednesdayStartTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'wednesdayEndTime':
          result.wednesdayEndTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'thursdayStartTime':
          result.thursdayStartTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'thursdayEndTime':
          result.thursdayEndTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fridayStartTime':
          result.fridayStartTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fridayEndTime':
          result.fridayEndTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'saturdayStartTime':
          result.saturdayStartTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'saturdayEndTime':
          result.saturdayEndTime = serializers.deserialize(value,
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
        case 'client':
          result.client = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetAssigneeWorkTimeDetailsData
    extends GGetAssigneeWorkTimeDetailsData {
  @override
  final String G__typename;
  @override
  final GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails?
      getAssigneeWorkTimeDetails;

  factory _$GGetAssigneeWorkTimeDetailsData(
          [void Function(GGetAssigneeWorkTimeDetailsDataBuilder)? updates]) =>
      (GGetAssigneeWorkTimeDetailsDataBuilder()..update(updates))._build();

  _$GGetAssigneeWorkTimeDetailsData._(
      {required this.G__typename, this.getAssigneeWorkTimeDetails})
      : super._();
  @override
  GGetAssigneeWorkTimeDetailsData rebuild(
          void Function(GGetAssigneeWorkTimeDetailsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetAssigneeWorkTimeDetailsDataBuilder toBuilder() =>
      GGetAssigneeWorkTimeDetailsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetAssigneeWorkTimeDetailsData &&
        G__typename == other.G__typename &&
        getAssigneeWorkTimeDetails == other.getAssigneeWorkTimeDetails;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getAssigneeWorkTimeDetails.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetAssigneeWorkTimeDetailsData')
          ..add('G__typename', G__typename)
          ..add('getAssigneeWorkTimeDetails', getAssigneeWorkTimeDetails))
        .toString();
  }
}

class GGetAssigneeWorkTimeDetailsDataBuilder
    implements
        Builder<GGetAssigneeWorkTimeDetailsData,
            GGetAssigneeWorkTimeDetailsDataBuilder> {
  _$GGetAssigneeWorkTimeDetailsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder?
      _getAssigneeWorkTimeDetails;
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder
      get getAssigneeWorkTimeDetails => _$this._getAssigneeWorkTimeDetails ??=
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder();
  set getAssigneeWorkTimeDetails(
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder?
              getAssigneeWorkTimeDetails) =>
      _$this._getAssigneeWorkTimeDetails = getAssigneeWorkTimeDetails;

  GGetAssigneeWorkTimeDetailsDataBuilder() {
    GGetAssigneeWorkTimeDetailsData._initializeBuilder(this);
  }

  GGetAssigneeWorkTimeDetailsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getAssigneeWorkTimeDetails = $v.getAssigneeWorkTimeDetails?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetAssigneeWorkTimeDetailsData other) {
    _$v = other as _$GGetAssigneeWorkTimeDetailsData;
  }

  @override
  void update(void Function(GGetAssigneeWorkTimeDetailsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetAssigneeWorkTimeDetailsData build() => _build();

  _$GGetAssigneeWorkTimeDetailsData _build() {
    _$GGetAssigneeWorkTimeDetailsData _$result;
    try {
      _$result = _$v ??
          _$GGetAssigneeWorkTimeDetailsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GGetAssigneeWorkTimeDetailsData', 'G__typename'),
            getAssigneeWorkTimeDetails: _getAssigneeWorkTimeDetails?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getAssigneeWorkTimeDetails';
        _getAssigneeWorkTimeDetails?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GGetAssigneeWorkTimeDetailsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails
    extends GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails {
  @override
  final String G__typename;
  @override
  final GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift? shift;
  @override
  final GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour?
      clientWorkingHour;

  factory _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails(
          [void Function(
                  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder)?
              updates]) =>
      (GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder()
            ..update(updates))
          ._build();

  _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails._(
      {required this.G__typename, this.shift, this.clientWorkingHour})
      : super._();
  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails rebuild(
          void Function(
                  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder
      toBuilder() =>
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails &&
        G__typename == other.G__typename &&
        shift == other.shift &&
        clientWorkingHour == other.clientWorkingHour;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, shift.hashCode);
    _$hash = $jc(_$hash, clientWorkingHour.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails')
          ..add('G__typename', G__typename)
          ..add('shift', shift)
          ..add('clientWorkingHour', clientWorkingHour))
        .toString();
  }
}

class GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder
    implements
        Builder<GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails,
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder> {
  _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder?
      _shift;
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder
      get shift => _$this._shift ??=
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder();
  set shift(
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder?
              shift) =>
      _$this._shift = shift;

  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder?
      _clientWorkingHour;
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder
      get clientWorkingHour => _$this._clientWorkingHour ??=
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder();
  set clientWorkingHour(
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder?
              clientWorkingHour) =>
      _$this._clientWorkingHour = clientWorkingHour;

  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder() {
    GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails
        ._initializeBuilder(this);
  }

  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _shift = $v.shift?.toBuilder();
      _clientWorkingHour = $v.clientWorkingHour?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails other) {
    _$v = other as _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails;
  }

  @override
  void update(
      void Function(
              GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetailsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails build() =>
      _build();

  _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails _build() {
    _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails _$result;
    try {
      _$result = _$v ??
          _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails',
                'G__typename'),
            shift: _shift?.build(),
            clientWorkingHour: _clientWorkingHour?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'shift';
        _shift?.build();
        _$failedField = 'clientWorkingHour';
        _clientWorkingHour?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift
    extends GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift {
  @override
  final String G__typename;
  @override
  final String? identifier;
  @override
  final String? startTime;
  @override
  final String? endTime;
  @override
  final int? duration;
  @override
  final String? domain;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? status;
  @override
  final int? allowedBreak;
  @override
  final int? bufferTime;

  factory _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift(
          [void Function(
                  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder)?
              updates]) =>
      (GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder()
            ..update(updates))
          ._build();

  _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift._(
      {required this.G__typename,
      this.identifier,
      this.startTime,
      this.endTime,
      this.duration,
      this.domain,
      this.name,
      this.description,
      this.status,
      this.allowedBreak,
      this.bufferTime})
      : super._();
  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift rebuild(
          void Function(
                  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder
      toBuilder() =>
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift &&
        G__typename == other.G__typename &&
        identifier == other.identifier &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        duration == other.duration &&
        domain == other.domain &&
        name == other.name &&
        description == other.description &&
        status == other.status &&
        allowedBreak == other.allowedBreak &&
        bufferTime == other.bufferTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, identifier.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, duration.hashCode);
    _$hash = $jc(_$hash, domain.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, allowedBreak.hashCode);
    _$hash = $jc(_$hash, bufferTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift')
          ..add('G__typename', G__typename)
          ..add('identifier', identifier)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('duration', duration)
          ..add('domain', domain)
          ..add('name', name)
          ..add('description', description)
          ..add('status', status)
          ..add('allowedBreak', allowedBreak)
          ..add('bufferTime', bufferTime))
        .toString();
  }
}

class GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder
    implements
        Builder<
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift,
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder> {
  _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _identifier;
  String? get identifier => _$this._identifier;
  set identifier(String? identifier) => _$this._identifier = identifier;

  String? _startTime;
  String? get startTime => _$this._startTime;
  set startTime(String? startTime) => _$this._startTime = startTime;

  String? _endTime;
  String? get endTime => _$this._endTime;
  set endTime(String? endTime) => _$this._endTime = endTime;

  int? _duration;
  int? get duration => _$this._duration;
  set duration(int? duration) => _$this._duration = duration;

  String? _domain;
  String? get domain => _$this._domain;
  set domain(String? domain) => _$this._domain = domain;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _allowedBreak;
  int? get allowedBreak => _$this._allowedBreak;
  set allowedBreak(int? allowedBreak) => _$this._allowedBreak = allowedBreak;

  int? _bufferTime;
  int? get bufferTime => _$this._bufferTime;
  set bufferTime(int? bufferTime) => _$this._bufferTime = bufferTime;

  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder() {
    GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift
        ._initializeBuilder(this);
  }

  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _identifier = $v.identifier;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _duration = $v.duration;
      _domain = $v.domain;
      _name = $v.name;
      _description = $v.description;
      _status = $v.status;
      _allowedBreak = $v.allowedBreak;
      _bufferTime = $v.bufferTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift other) {
    _$v = other
        as _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift;
  }

  @override
  void update(
      void Function(
              GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shiftBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift build() =>
      _build();

  _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift _build() {
    final _$result = _$v ??
        _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_shift',
              'G__typename'),
          identifier: identifier,
          startTime: startTime,
          endTime: endTime,
          duration: duration,
          domain: domain,
          name: name,
          description: description,
          status: status,
          allowedBreak: allowedBreak,
          bufferTime: bufferTime,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
    extends GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour {
  @override
  final String G__typename;
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? sundayStartTime;
  @override
  final String? sundayEndTime;
  @override
  final String? mondayStartTime;
  @override
  final String? mondayEndTime;
  @override
  final String? tuesdayStartTime;
  @override
  final String? tuesdayEndTime;
  @override
  final String? wednesdayStartTime;
  @override
  final String? wednesdayEndTime;
  @override
  final String? thursdayStartTime;
  @override
  final String? thursdayEndTime;
  @override
  final String? fridayStartTime;
  @override
  final String? fridayEndTime;
  @override
  final String? saturdayStartTime;
  @override
  final String? saturdayEndTime;
  @override
  final int? allowedBreak;
  @override
  final int? bufferTime;
  @override
  final String? client;

  factory _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour(
          [void Function(
                  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder)?
              updates]) =>
      (GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder()
            ..update(updates))
          ._build();

  _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour._(
      {required this.G__typename,
      this.id,
      this.name,
      this.sundayStartTime,
      this.sundayEndTime,
      this.mondayStartTime,
      this.mondayEndTime,
      this.tuesdayStartTime,
      this.tuesdayEndTime,
      this.wednesdayStartTime,
      this.wednesdayEndTime,
      this.thursdayStartTime,
      this.thursdayEndTime,
      this.fridayStartTime,
      this.fridayEndTime,
      this.saturdayStartTime,
      this.saturdayEndTime,
      this.allowedBreak,
      this.bufferTime,
      this.client})
      : super._();
  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
      rebuild(
              void Function(
                      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder
      toBuilder() =>
          GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        sundayStartTime == other.sundayStartTime &&
        sundayEndTime == other.sundayEndTime &&
        mondayStartTime == other.mondayStartTime &&
        mondayEndTime == other.mondayEndTime &&
        tuesdayStartTime == other.tuesdayStartTime &&
        tuesdayEndTime == other.tuesdayEndTime &&
        wednesdayStartTime == other.wednesdayStartTime &&
        wednesdayEndTime == other.wednesdayEndTime &&
        thursdayStartTime == other.thursdayStartTime &&
        thursdayEndTime == other.thursdayEndTime &&
        fridayStartTime == other.fridayStartTime &&
        fridayEndTime == other.fridayEndTime &&
        saturdayStartTime == other.saturdayStartTime &&
        saturdayEndTime == other.saturdayEndTime &&
        allowedBreak == other.allowedBreak &&
        bufferTime == other.bufferTime &&
        client == other.client;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, sundayStartTime.hashCode);
    _$hash = $jc(_$hash, sundayEndTime.hashCode);
    _$hash = $jc(_$hash, mondayStartTime.hashCode);
    _$hash = $jc(_$hash, mondayEndTime.hashCode);
    _$hash = $jc(_$hash, tuesdayStartTime.hashCode);
    _$hash = $jc(_$hash, tuesdayEndTime.hashCode);
    _$hash = $jc(_$hash, wednesdayStartTime.hashCode);
    _$hash = $jc(_$hash, wednesdayEndTime.hashCode);
    _$hash = $jc(_$hash, thursdayStartTime.hashCode);
    _$hash = $jc(_$hash, thursdayEndTime.hashCode);
    _$hash = $jc(_$hash, fridayStartTime.hashCode);
    _$hash = $jc(_$hash, fridayEndTime.hashCode);
    _$hash = $jc(_$hash, saturdayStartTime.hashCode);
    _$hash = $jc(_$hash, saturdayEndTime.hashCode);
    _$hash = $jc(_$hash, allowedBreak.hashCode);
    _$hash = $jc(_$hash, bufferTime.hashCode);
    _$hash = $jc(_$hash, client.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('sundayStartTime', sundayStartTime)
          ..add('sundayEndTime', sundayEndTime)
          ..add('mondayStartTime', mondayStartTime)
          ..add('mondayEndTime', mondayEndTime)
          ..add('tuesdayStartTime', tuesdayStartTime)
          ..add('tuesdayEndTime', tuesdayEndTime)
          ..add('wednesdayStartTime', wednesdayStartTime)
          ..add('wednesdayEndTime', wednesdayEndTime)
          ..add('thursdayStartTime', thursdayStartTime)
          ..add('thursdayEndTime', thursdayEndTime)
          ..add('fridayStartTime', fridayStartTime)
          ..add('fridayEndTime', fridayEndTime)
          ..add('saturdayStartTime', saturdayStartTime)
          ..add('saturdayEndTime', saturdayEndTime)
          ..add('allowedBreak', allowedBreak)
          ..add('bufferTime', bufferTime)
          ..add('client', client))
        .toString();
  }
}

class GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder
    implements
        Builder<
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour,
            GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder> {
  _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _sundayStartTime;
  String? get sundayStartTime => _$this._sundayStartTime;
  set sundayStartTime(String? sundayStartTime) =>
      _$this._sundayStartTime = sundayStartTime;

  String? _sundayEndTime;
  String? get sundayEndTime => _$this._sundayEndTime;
  set sundayEndTime(String? sundayEndTime) =>
      _$this._sundayEndTime = sundayEndTime;

  String? _mondayStartTime;
  String? get mondayStartTime => _$this._mondayStartTime;
  set mondayStartTime(String? mondayStartTime) =>
      _$this._mondayStartTime = mondayStartTime;

  String? _mondayEndTime;
  String? get mondayEndTime => _$this._mondayEndTime;
  set mondayEndTime(String? mondayEndTime) =>
      _$this._mondayEndTime = mondayEndTime;

  String? _tuesdayStartTime;
  String? get tuesdayStartTime => _$this._tuesdayStartTime;
  set tuesdayStartTime(String? tuesdayStartTime) =>
      _$this._tuesdayStartTime = tuesdayStartTime;

  String? _tuesdayEndTime;
  String? get tuesdayEndTime => _$this._tuesdayEndTime;
  set tuesdayEndTime(String? tuesdayEndTime) =>
      _$this._tuesdayEndTime = tuesdayEndTime;

  String? _wednesdayStartTime;
  String? get wednesdayStartTime => _$this._wednesdayStartTime;
  set wednesdayStartTime(String? wednesdayStartTime) =>
      _$this._wednesdayStartTime = wednesdayStartTime;

  String? _wednesdayEndTime;
  String? get wednesdayEndTime => _$this._wednesdayEndTime;
  set wednesdayEndTime(String? wednesdayEndTime) =>
      _$this._wednesdayEndTime = wednesdayEndTime;

  String? _thursdayStartTime;
  String? get thursdayStartTime => _$this._thursdayStartTime;
  set thursdayStartTime(String? thursdayStartTime) =>
      _$this._thursdayStartTime = thursdayStartTime;

  String? _thursdayEndTime;
  String? get thursdayEndTime => _$this._thursdayEndTime;
  set thursdayEndTime(String? thursdayEndTime) =>
      _$this._thursdayEndTime = thursdayEndTime;

  String? _fridayStartTime;
  String? get fridayStartTime => _$this._fridayStartTime;
  set fridayStartTime(String? fridayStartTime) =>
      _$this._fridayStartTime = fridayStartTime;

  String? _fridayEndTime;
  String? get fridayEndTime => _$this._fridayEndTime;
  set fridayEndTime(String? fridayEndTime) =>
      _$this._fridayEndTime = fridayEndTime;

  String? _saturdayStartTime;
  String? get saturdayStartTime => _$this._saturdayStartTime;
  set saturdayStartTime(String? saturdayStartTime) =>
      _$this._saturdayStartTime = saturdayStartTime;

  String? _saturdayEndTime;
  String? get saturdayEndTime => _$this._saturdayEndTime;
  set saturdayEndTime(String? saturdayEndTime) =>
      _$this._saturdayEndTime = saturdayEndTime;

  int? _allowedBreak;
  int? get allowedBreak => _$this._allowedBreak;
  set allowedBreak(int? allowedBreak) => _$this._allowedBreak = allowedBreak;

  int? _bufferTime;
  int? get bufferTime => _$this._bufferTime;
  set bufferTime(int? bufferTime) => _$this._bufferTime = bufferTime;

  String? _client;
  String? get client => _$this._client;
  set client(String? client) => _$this._client = client;

  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder() {
    GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
        ._initializeBuilder(this);
  }

  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _sundayStartTime = $v.sundayStartTime;
      _sundayEndTime = $v.sundayEndTime;
      _mondayStartTime = $v.mondayStartTime;
      _mondayEndTime = $v.mondayEndTime;
      _tuesdayStartTime = $v.tuesdayStartTime;
      _tuesdayEndTime = $v.tuesdayEndTime;
      _wednesdayStartTime = $v.wednesdayStartTime;
      _wednesdayEndTime = $v.wednesdayEndTime;
      _thursdayStartTime = $v.thursdayStartTime;
      _thursdayEndTime = $v.thursdayEndTime;
      _fridayStartTime = $v.fridayStartTime;
      _fridayEndTime = $v.fridayEndTime;
      _saturdayStartTime = $v.saturdayStartTime;
      _saturdayEndTime = $v.saturdayEndTime;
      _allowedBreak = $v.allowedBreak;
      _bufferTime = $v.bufferTime;
      _client = $v.client;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
          other) {
    _$v = other
        as _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour;
  }

  @override
  void update(
      void Function(
              GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHourBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
      build() => _build();

  _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
      _build() {
    final _$result = _$v ??
        _$GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour
            ._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails_clientWorkingHour',
              'G__typename'),
          id: id,
          name: name,
          sundayStartTime: sundayStartTime,
          sundayEndTime: sundayEndTime,
          mondayStartTime: mondayStartTime,
          mondayEndTime: mondayEndTime,
          tuesdayStartTime: tuesdayStartTime,
          tuesdayEndTime: tuesdayEndTime,
          wednesdayStartTime: wednesdayStartTime,
          wednesdayEndTime: wednesdayEndTime,
          thursdayStartTime: thursdayStartTime,
          thursdayEndTime: thursdayEndTime,
          fridayStartTime: fridayStartTime,
          fridayEndTime: fridayEndTime,
          saturdayStartTime: saturdayStartTime,
          saturdayEndTime: saturdayEndTime,
          allowedBreak: allowedBreak,
          bufferTime: bufferTime,
          client: client,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

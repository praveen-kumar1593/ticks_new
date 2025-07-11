// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markAttendanceSync.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GmarkAttendanceSyncData> _$gmarkAttendanceSyncDataSerializer =
    _$GmarkAttendanceSyncDataSerializer();
Serializer<GmarkAttendanceSyncData_markAttendanceSync>
    _$gmarkAttendanceSyncDataMarkAttendanceSyncSerializer =
    _$GmarkAttendanceSyncData_markAttendanceSyncSerializer();

class _$GmarkAttendanceSyncDataSerializer
    implements StructuredSerializer<GmarkAttendanceSyncData> {
  @override
  final Iterable<Type> types = const [
    GmarkAttendanceSyncData,
    _$GmarkAttendanceSyncData
  ];
  @override
  final String wireName = 'GmarkAttendanceSyncData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GmarkAttendanceSyncData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.markAttendanceSync;
    if (value != null) {
      result
        ..add('markAttendanceSync')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GmarkAttendanceSyncData_markAttendanceSync)));
    }
    return result;
  }

  @override
  GmarkAttendanceSyncData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GmarkAttendanceSyncDataBuilder();

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
        case 'markAttendanceSync':
          result.markAttendanceSync.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GmarkAttendanceSyncData_markAttendanceSync))!
              as GmarkAttendanceSyncData_markAttendanceSync);
          break;
      }
    }

    return result.build();
  }
}

class _$GmarkAttendanceSyncData_markAttendanceSyncSerializer
    implements
        StructuredSerializer<GmarkAttendanceSyncData_markAttendanceSync> {
  @override
  final Iterable<Type> types = const [
    GmarkAttendanceSyncData_markAttendanceSync,
    _$GmarkAttendanceSyncData_markAttendanceSync
  ];
  @override
  final String wireName = 'GmarkAttendanceSyncData_markAttendanceSync';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GmarkAttendanceSyncData_markAttendanceSync object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
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
  GmarkAttendanceSyncData_markAttendanceSync deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GmarkAttendanceSyncData_markAttendanceSyncBuilder();

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
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GmarkAttendanceSyncData extends GmarkAttendanceSyncData {
  @override
  final String G__typename;
  @override
  final GmarkAttendanceSyncData_markAttendanceSync? markAttendanceSync;

  factory _$GmarkAttendanceSyncData(
          [void Function(GmarkAttendanceSyncDataBuilder)? updates]) =>
      (GmarkAttendanceSyncDataBuilder()..update(updates))._build();

  _$GmarkAttendanceSyncData._(
      {required this.G__typename, this.markAttendanceSync})
      : super._();
  @override
  GmarkAttendanceSyncData rebuild(
          void Function(GmarkAttendanceSyncDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GmarkAttendanceSyncDataBuilder toBuilder() =>
      GmarkAttendanceSyncDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GmarkAttendanceSyncData &&
        G__typename == other.G__typename &&
        markAttendanceSync == other.markAttendanceSync;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, markAttendanceSync.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GmarkAttendanceSyncData')
          ..add('G__typename', G__typename)
          ..add('markAttendanceSync', markAttendanceSync))
        .toString();
  }
}

class GmarkAttendanceSyncDataBuilder
    implements
        Builder<GmarkAttendanceSyncData, GmarkAttendanceSyncDataBuilder> {
  _$GmarkAttendanceSyncData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GmarkAttendanceSyncData_markAttendanceSyncBuilder? _markAttendanceSync;
  GmarkAttendanceSyncData_markAttendanceSyncBuilder get markAttendanceSync =>
      _$this._markAttendanceSync ??=
          GmarkAttendanceSyncData_markAttendanceSyncBuilder();
  set markAttendanceSync(
          GmarkAttendanceSyncData_markAttendanceSyncBuilder?
              markAttendanceSync) =>
      _$this._markAttendanceSync = markAttendanceSync;

  GmarkAttendanceSyncDataBuilder() {
    GmarkAttendanceSyncData._initializeBuilder(this);
  }

  GmarkAttendanceSyncDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _markAttendanceSync = $v.markAttendanceSync?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GmarkAttendanceSyncData other) {
    _$v = other as _$GmarkAttendanceSyncData;
  }

  @override
  void update(void Function(GmarkAttendanceSyncDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GmarkAttendanceSyncData build() => _build();

  _$GmarkAttendanceSyncData _build() {
    _$GmarkAttendanceSyncData _$result;
    try {
      _$result = _$v ??
          _$GmarkAttendanceSyncData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GmarkAttendanceSyncData', 'G__typename'),
            markAttendanceSync: _markAttendanceSync?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'markAttendanceSync';
        _markAttendanceSync?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GmarkAttendanceSyncData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GmarkAttendanceSyncData_markAttendanceSync
    extends GmarkAttendanceSyncData_markAttendanceSync {
  @override
  final String G__typename;
  @override
  final String? status;

  factory _$GmarkAttendanceSyncData_markAttendanceSync(
          [void Function(GmarkAttendanceSyncData_markAttendanceSyncBuilder)?
              updates]) =>
      (GmarkAttendanceSyncData_markAttendanceSyncBuilder()..update(updates))
          ._build();

  _$GmarkAttendanceSyncData_markAttendanceSync._(
      {required this.G__typename, this.status})
      : super._();
  @override
  GmarkAttendanceSyncData_markAttendanceSync rebuild(
          void Function(GmarkAttendanceSyncData_markAttendanceSyncBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GmarkAttendanceSyncData_markAttendanceSyncBuilder toBuilder() =>
      GmarkAttendanceSyncData_markAttendanceSyncBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GmarkAttendanceSyncData_markAttendanceSync &&
        G__typename == other.G__typename &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GmarkAttendanceSyncData_markAttendanceSync')
          ..add('G__typename', G__typename)
          ..add('status', status))
        .toString();
  }
}

class GmarkAttendanceSyncData_markAttendanceSyncBuilder
    implements
        Builder<GmarkAttendanceSyncData_markAttendanceSync,
            GmarkAttendanceSyncData_markAttendanceSyncBuilder> {
  _$GmarkAttendanceSyncData_markAttendanceSync? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  GmarkAttendanceSyncData_markAttendanceSyncBuilder() {
    GmarkAttendanceSyncData_markAttendanceSync._initializeBuilder(this);
  }

  GmarkAttendanceSyncData_markAttendanceSyncBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GmarkAttendanceSyncData_markAttendanceSync other) {
    _$v = other as _$GmarkAttendanceSyncData_markAttendanceSync;
  }

  @override
  void update(
      void Function(GmarkAttendanceSyncData_markAttendanceSyncBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GmarkAttendanceSyncData_markAttendanceSync build() => _build();

  _$GmarkAttendanceSyncData_markAttendanceSync _build() {
    final _$result = _$v ??
        _$GmarkAttendanceSyncData_markAttendanceSync._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GmarkAttendanceSyncData_markAttendanceSync', 'G__typename'),
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

class FetchUserAttendanceStatus {
  int? attendanceId;
  int? date;
  int? checkInTime;
  int? checkOutTime;
  int? expectedCheckInTime;
  int? expectedCheckOutTime;
  String? currentStatus;
  int? allowedBreak;
  int? bufferTime;
  dynamic attendanceStatusesObj;
  AttendanceUser? user;
  List<AttendanceBreak>? attendanceBreak;
  int? createdOn;
  int? updatedOn;

  FetchUserAttendanceStatus({
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
    this.updatedOn,
  });

  factory FetchUserAttendanceStatus.fromJson(Map<String, dynamic> json) {
    List<AttendanceBreak> parseAttendanceBreak(dynamic data) {
      if (data == null) return [];
      if (data is List) {
        return data
            .map((e) => AttendanceBreak.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (data is Map) {
        return [AttendanceBreak.fromJson(data as Map<String, dynamic>)] ;
      }
      return [];
    }

    return FetchUserAttendanceStatus(
      attendanceId: json["attendanceId"],
      user: json["user"] == null ? null : AttendanceUser.fromJson(json["user"]),
      date: json["date"],
      checkInTime: json["checkInTime"],
      checkOutTime: json["checkOutTime"],
      expectedCheckInTime: json["expectedCheckInTime"],
      expectedCheckOutTime: json["expectedCheckOutTime"],
      currentStatus: json["currentStatus"],
      allowedBreak: json["allowedBreak"],
      bufferTime: json["bufferTime"],
      attendanceStatusesObj: json["attendanceStatusesObj"],
      attendanceBreak: parseAttendanceBreak(json["attendanceBreak"]),
      createdOn: json['createdOn'],
      updatedOn: json['updatedOn'],
    );
  }

  Map<String, dynamic> toJson() => {
        "attendanceId": attendanceId,
        "user": user?.toJson(),
        "date": date,
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
        "expectedCheckInTime": expectedCheckInTime,
        "expectedCheckOutTime": expectedCheckOutTime,
        "currentStatus": currentStatus,
        "allowedBreak": allowedBreak,
        "bufferTime": bufferTime,
        "attendanceStatusesObj": attendanceStatusesObj,
        "attendanceBreak": attendanceBreak?.map((e) => e.toJson()).toList(),
        "createdOn": createdOn,
        "updatedOn": updatedOn,
      };

  FetchUserAttendanceStatus copyWith({
    int? attendanceId,
    int? date,
    int? checkInTime,
    int? checkOutTime,
    int? expectedCheckInTime,
    int? expectedCheckOutTime,
    String? currentStatus,
    int? allowedBreak,
    int? bufferTime,
    dynamic attendanceStatusesObj,
    AttendanceUser? user,
    List<AttendanceBreak>? attendanceBreak,
    int? createdOn,
    int? updatedOn,
  }) {
    return FetchUserAttendanceStatus(
      attendanceId: attendanceId ?? this.attendanceId,
      user: user ?? this.user,
      date: date ?? this.date,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      expectedCheckInTime: expectedCheckInTime ?? this.expectedCheckInTime,
      expectedCheckOutTime: expectedCheckOutTime ?? this.expectedCheckOutTime,
      currentStatus: currentStatus ?? this.currentStatus,
      allowedBreak: allowedBreak ?? this.allowedBreak,
      bufferTime: bufferTime ?? this.bufferTime,
      attendanceStatusesObj:
          attendanceStatusesObj ?? this.attendanceStatusesObj,
      attendanceBreak: attendanceBreak ?? this.attendanceBreak,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  @override
  String toString() {
    return 'FetchUserAttendanceStatus(attendanceId: $attendanceId, user: $user, date: $date, '
        'checkInTime: $checkInTime, checkOutTime: $checkOutTime, expectedCheckInTime: $expectedCheckInTime, '
        'expectedCheckOutTime: $expectedCheckOutTime, currentStatus: $currentStatus, allowedBreak: $allowedBreak, '
        'bufferTime: $bufferTime, attendanceStatusesObj: $attendanceStatusesObj, attendanceBreak: $attendanceBreak, createdOn: $createdOn, updatedOn: $updatedOn)';
  }
}

// ---------------------- AttendanceBreak ----------------------
class AttendanceBreak {
  dynamic breakId;
  dynamic startTime;
  dynamic endTime;
  dynamic duration;

  AttendanceBreak({this.breakId, this.startTime, this.endTime, this.duration});

  factory AttendanceBreak.fromJson(Map<String, dynamic> json) {
    return AttendanceBreak(
      breakId: json["breakId"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      duration: json["duration"],
    );
  }

  Map<String, dynamic> toJson() => {
        "breakId": breakId,
        "startTime": startTime,
        "endTime": endTime,
        "duration": duration,
      };

  AttendanceBreak copyWith({
    dynamic breakId,
    dynamic startTime,
    dynamic endTime,
    dynamic duration,
  }) {
    return AttendanceBreak(
      breakId: breakId ?? this.breakId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
    );
  }

  @override
  String toString() {
    return 'AttendanceBreak(breakId: $breakId, startTime: $startTime, endTime: $endTime, duration: $duration)';
  }
}

// ---------------------- AttendanceUser ----------------------
class AttendanceUser {
  int? id;
  String? name;
  AttendanceType? type;
  String? referenceId;
  String? contactNumber;
  String? emailId;
  String? status;
  dynamic employeeId;

  AttendanceUser({
    this.id,
    this.name,
    this.type,
    this.referenceId,
    this.contactNumber,
    this.emailId,
    this.status,
    this.employeeId,
  });

  factory AttendanceUser.fromJson(Map<String, dynamic> json) {
    return AttendanceUser(
      id: json["id"],
      name: json["name"],
      type: json["type"] == null ? null : AttendanceType.fromJson(json["type"]),
      referenceId: json["referenceId"],
      contactNumber: json["contactNumber"],
      emailId: json["emailId"],
      status: json["status"],
      employeeId: json["employeeId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type?.toJson(),
        "referenceId": referenceId,
        "contactNumber": contactNumber,
        "emailId": emailId,
        "status": status,
        "employeeId": employeeId,
      };

  AttendanceUser copyWith({
    int? id,
    String? name,
    AttendanceType? type,
    String? referenceId,
    String? contactNumber,
    String? emailId,
    String? status,
    dynamic employeeId,
  }) {
    return AttendanceUser(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      referenceId: referenceId ?? this.referenceId,
      contactNumber: contactNumber ?? this.contactNumber,
      emailId: emailId ?? this.emailId,
      status: status ?? this.status,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  @override
  String toString() {
    return 'AttendanceUser(id: $id, name: $name, type: $type, referenceId: $referenceId, '
        'contactNumber: $contactNumber, emailId: $emailId, status: $status, employeeId: $employeeId)';
  }
}

// ---------------------- Type ----------------------
class AttendanceType {
  String? name;
  String? status;

  AttendanceType({this.name, this.status});

  factory AttendanceType.fromJson(Map<String, dynamic> json) {
    return AttendanceType(
      name: json["name"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
      };

  AttendanceType copyWith({String? name, String? status}) {
    return AttendanceType(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'Type(name: $name, status: $status)';
  }
}

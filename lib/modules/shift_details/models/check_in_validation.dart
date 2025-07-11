class CheckInValidation {
  bool isValidTime;
  int? expectedEndTime;
  int? expectedStartTime;
  bool is24Hrs;
  bool isCompeletedAttendance;
  List<String>? inRestrictedUser;

  CheckInValidation({
    this.isValidTime = false,
    this.expectedEndTime,
    this.expectedStartTime,
    this.is24Hrs = false,
    this.isCompeletedAttendance = false,
    this.inRestrictedUser,
  });

  Map<String, dynamic> toJson() {
    return {
      'isValidTime': isValidTime,
      'expectedEndTime': expectedEndTime,
      'expectedStartTime': expectedStartTime,
      'is24Hrs': is24Hrs,
      'isCompeletedAttendance': isCompeletedAttendance,
      'inRestrictedUser': inRestrictedUser,
    };
  }

  factory CheckInValidation.fromJson(Map<String, dynamic> json) {
    return CheckInValidation(
      isValidTime: json['isValidTime'] ?? false,
      expectedEndTime: json['expectedEndTime'],
      expectedStartTime: json['expectedStartTime'],
      is24Hrs: json['is24Hrs'] ?? false,
      isCompeletedAttendance: json['isCompeletedAttendance'] ?? false,
      inRestrictedUser: json['inRestrictedUser'] != null 
          ? List<String>.from(json['inRestrictedUser'])
          : null,
    );
  }
}

DateTime parseDateTime(String timeStr) {
  final now = DateTime.now().toUtc(); // Get current date
  final parts = timeStr.split(':');
  return DateTime.utc(
    now.year,
    now.month,
    now.day,
    int.parse(parts[0]), // Set hours
    int.parse(parts[1]), // Set minutes
  );
}
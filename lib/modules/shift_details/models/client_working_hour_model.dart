int? parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}

class ClientWorkingHour {
  final int? id;
  final String? name;
  final int? sundayStartTime;
  final int? sundayEndTime;
  final int? mondayStartTime;
  final int? mondayEndTime;
  final int? tuesdayStartTime;
  final int? tuesdayEndTime;
  final int? wednesdayStartTime;
  final int? wednesdayEndTime;
  final int? thursdayStartTime;
  final int? thursdayEndTime;
  final int? fridayStartTime;
  final int? fridayEndTime;
  final int? saturdayStartTime;
  final int? saturdayEndTime;
  final int? allowedBreak;
  final int? bufferTime;
  final String? client;

  ClientWorkingHour({
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
    this.client,
  });

  factory ClientWorkingHour.fromJson(Map<String, dynamic> json) {
    return ClientWorkingHour(
      id: parseInt(json['id']),
      name: json['name'],
      sundayStartTime: parseInt(json['sundayStartTime']),
      sundayEndTime: parseInt(json['sundayEndTime']),
      mondayStartTime: parseInt(json['mondayStartTime']),
      mondayEndTime: parseInt(json['mondayEndTime']),
      tuesdayStartTime: parseInt(json['tuesdayStartTime']),
      tuesdayEndTime: parseInt(json['tuesdayEndTime']),
      wednesdayStartTime: parseInt(json['wednesdayStartTime']),
      wednesdayEndTime: parseInt(json['wednesdayEndTime']),
      thursdayStartTime: parseInt(json['thursdayStartTime']),
      thursdayEndTime: parseInt(json['thursdayEndTime']),
      fridayStartTime: parseInt(json['fridayStartTime']),
      fridayEndTime: parseInt(json['fridayEndTime']),
      saturdayStartTime: parseInt(json['saturdayStartTime']),
      saturdayEndTime: parseInt(json['saturdayEndTime']),
      allowedBreak: parseInt(json['allowedBreak']),
      bufferTime: parseInt(json['bufferTime']),
      client: json['client'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sundayStartTime': sundayStartTime,
      'sundayEndTime': sundayEndTime,
      'mondayStartTime': mondayStartTime,
      'mondayEndTime': mondayEndTime,
      'tuesdayStartTime': tuesdayStartTime,
      'tuesdayEndTime': tuesdayEndTime,
      'wednesdayStartTime': wednesdayStartTime,
      'wednesdayEndTime': wednesdayEndTime,
      'thursdayStartTime': thursdayStartTime,
      'thursdayEndTime': thursdayEndTime,
      'fridayStartTime': fridayStartTime,
      'fridayEndTime': fridayEndTime,
      'saturdayStartTime': saturdayStartTime,
      'saturdayEndTime': saturdayEndTime,
      'allowedBreak': allowedBreak,
      'bufferTime': bufferTime,
      'client': client,
    };
  }

  // Helper method to get start time for a specific day
  int? getStartTimeForDay(int weekday) {
    switch (weekday) {
      case 1: // Monday
        return mondayStartTime;
      case 2: // Tuesday
        return tuesdayStartTime;
      case 3: // Wednesday
        return wednesdayStartTime;
      case 4: // Thursday
        return thursdayStartTime;
      case 5: // Friday
        return fridayStartTime;
      case 6: // Saturday
        return saturdayStartTime;
      case 7: // Sunday
        return sundayStartTime;
      default:
        return null;
    }
  }

  // Helper method to get end time for a specific day
  int? getEndTimeForDay(int weekday) {
    switch (weekday) {
      case 1: // Monday
        return mondayEndTime;
      case 2: // Tuesday
        return tuesdayEndTime;
      case 3: // Wednesday
        return wednesdayEndTime;
      case 4: // Thursday
        return thursdayEndTime;
      case 5: // Friday
        return fridayEndTime;
      case 6: // Saturday
        return saturdayEndTime;
      case 7: // Sunday
        return sundayEndTime;
      default:
        return null;
    }
  }

  @override
  String toString() {
    return 'ClientWorkingHour(id: $id, name: $name, bufferTime: $bufferTime)';
  }
} 
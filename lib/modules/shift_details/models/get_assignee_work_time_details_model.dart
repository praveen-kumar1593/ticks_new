import 'shift_model.dart';
import 'client_working_hour_model.dart';

class GetAssigneeWorkTimeDetailsModel {
  final Shift? shift;
  final ClientWorkingHour? clientWorkingHour;

  GetAssigneeWorkTimeDetailsModel({
    this.shift,
    this.clientWorkingHour,
  });

  factory GetAssigneeWorkTimeDetailsModel.fromJson(Map<String, dynamic> json) {
    return GetAssigneeWorkTimeDetailsModel(
      shift: json['shift'] != null ? Shift.fromJson(json['shift']) : null,
      clientWorkingHour: json['clientWorkingHour'] != null 
          ? ClientWorkingHour.fromJson(json['clientWorkingHour']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shift': shift?.toJson(),
      'clientWorkingHour': clientWorkingHour?.toJson(),
    };
  }

  @override
  String toString() {
    return 'GetAssigneeWorkTimeDetailsModel(shift: $shift, clientWorkingHour: $clientWorkingHour)';
  }
} 
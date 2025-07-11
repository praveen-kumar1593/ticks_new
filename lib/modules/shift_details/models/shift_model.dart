class Shift {
  final String? identifier;
  final String? startTime;
  final String? endTime;
  final int? duration;
  final String? domain;
  final String? name;
  final String? description;
  final String? status;
  final int? allowedBreak;
  final int? bufferTime;

  Shift({
    this.identifier,
    this.startTime,
    this.endTime,
    this.duration,
    this.domain,
    this.name,
    this.description,
    this.status,
    this.allowedBreak,
    this.bufferTime,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      identifier: json['identifier'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      duration: json['duration'],
      domain: json['domain'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      allowedBreak: json['allowedBreak'],
      bufferTime: json['bufferTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'startTime': startTime,
      'endTime': endTime,
      'duration': duration,
      'domain': domain,
      'name': name,
      'description': description,
      'status': status,
      'allowedBreak': allowedBreak,
      'bufferTime': bufferTime,
    };
  }

  @override
  String toString() {
    return 'Shift(identifier: $identifier, name: $name, startTime: $startTime, endTime: $endTime, bufferTime: $bufferTime)';
  }
} 
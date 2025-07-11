class ApiResponse {
  bool success = false;
  dynamic data;
  String? message;
  String? error;

  ApiResponse({
    this.success = false,
    this.data,
    this.message,
    this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? false,
      data: json['data'],
      message: json['message'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'message': message,
      'error': error,
    };
  }
} 
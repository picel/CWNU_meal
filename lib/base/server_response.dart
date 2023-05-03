import 'dart:convert';

class ServerResponse<T> {
  String? message;
  int status;
  String? code;

  T? data;
  bool error;

  ServerResponse({
    required this.message,
    required this.status,
    this.code,
    this.data,
    required this.error,
  });

  static T? parseData<T>(dynamic data) {
    if (data is T) {
      return data;
    } else if (data is Map<String, dynamic>) {
      return data as T;
    } else if (data is List) {
      return data as T;
    } else {
      return null;
    }
  }

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(
      message: json['message'] as String?,
      status: json['status'] as int,
      code: json['code'] as String?,
      data: parseData<T>(json['data']),
      error: json['error'] as bool,
    );
  }
}

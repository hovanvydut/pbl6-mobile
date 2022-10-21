class CommonResponse {
  CommonResponse({
    required this.data,
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        data: json['data'] as dynamic,
        success: json['success'] as bool,
        statusCode: json['statusCode'] as int,
        message: json['message'] as String,
      );

  final dynamic data;
  final bool success;
  final int statusCode;
  final String message;
}

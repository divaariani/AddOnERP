class ResponseModel {
  final int status;
  final String message;

  ResponseModel({required this.status, required this.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
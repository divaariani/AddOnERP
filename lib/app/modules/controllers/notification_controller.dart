import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class NotificationController{
  static const String baseUrl = '{API}';

  static Future<ResponseModel> postNotification({
    required int userid,
    required String title,
    required String description,
    required String date,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=insert_notification_activity'),
      body: {
        'userid': userid.toString(),
        'title': title,
        'description': description,
        'date': date.toString(),
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to post form data');
    }
  }
}

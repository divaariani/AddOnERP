import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class NotificationController{
  static const String baseUrl = '{API}';

  static Future<ResponseModel> postNotification({
    required int id,
    required int userid,
    required String title,
    required String description,
    required String date
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_notification_activity'),
      body: {
        'id': id.toString(),
        'userid': userid.toString(),
        'title': title,
        'description': description,
        'date': date
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

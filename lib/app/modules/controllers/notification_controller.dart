import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';
import '../utils/sessionmanager.dart';
import '../utils/globals.dart';

class NotificationController{
  final SessionManager _sessionManager = SessionManager();
  String userId = "";

  NotificationController() {
    _initialize();
  }

  void _initialize() async {
    try {
      userId = await _sessionManager.getUserId() ?? "";
    } catch (error) {
      print(error);
    }
  }

  static Future<ResponseModel> postNotification({
    required int userid,
    required String title,
    required String description,
    required String date,
  }) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl?function=insert_notification_activity'),
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

  Future<ResponseModel> viewData({
    required int id,
    required int userid,
    required String title,
    required String description,
    required String date
  }) async {
    final userId = await _sessionManager.getUserId() ?? "";

    final response = await http.post(
      Uri.parse('$apiBaseUrl?function=get_notification_activity&userid=$userId'),
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

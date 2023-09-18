import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class AuditorController{
  static const String baseUrl = '{API}';

  static Future<ResponseModel> postFormData({
    required int userid,
    required String name,
    required DateTime date,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=insert_stock_inventory'),
      body: {
        'userid': userid.toString(),
        'name': name,
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
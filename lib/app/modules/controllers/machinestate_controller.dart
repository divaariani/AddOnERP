import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class MachineStateController{
  static const String baseUrl = '{API}';

  static Future<ResponseModel> postFormData({
    required int id,
    required String state,
    required String timestate,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=insert_machine_status'),
      body: {
        'pidworkcenter': id.toString(),
        'pstatus': state,
        'pstatustime': timestate,
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
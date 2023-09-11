import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class MachineController{
  static const String baseUrl = '{YOUR_API}';

  static Future<ResponseModel> postFormData({
    required int id,
    required String name,
    required int userId,
    required String namaoperator,
    required String statusmesin,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_workcenter_list'),
      body: {
        'id': id.toString(),
        'name': name,
        'userid': userId.toString(),
        'namaoperator': namaoperator,
        'statusmesin': statusmesin,
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
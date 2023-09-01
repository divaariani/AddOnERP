import 'dart:convert';
import 'package:http/http.dart' as http;
import 'response_model.dart';

class AbsensiController{
  static const String baseUrl = '{YOUR API}';

  static Future<ResponseModel> postFormData({
    required int idwc,
    required int userId,
    required String oprTap,
    required String tap,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=absensi_operator_id_2'),
      body: {
        'idwc': idwc.toString(),
        'userid': userId.toString(),
        'oprtap': oprTap,
        'tap': tap,
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
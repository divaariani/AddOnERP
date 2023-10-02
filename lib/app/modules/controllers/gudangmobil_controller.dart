import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class GudangMobilController{
  static const String baseUrl = '{YOUR API}';

  static Future<ResponseModel> postFormData({
    required int puserid,
    required String pbarcode_mobil,
    required String plotnumber,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=insert_warehouse_out'),
      body: {
        'puserid': puserid.toString(),
        'pbarcode_mobil': pbarcode_mobil,
        'plotnumber': plotnumber,
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

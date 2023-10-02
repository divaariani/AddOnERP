import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class GudangViewController{
  static const String baseUrl = '{YOUR API}';
  static Future<ResponseModel> postFormData({
    required int id,
    required int userid,
    required String barcode_mobil,
    required String lotnumber,
    required String name,
    required int quantity,
    required String state,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_warehouse_views_out'),
      body: {
        'id': id.toString(),
        'userid': userid.toString(),
        'barcode_mobil': barcode_mobil,
        'lotnumber': lotnumber,
        'name': name,
        'quantity': quantity.toString(),
        'state': state
      },
    );
    
    print('${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      print("=======================");
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to view form data');
    }
  }
}

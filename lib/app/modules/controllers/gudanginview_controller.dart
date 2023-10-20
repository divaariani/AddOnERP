import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class GudangInViewController{
  static const String baseUrl = '{YOUR API}';
  static Future<ResponseModel> postFormData({
    required String checked,
    required int id,
    required DateTime tgl_kp,
    required String lotnumber,
    required String namabarang,
    required int qty,
    required String uom,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_warehouse_views_in'),
      body: {
        'checked': checked,
        'id': id.toString(),
        'tgl_kp': tgl_kp.toIso8601String(),
        'lotnumber': lotnumber,
        'name': namabarang,
        'qty': qty.toString(),
        'state': uom,
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

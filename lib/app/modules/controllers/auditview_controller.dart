import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class AuditViewController{
  static const String baseUrl = '{API}';

  static Future<ResponseModel> postFormData({
    required int id,
    required String lokasi,
    required String lotBarang,
    required String namabarang,
    required int qty,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_audit_views'),
      body: {
        'id': id.toString(),
        'lokasi': lokasi,
        'lot_barang': lotBarang,
        'namabarang': namabarang,
        'qty': qty.toString(),
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to view form data');
    }
  }
}

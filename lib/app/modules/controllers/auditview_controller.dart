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
    required String state,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_audit_views'),
      body: {
        'id': id.toString(),
        'lokasi': lokasi,
        'lot_barang': lotBarang,
        'namabarang': namabarang,
        'qty': qty.toString(),
        'state': state
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to view form data');
    }
  }

  static Future<void> deleteData(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl?function=delete_audit'),
        body: {
          'id': id.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Data with ID $id has been deleted successfully.');
      } else {
        print('Failed to delete data with ID $id');
      }
    } catch (e) {
      print('Error deleting data: $e');
    }
  }
}

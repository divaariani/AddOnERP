import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class AuditStockController{
  static const String baseUrl = '{API}';

  static Future<ResponseModel> postFormData({
    required int id,
    required String pbarang,
    required String plokasi,
    required DateTime pdate,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=insert_audit_stock'),
      body: {
        'pinventory_id': id.toString(),
        'pnomorbarcode': pbarang,
        'plokasi': plokasi,
        'pdate': pdate.toString(),
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
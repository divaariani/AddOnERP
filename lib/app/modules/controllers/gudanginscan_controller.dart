import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';


class GudangInScanController {
  static const String baseUrl = '{YOUR API}';

  static Future<ResponseModel> updateWarehouseInScan({required String lotnumber}) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=update_warehouse_in_scan'),
      body: {
        'lotnumber': lotnumber,
      },
    );

    print('${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Gagal mengupdate data gudang');
    }
  }
}



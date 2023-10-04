import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'response_model.dart';
import 'package:get/get.dart';



class LaporanViewController{
  static const String baseUrl = '{YOUR API}';
  static Future<ResponseModel> postFormData({
    required int product_id,
    required String lotnumber,
    required String namabarang,
    required int qty,
    required String uom,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_laporan_produksi'),
      body: {
        'product_id': product_id.toString(),
        'lotnumber': lotnumber,
        'namabarang': namabarang,
        'qty': qty.toString(),
        'uom': uom,
      },
    );
    
  //  print('${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      print("=======================");
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to view form data');
    }
  }
}

 

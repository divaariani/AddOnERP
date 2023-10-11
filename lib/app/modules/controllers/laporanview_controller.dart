import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class LaporanViewController{
  static const String baseUrl = '{YOUR API}';
  static Future<ResponseModel> postFormData({
    required int nomor_kp,
    required DateTime tgl_kp,
    required int userid,
    required String dibuatoleh,
    required DateTime dibuattgl,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_laporan_produksi_2'),
      body: {
        'nomor_kp': nomor_kp.toString(),
        'tgl_kp': tgl_kp.toString(),
        'userid': userid.toString(),
        'dibuatoleh': dibuatoleh,
        'dibuattgl' : dibuattgl.toString(),
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

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class MonitoringViewController{
  static const String baseUrl = '{YOUR API}';
  static Future<ResponseModel> postFormData({
    required int id,
    required int idmas,
    required String name,
    required int qty,
    required String uom,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_monitoring_stock'),
      body: {
        'id': id.toString(),
        'idmas': idmas.toString(),
        'name': name,
        'quantity': qty.toString(),
        'state': uom,
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

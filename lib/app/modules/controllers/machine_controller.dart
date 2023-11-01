import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';

class MachineController{
  static const String baseUrl = '{API}';

  static Future<ResponseModel> postFormOperator({
    required int id,
    required String name,
    required int userId,
    required String namaoperator,
    required String statusmesin,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_workcenter_list'),
      body: {
        'id': id.toString(),
        'name': name,
        'userid': userId.toString(),
        'namaoperator': namaoperator,
        'statusmesin': statusmesin,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to post form data');
    }
  }

  static Future<ResponseModel> postFormMachineState({
    required int id,
    required String state,
    required String timestate,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=insert_machine_status'),
      body: {
        'pidworkcenter': id.toString(),
        'pstatus': state,
        'pstatustime': timestate,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to post form data');
    }
  }

  static Future<Map<String, dynamic>> getWorkcenterList() async {
    final response = await http.get(
      Uri.parse('$baseUrl?function=get_workcenter_list'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
}

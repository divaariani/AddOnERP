import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';
import '../utils/sessionmanager.dart';

class AuditUserController{
  static const String baseUrl = '{API}';
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  String userName = "";
  
  Future<void> _fetchUserId() async {
    userName = await _sessionManager.getUsername() ?? "";
  }

 Future<ResponseModel> postFormData({
    required int id,
    required String name,
  }) async {
    await _fetchUserId(); 

    final response = await http.post(
      Uri.parse('$baseUrl?function=get_inventory_id&nama_auditor=Audit_$userName'),
      body: {
        'id': id.toString(),
        'name': name,
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
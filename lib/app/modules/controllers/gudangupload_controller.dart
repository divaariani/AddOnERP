import 'package:http/http.dart' as http;
import 'dart:convert'; 

class GudangUploadController {
  static const String baseUrl = '{YOUR API}'; 

  Future<Map<String, dynamic>> uploadDataToGudang() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl?function=update_warehouse_in_upload'), 
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body); 
        return responseData;
      } else {
        throw Exception('Upload failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

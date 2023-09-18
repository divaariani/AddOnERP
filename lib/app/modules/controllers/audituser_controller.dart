import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/globals.dart';

class AuditUserController {
  static const String baseUrl = '{API}';
  late DateTime currentTime;

  Future<void> _fetchCurrentTime() async {
    try {
      currentTime = DateTime.now();
    } catch (error) {
      print(error);
    }
  }

  Future<int> fetchIdInventory() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?function=get_inventory_id&nama_auditor=$currentNameAuditor'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        if (data.isNotEmpty) {
          int highestId = 0;
          for (var item in data) {
            final int id = int.tryParse(item['id'].toString()) ?? 0;
            if (id > highestId) {
              highestId = id;
            }
          }
          return highestId;
        } else {
          throw Exception('No data in the API response');
        }
      } else {
        throw Exception('Failed to fetch idinventory from API');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch idinventory from API');
    }
  }
}

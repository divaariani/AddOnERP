import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../utils/sessionmanager.dart';

class AuditUserController {
  static const String baseUrl = '{API}';
  late DateTime currentTime;
  late String formattedDate;
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  String userId = "";
  String userName = "";

  AuditUserController() {
    _initialize();
  }

  Future<void> _initialize() async {
  try {
    userId = await _sessionManager.getUserId() ?? "";
    userName = await _sessionManager.getUsername() ?? "";
    currentTime = DateTime.now(); 
    formattedDate = DateFormat('ddMMyyyy').format(currentTime);
    print(formattedDate); 
  } catch (error) {
    print(error);
  }
}

  Future<int> fetchIdInventory() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl?function=get_inventory_id&nama_auditor=Auditor_$userName' + '_$formattedDate'),
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

  Future<String> fetchNameInventory() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl?function=get_inventory_id&nama_auditor=Auditor_$userName' + '_$formattedDate',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        if (data.isNotEmpty) {
          final String name = data.last['name'];
          return name;
        } else {
          throw Exception('Data tidak ditemukan di API');
        }
      } else {
        throw Exception(
            'Gagal mendapatkan respon dari API: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
      throw Exception('Gagal mengambil data name dari API');
    }
  }
}

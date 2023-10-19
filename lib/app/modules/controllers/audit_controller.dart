import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../utils/sessionmanager.dart';
import 'response_model.dart';

class AuditController{
  static const String baseUrl = '{API}';
  late DateTime currentTime;
  late String formattedDate;
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  String userId = "";
  String userName = "";

  AuditController() {
    _initialize();
  }

  void _initialize() async {
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
            '$baseUrl?function=get_inventory_id&nama_auditor=Auditor_$userName' +
                '_$formattedDate'),
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
          '$baseUrl?function=get_inventory_id&nama_auditor=Auditor_$userName' +
              '_$formattedDate',
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

  static Future<ResponseModel> postFormAuditor({
    required int userid,
    required String name,
    required DateTime date,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=insert_stock_inventory'),
      body: {
        'userid': userid.toString(),
        'name': name,
        'date': date.toString(),
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to post form data');
    }
  }

  static Future<ResponseModel> postFormStock({
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

  static Future<ResponseModel> viewData({
    required int id,
    required String lokasi,
    required String lotBarang,
    required String namabarang,
    required int qty,
    required String state,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl?function=get_audit_views'),
      body: {
        'id': id.toString(),
        'lokasi': lokasi,
        'lot_barang': lotBarang,
        'namabarang': namabarang,
        'qty': qty.toString(),
        'state': state
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to view form data');
    }
  }

  static Future<void> deleteData(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl?function=delete_audit'),
        body: {
          'id': id.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Data with ID $id has been deleted successfully.');
      } else {
        print('Failed to delete data with ID $id');
      }
    } catch (e) {
      print('Error deleting data: $e');
    }
  }
}
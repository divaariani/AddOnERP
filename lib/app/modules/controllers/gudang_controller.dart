import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_model.dart';
import '../utils/globals.dart';
class GudangController{

  //Scan check data pada Gudang in
  static Future<ResponseModel> updateWarehouseInScan({required String lotnumber}) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl?function=update_warehouse_in_scan'),
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

  //Gudang IN (upload state checked)
  Future<Map<String, dynamic>> uploadDataToGudang() async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl?function=update_warehouse_in_upload'), 
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

  //Menampilkan database Gudang In
  static Future<ResponseModel> postFormData({
    required String checked,
    required int id,
    required DateTime tgl_kp,
    required String lotnumber,
    required String namabarang,
    required int qty,
    required String uom,
  }) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl?function=get_warehouse_views_in'),
      body: {
        'checked': checked,
        'id': id.toString(),
        'tgl_kp': tgl_kp.toIso8601String(),
        'lotnumber': lotnumber,
        'name': namabarang,
        'qty': qty.toString(),
        'state': uom,
      },
    );
    
    print('${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      print("=======================");
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to view form data');
    }
  }

  //Menampilkan database Gudang Out
  static Future<ResponseModel> postFormGudangOut({
    required int id,
    required int userid,
    required String barcode_mobil,
    required String lotnumber,
    required String name,
    required int quantity,
    required String state,
  }) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl?function=get_warehouse_views_out'),
      body: {
        'id': id.toString(),
        'userid': userid.toString(),
        'barcode_mobil': barcode_mobil,
        'lotnumber': lotnumber,
        'name': name,
        'quantity': quantity.toString(),
        'state': state
      },
    );
    
    print('${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      print("=======================");
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to view form data');
    }
  }

  //Insert data scan mobil pada Gudang Mobil
  static Future<ResponseModel> postFormDataMobil({
    required int puserid,
    required String pbarcode_mobil,
    required String plotnumber,
  }) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl?function=insert_warehouse_out'),
      body: {
        'puserid': puserid.toString(),
        'pbarcode_mobil': pbarcode_mobil,
        'plotnumber': plotnumber,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body); 
      return ResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to post form data');
    }
  }

  //Fungsi menghapus data pada Gudang Out
  static Future<void> deleteData(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl?function=delete_warehouse_out'),
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

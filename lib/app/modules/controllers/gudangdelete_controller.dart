import 'package:http/http.dart' as http;

class GudangDeleteController {
  static const String baseUrl = '{YOUR API}';

  static Future<void> deleteData(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl?function=delete_warehouse_out'),
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

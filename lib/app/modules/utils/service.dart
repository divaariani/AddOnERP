import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class CustomerService {
  Future<List<CustomerModel>> getDataCustomer(String nomorCo) async {
    final url = Uri.parse('{API}');
    final response = await http.post(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<CustomerModel> customer = [];
      final List<dynamic> data = json.decode(response.body)['data'];
      for (var element in data) {
        customer.add(CustomerModel.fromJson(element));
      }
      return customer;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

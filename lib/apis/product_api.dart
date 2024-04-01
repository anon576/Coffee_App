import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/app_properties.dart';

class ProductAPI {
  static Future<Map<String,dynamic>> fetchProducts(
      {required int range
      }) async {
    final response = await http.get(Uri.parse(
        '$apilink/get_feed?lastbookid=$range'));

    if (response.statusCode == 200) {
      Map<String,dynamic> fetchedBooks = jsonDecode(response.body);

      return fetchedBooks;
    } else {
     return {};
    }
  }
                                                                                                                                                                                                                                                                                                                 
  static Future<List<dynamic>> fetchCarsoul() async {
    final response =
        await http.get(Uri.parse('https://api.sampleapis.com/coffee/hot'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/app_properties.dart';
import '../components/share_prefs.dart';

class OrderAPI{


 static Future<List<dynamic>> getUserOrderss() async {
    try {
      int userid =await SharePrefs.readPrefs("userID", "int");
      final response = await http.get(Uri.parse('$apilink/your_order/$userid'));
      
      if (response.statusCode == 200) {
        Map<dynamic,dynamic> data = jsonDecode(response.body);
        return data['orders'];
      } else {
        throw Exception('Failed to load books');
      }
    } catch(error) {
      print(error);
      throw Exception('Failed to load books');
    }
  }


 }
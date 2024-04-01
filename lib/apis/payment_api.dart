import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/app_properties.dart';
import '../components/share_prefs.dart';

class PaymentAPI {
  static Future<Map<dynamic, dynamic>> order({
    required int bookID,
    required int aID,
    required String paymentID,
    required String paymentStatus,
  }) async {
    try {
      int userid = await SharePrefs.readPrefs("userID", "int");

      Map<String, dynamic> bookdata = {
        "bookID": bookID,
        "aID": aID,
        "paymentID": paymentID,
        "paymentStatus": paymentStatus,
        "userid": userid
      };

      String jsonData = jsonEncode(bookdata);

      Uri apiUrl = Uri.parse('$apilink/order');

      http.Response response = await http.post(apiUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonData);

      if (response.statusCode == 200) {
        Map<dynamic, dynamic> data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        Map<dynamic, dynamic> data = {"success": false};
        return data;
      }
    } catch (error) {
      Map<dynamic, dynamic> data = {"success": false};
      return data;
    }
  }

  static Future<Map<dynamic, dynamic>> gerOrderDetails({
    required int amount,
  }) async {
    try {
      Map<String, dynamic> bookdata = {
        "amt": amount,
      };

      String jsonData = jsonEncode(bookdata);

      Uri apiUrl = Uri.parse('$apilink/createOrder');

      http.Response response = await http.post(apiUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonData);

      if (response.statusCode == 200) {
        Map<dynamic, dynamic> data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        Map<dynamic, dynamic> data = {"success": false};
        return data;
      }
    } catch (error) {
      Map<dynamic, dynamic> data = {"success": false};
      return data;
    }
  }
}

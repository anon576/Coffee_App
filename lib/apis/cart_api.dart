
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/app_properties.dart';
import '../components/share_prefs.dart';


class CartAPI{

  static Future<List<dynamic>> getAllCart() async {
      int userid = await SharePrefs.readPrefs("userID", "int");
    final response =
        await http.get(Uri.parse('$apilink/get_cart_items?userid=$userid'));
    if (response.statusCode == 200) {
     Map<dynamic,dynamic> data = jsonDecode(response.body);
     
      return data["cartItems"];
    } else {
      throw Exception('Failed to load products');
    }
  }

static Future< Map<dynamic,dynamic> > addToCart(
      {required int bookID}) async {
    try {
      int userid = await SharePrefs.readPrefs("userID", "int");

      Map<String, dynamic> bookdata = {
        "bookID": bookID,
        "userid": userid
      };

      String jsonData = jsonEncode(bookdata);

      Uri apiUrl = Uri.parse('$apilink/add_to_cart');

      http.Response response = await http.post(apiUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonData);

      if (response.statusCode == 200) {
        Map<dynamic,dynamic> data = jsonDecode(response.body);

        return data;
      } else {
         Map<dynamic,dynamic>  data = {
          "success":false
         };
        return data;
      }
    } catch (error) {
     Map<dynamic,dynamic>  data = {
          "success":false
         };
        return data;
    }
  }



static Future<bool> deleteCartItems(
      {required int bookID}) async {
    try {
      int userid = await SharePrefs.readPrefs("userID", "int");

      Map<String, dynamic> bookdata = {
        "bookID": bookID,
        "userid": userid
      };

      String jsonData = jsonEncode(bookdata);

      Uri apiUrl = Uri.parse('$apilink/delete_cart_item');

      http.Response response = await http.post(apiUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonData);

      if (response.statusCode == 200) {
        Map<dynamic,dynamic> data = jsonDecode(response.body);

        return data['success'];
      } else{
        return false;
      }
      
    } catch (error) {
        return false;
    }
  }

static Future<bool> addCartOrder(
      {
        required int aid,
        required String paymentID,
        required String paymentStatus,
      }) async {
    try {
      int userid = await SharePrefs.readPrefs("userID", "int");

      Map<String, dynamic> bookdata = {
        "aid":aid,
        "paymentID":paymentID,
        "paymentStatus":paymentStatus,
        "userid": userid
      };

      String jsonData = jsonEncode(bookdata);
    print("wroking perfetcy");
      Uri apiUrl = Uri.parse('$apilink/add_cart_order');

      http.Response response = await http.post(apiUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonData);

      if (response.statusCode == 200) {
        Map<dynamic,dynamic> data = jsonDecode(response.body);

        return data['success'];
      } else{
        return false;
      }
      
    } catch (error) {
        return false;
    }
  }


  }

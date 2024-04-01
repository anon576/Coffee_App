import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/app_properties.dart';
import '../components/share_prefs.dart';

class CoffeeAPI {


 static Future<List<dynamic>> getUsercoffees() async {
    try {
      int userid =await SharePrefs.readPrefs("userID", "int");
      final response = await http.get(Uri.parse('$apilink/your_coffee/$userid'));
      
      if (response.statusCode == 200) {
        Map<dynamic,dynamic> data = jsonDecode(response.body);
        return data['coffees'];
      } else {
        throw Exception('Failed to load coffees');
      }
    } catch(error) {
      print(error);
      throw Exception('Failed to load coffees');
    }
  }

  static Future< Map<dynamic,dynamic> > addcoffee(
      {required String? coffeename,
      required int? price,
      required String? description,
      required String? author,
      required String? image,
      required String? category}) async {
    try {
      int userid = await SharePrefs.readPrefs("userID", "int");

      Map<String, dynamic> coffeedata = {
        "coffeename": coffeename,
        "price": price,
        "description": description,
        "author": author,
        "image": image,
        "category": category,
        "userid": userid
      };

      String jsonData = jsonEncode(coffeedata);

      Uri apiUrl = Uri.parse('$apilink/add_coffee');

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

    static Future< Map<dynamic,dynamic> > updatecoffee(
      {required String? coffeename,
      required int bID,
      required int? price,
      required String? description,
      required String? author,
      required String? image,
      required String? category}) async {
    try {
      int userid = await SharePrefs.readPrefs("userID", "int");

      Map<String, dynamic> coffeedata = {
        "bid":bID,
        "coffeename": coffeename,
        "price": price,
        "description": description,
        "author": author,
        "image": image,
        "category": category,
        "userid": userid
      };

      String jsonData = jsonEncode(coffeedata);

      Uri apiUrl = Uri.parse('$apilink/update_coffee');

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

static Future<bool> deletecoffee({
    required int bid,
  }) async {
    try {
      final apiUrl = Uri.parse('$apilink/delete_coffee/$bid');
      final response = await http.delete(apiUrl);
      
      if (response.statusCode == 200) {
        // Address deleted successfully
        return true;
      } else {
        // Failed to delete address
        return false;
      }
    } catch (error) {
      // Error occurred during the deletion process
      return false;
    }
  }


}

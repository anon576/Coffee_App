import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/app_properties.dart';
import '../components/share_prefs.dart';

class ApiService {
  static Future<Map<dynamic, dynamic>> sendDataToServer({
    required String? email,
  }) async {
    // Convert DateTime objects to ISO 8601 formatted strings

    Map<String, dynamic> userData = {"email": email};

    // Convert the data to JSON
    String jsonData = jsonEncode(userData);

    // Specify the API endpoint URL
    Uri apiUrl = Uri.parse('$apilink/join');

    try {
      http.Response response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);

        if (responseData['userExist']) {
          SharePrefs.storePrefs(
              "userID", responseData['user'][0]['userID'], "int");

          SharePrefs.storePrefs(
              "name", responseData['user'][0]['name'], "string");
          SharePrefs.storePrefs(
              "lastname", responseData['user'][0]['lastname'], "string");
          SharePrefs.storePrefs(
              "mobile", responseData['user'][0]['mobile'], "string");
          SharePrefs.storePrefs(
              "city", responseData['user'][0]['city'], "string");
        }
        Map<dynamic, dynamic> data = {
          "success": true,
          "userExist": responseData['userExist'],
          "otp": responseData['otp']
        };

        return data;
      } else {
        // Error
        print('Failed to send data. Status code: ${response.statusCode}');
        Map<dynamic, dynamic> data = {"success": false};
        return data;
      }
    } catch (error) {
      print('Error sending data: $error');
      Map<dynamic, dynamic> data = {"success": false};
      return data;
    }
  }

  static Future<bool> registerUser({
    required String name,
    required String lastname,
    required String mobileNo,
    required String city,
  }) async {
    Map<String, dynamic> userData = {
      "name": name,
      "lasatname": lastname,
      "mobileno": mobileNo,
      "city": city,
      "email": await SharePrefs.readPrefs("email", "string")
      // Add other fields as needed
    };
    String jsonData = jsonEncode(userData);

    // Specify the API endpoint URL
    Uri apiUrl = Uri.parse('$apilink/register_user');

    try {
      http.Response response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      // Handle the response as needed
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);

        if (responseData['success']) {
          int value = responseData['userID'];
          SharePrefs.storePrefs("userID", value, "int");
          SharePrefs.storePrefs("name", name, "string");
          SharePrefs.storePrefs("lastname", lastname, "string");
          SharePrefs.storePrefs("mobile", mobileNo, "string");
          SharePrefs.storePrefs("city", city, "string");
          return true;
        }
        return false;
      } else {
        // Error
        print('Failed to send data. Status code: ${response.statusCode}');
        // Return a different integer value for error cases
        return false;
      }
    } catch (error) {
      // Handle any errors that occurred during the HTTP request
      print('Error sending data: $error');
      // Return a different integer value for error cases
      return false;
    }
  }

  static Future<bool> updateUser({
    required String name,
    required String lastname,
    required String mobileNo,
    required String city,
  }) async {
    Map<String, dynamic> userData = {
      "name": name,
      "lasatname": lastname,
      "mobileno": mobileNo,
      "city": city,
      "userid": await SharePrefs.readPrefs("userID", "int")
      // Add other fields as needed
    };
    String jsonData = jsonEncode(userData);

    // Specify the API endpoint URL
    Uri apiUrl = Uri.parse('$apilink/update_user');

    try {
      http.Response response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      // Handle the response as needed
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);

        if (responseData['success']) {
          SharePrefs.storePrefs("name", name, "string");
          SharePrefs.storePrefs("lastname", lastname, "string");
          SharePrefs.storePrefs("mobile", mobileNo, "string");
          SharePrefs.storePrefs("city", city, "string");
          return true;
        }
        return false;
      } else {
        // Error
        print('Failed to send data. Status code: ${response.statusCode}');
        // Return a different integer value for error cases
        return false;
      }
    } catch (error) {
      // Handle any errors that occurred during the HTTP request
      print('Error sending data: $error');
      // Return a different integer value for error cases
      return false;
    }
  }

  static Future<bool> addAddress(
      {required String country,
      required String state,
      required String city,
      required int pin,
      required String near}) async {
    Map<String, dynamic> userData = {
      "country": country,
      "city": city,
      "state": state,
      "pin": pin,
      "near": near,
      "userid": await SharePrefs.readPrefs("userID", "int")
      // Add other fields as needed
    };
    String jsonData = jsonEncode(userData);

    // Specify the API endpoint URL
    Uri apiUrl = Uri.parse('$apilink/add_address');

    try {
      http.Response response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      // Handle the response as needed
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);

        if (responseData['success']) {
          return true;
        }
        return false;
      } else {
        // Error
        print('Failed to send data. Status code: ${response.statusCode}');
        // Return a different integer value for error cases
        return false;
      }
    } catch (error) {
      // Handle any errors that occurred during the HTTP request
      print('Error sending data: $error');
      // Return a different integer value for error cases
      return false;
    }
  }

  static Future<List> getAddress() async {
    try {
      int userid = await SharePrefs.readPrefs("userID", "int");
      final response =
          await http.get(Uri.parse('$apilink/get_address/?userid=$userid'));
      if (response.statusCode == 200) {
        Map<dynamic, dynamic> data = jsonDecode(response.body);
        if (data['success']) {
          if (data['address'] == null) {
            print(data['address']);
            return [];
          }
          return data['address'];
        }
        return data["success"];
      } else {
        throw Exception('Failed to load products');
      }
    } catch (eror) {
      print(eror);
      return [];
    }
  }

  static Future<bool> updateAddress(
      {required int aid,
      required String country,
      required String state,
      required String city,
      required int pin,
      required String near}) async {
    Map<String, dynamic> userData = {
      "aid": aid,
      "country": country,
      "city": city,
      "state": state,
      "pin": pin,
      "near": near,
      "userid": await SharePrefs.readPrefs("userID", "int")
      // Add other fields as needed
    };
    String jsonData = jsonEncode(userData);

    // Specify the API endpoint URL
    Uri apiUrl = Uri.parse('$apilink/update_address');

    try {
      http.Response response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      // Handle the response as needed
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);

        if (responseData['success']) {
          return true;
        }
        return false;
      } else {
        // Error
        print('Failed to send data. Status code: ${response.statusCode}');
        // Return a different integer value for error cases
        return false;
      }
    } catch (error) {
      // Handle any errors that occurred during the HTTP request
      print('Error sending data: $error');
      // Return a different integer value for error cases
      return false;
    }
  }

  static Future<bool> deleteAddress({
    required int aid,
  }) async {
    try {
      final apiUrl = Uri.parse('$apilink/delete_address/$aid');
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

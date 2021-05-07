import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;


import 'package:shared_preferences/shared_preferences.dart';

class NetworkHandler {
  var resbody, code,token;
  SharedPreferences sharedPreferences = SharedPreferences.getInstance() as SharedPreferences;

  // Future<String> loginUser() async {
  //   print("future start");
  //   try {
  //     var url =
  //         Uri.parse('https://rocky-brushlands-19286.herokuapp.com/user/login');
  //     var response = await http.post(
  //       url,
  //       body: {
  //         "email": "mohammadnabeeljameel@gmail.com",
  //         "password": "asdsasdfsdf",
  //         "name": "Nabeel",
  //       },
  //     );
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   } catch (e) {
  //     Exception exception;
  //   }
  //   return "Success";
  // }

  Future loginUser(Map<String, String> body) async {
    var url =
        Uri.parse('https://rocky-brushlands-19286.herokuapp.com/user/login');
    var response = await http.post(url, body: body);
    Map output = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }

      print(response.body + response.statusCode.toString());
      token = sharedPreferences.setString("token", output['token']);
      print(token);
      return output['token'];
    }
    {
      print("statusccod is not 200");
      print(response.body);
      return output['error'];
    }
  }
  Future<dynamic> tasks() async {
    var url =
    Uri.parse('https://rocky-brushlands-19286.herokuapp.com/todo/store');
    var response = await http.post(url,
        headers: {'Authorization': 'Bearer $token',},
         );
    Map output = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }

      print(response.body + response.statusCode.toString());
      return output['message'];
    }
    {
      print("statusccod is not 200");
      print(response.body);
      return output['error'];
    }
  }


  Future<dynamic> register(Map<String, String> body) async {
    var url =
        Uri.parse('https://rocky-brushlands-19286.herokuapp.com/user/signup');
    var response = await http.post(url, body: body);
    Map output = convert.jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }

      print(response.body + response.statusCode.toString());
      return output['message'];
    }
    {
      print("statusccod is not 200");
      print(response.body);
      return output['error'];
    }
  }
}

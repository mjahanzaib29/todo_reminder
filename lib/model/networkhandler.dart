import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

import 'package:todo_reminder/Util/sharedprefs.dart';
import 'package:todo_reminder/model/categoryinfo.dart';

class NetworkHandler {
  var resbody, code, token,taskres;
   List taskresponse;
  Map<String, dynamic> map;

  final String currentDate;
  final String work;
  final String reminderTime;
  final String categoryId;

  NetworkHandler(
      {this.currentDate, this.work, this.reminderTime, this.categoryId});

  factory NetworkHandler.fromJson(Map<String, dynamic> json){
    return NetworkHandler(
        currentDate: json['currentDate'],
        work: json['work'],
        reminderTime: json['reminderTime'],
        categoryId: json['categoryId']
    );
  }

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
      token = output['token'];
      await MySharedPreferences.instance.setStringValue("token", output['token']);
      print(MySharedPreferences.instance.getStringValue("token"));
      print(output['token']);
      return output['message'];
    }
    {
      print("statusccod is not 200");
      print(response.body);
      return output['error'];
    }
  }

  Future<dynamic> insertTasks(Map<String, String> body) async {
    var token = await MySharedPreferences.instance.getStringValue("token");
    var url =
    Uri.parse('https://rocky-brushlands-19286.herokuapp.com/todo/store');
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
      body: body
    );
    print("Tasktoken");
    print(await MySharedPreferences.instance.getStringValue("token"));
    Map output = convert.jsonDecode(response.body);
    if(response.statusCode == 200 || response.statusCode == 201){
      if (output['status'] == false) {
        print(output['error']);
        return output['error'];
      }
      print(response.body + response.statusCode.toString());
      return output['message'];
    }

  }
  Future<Welcome> getcategory() async {
    var token = await MySharedPreferences.instance.getStringValue("token");
    var url =
    Uri.parse('https://rocky-brushlands-19286.herokuapp.com/todo/category/list');
    var result = null;
    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      // print("Tasktoken");
      // print(await MySharedPreferences.instance.getStringValue("token"));
      var output = convert.jsonDecode(response.body);
      print(output);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (output['status'] == false) {
        //   print(output['error']);
        //   // return output['error'];
        //   return result;
        // }
        result = Welcome.fromJson(output);
        print("complete output");
        print(output);
        print(result);
        return result;
        // print(response.body + response.statusCode.toString());
        // // return output['message'];
        // return result;
      }
    }
    catch(Exception){
      return result;
    }
    return result;

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

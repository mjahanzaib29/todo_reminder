import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:logger/logger.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var log = Logger();
  var scode;
  final String baseurl = "https://rocky-brushlands-19286.herokuapp.com";
  final String endpoint = "/user/login";
  String data;

  Future<String> getSwdata() async {
    var res = await http.post(Uri.parse(baseurl),
        headers: {"Accept": "application/json;charset=utf-8"});
    setState(() {
      var resbody = json.decode(res.body);
      print('response from db' + resbody.toString());
      debugPrint('debugresponse from db' + resbody.toString());
      log.v('debugresponse from db' + resbody.toString());
      if (resbody != null) {
        data = resbody["status"];
      }
    });
    return "Success";
  }

  // Future<http.Response> fetchNutritionix() async {
  //   var rescode = await http.get(
  //       Uri.parse('https://rocky-brushlands-19286.herokuapp.com/user/login'));
  //   if (rescode.statusCode == 200 || rescode.statusCode == 201) {
  //     print(json.decode(rescode.body));
  //   } else {
  //     print("No response");
  //   }
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json;charset=utf-8",
  //     // "x-app-id": "5bf----",
  //     // "x-app-key": "c3c528f3a0c68-------------",
  //     // "x-remote-user-id": "0",
  //   };
  //   String query =
  //       '{"email" :"mohammadnabeeljameel@gmail.com", "password": "asdsasdfsdf" , "name": "Nabeel" }';
  //
  //   var response = await http.post(
  //       (Uri.parse('https://rocky-brushlands-19286.herokuapp.com/user/login')),
  //       headers: headers,
  //       body: query);
  //
  //   setState(() {
  //     scode = response.statusCode;
  //     print('This is the statuscode: $scode');
  //     Map responseJson = json.decode(response.body);
  //     print(responseJson['token']);
  //   });
  //
  //   //print('This is the API response: $responseJson');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(data == null ? "" : data),
    );
  }
}

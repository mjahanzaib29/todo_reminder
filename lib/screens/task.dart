import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:logger/logger.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'dart:io';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String sometext;
  var log = Logger();
  var scode;
  final String baseurl = "https://rocky-brushlands-19286.herokuapp.com";
  final String endpoint = "/user/login";
  final client = new HttpClient();
  String query =
      '{"email" :"mohammadnabeeljameel@gmail.com", "password": "asdsasdfsdf" , "name": "Nabeel" }';
  String data;
  var resbody, code;

  // Future<String> getSwdata() async {
  //   // final req = await client.getUrl(
  //   //     Uri.parse("https://rocky-brushlands-19286.herokuapp.com/user/login"));
  //   // final rspns = await req.close();
  //   print("future start");
  //   debugPrint("future start");
  //   var res = await http.post(
  //       Uri.parse("https://rocky-brushlands-19286.herokuapp.com/user/login"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: json.encode({
  //         'email': 'mohammadnabeeljameel@gmail.com',
  //         'password': 'asdsasdfsdf',
  //         'name': 'Nabeel'
  //       }));
  //   resbody = json.decode(res.body);
  //   code = res.statusCode;
  //   print('response1from db' + resbody.toString());
  //   debugPrint('debugresponse1 from db' + resbody.toString());
  //   setState(() {
  //     resbody = json.decode(res.body);
  //     code = res.statusCode;
  //     print('response from db' + resbody.toString());
  //     debugPrint('debugresponse from db' + resbody.toString());
  //     log.v('debugresponse from db' + resbody.toString());
  //     if (resbody != null) {
  //       data = resbody["status"];
  //     }
  //   });
  //   return "Success";
  // }

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: new Text(
              // "jjbbbknknk",
          sometext== null ? "button" : sometext,

            ),
            onPressed: () {
          // try {
          //   NetworkHandler().loginUser().then((String result) {
          //     setState(() {
          //       result = sometext;
          //     });
          //   });
          // } catch (e) {
          //   Exception exception;
          // }
            },
          ),
        ],
      ),
    );
  }
}

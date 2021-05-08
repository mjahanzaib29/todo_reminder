import 'package:flutter/material.dart';
import 'package:todo_reminder/Util/sharedprefs.dart';
import 'package:todo_reminder/model/networkhandler.dart';
import 'dart:async';
import 'dart:convert';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Future<NetworkHandler> networkhandler;
  String token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkhandler = NetworkHandler().tasks();
    MySharedPreferences.instance.getStringValue("token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(token==null ? "n token" : token),
          Expanded(
            child:
              ListView.builder(
                itemCount: NetworkHandler().taskresponse == null ? 0 : NetworkHandler().taskresponse.length,
                itemBuilder: (context, index) {
                return Text(NetworkHandler().taskresponse[index]["work"]);
              },)
            // FutureBuilder<NetworkHandler>(
            //     future: networkhandler,
            //     builder: (context, snapshot) {
            //       print(MySharedPreferences.instance.getStringValue("token"));
            //       if (snapshot.hasData) {
            //         return Text(snapshot.data.work);
            //       } else if (snapshot.hasError) {
            //         return (Text("${snapshot.error}"));
            //       }
            //       return CircularProgressIndicator();
            //     }),
          ),
        ],
      ),
    );
  }
}

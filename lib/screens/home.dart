import 'package:flutter/material.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var now = new DateTime.now();
    var formatter = new DateFormat('dd:MM:yyyy');
    String formattedDate = formatter.format(now);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          StringConstants.title,
          style: Pallete.kheading,
        )),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onPressed: () {})
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: Container(
                  height: size.height * .7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today : ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(formattedDate, style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

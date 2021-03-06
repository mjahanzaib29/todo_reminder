import 'package:flutter/material.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:todo_reminder/model/networkhandler.dart';
import 'package:todo_reminder/model/todoinfo.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  NetworkHandler networkHandler = NetworkHandler();
  Future<TodoInfo> _alltasks;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _alltasks = networkHandler.getTodolist();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () {}),
        title: Text(
          StringConstants.title,
          style: TextStyle(
              color: Pallete.bgColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<TodoInfo>(
              future: _alltasks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.todos.length,
                    itemBuilder: (context, index) {
                      var todoreminder = snapshot.data.todos[index];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                BorderSide(color: Colors.grey[300]))),
                        child: Dismissible(
                          background: Container(
                            color: Colors.red,
                          ),
                          key: ValueKey(index),
                          onDismissed: (direction) {
                            setState(() {
                              snapshot.data.todos.removeAt(index);
                            });
                          },
                          child: ListTile(
                            title: Text(todoreminder.work),
                            leading: Text("ID: " + todoreminder.id.toString()),
                            subtitle: Text(
                                "ReminderTime : " + todoreminder.reminderTime.toString()),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}

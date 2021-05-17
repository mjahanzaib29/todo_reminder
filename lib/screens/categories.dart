import 'package:flutter/material.dart';
import 'package:todo_reminder/constant/category_constant.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:todo_reminder/model/categoryinfo.dart';
import 'package:todo_reminder/model/networkhandler.dart';

class Categories_page extends StatefulWidget {
  @override
  _Categories_pageState createState() => _Categories_pageState();
}

class _Categories_pageState extends State<Categories_page> {
  NetworkHandler networkHandler = NetworkHandler();
  CategoryConstant categoryConstant;
  Future<Welcome> _category;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _category = networkHandler.getcategory();
      print(_category);
    });
    Size size = MediaQuery.of(context).size;
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
                child: FutureBuilder<Welcome>(
              future: _category,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.todos.length,
                    // itemCount: allcategories.length,
                    itemBuilder: (context, index) {
                      var cat = snapshot.data.todos[index];
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        key: ValueKey(index),
                        onDismissed: (direction) {
                          setState(() {
                            allcategories.removeAt(index);
                          });
                        },
                        child: ListTile(
                          title: Text(cat.name),
                          leading: Text("ID: " + cat.id.toString()),
                          subtitle:
                              Text("Created: " + cat.createdAt.toString()),
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

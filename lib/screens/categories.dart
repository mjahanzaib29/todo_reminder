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
                    itemCount:  snapshot.data.todos.length,
                    // itemCount: allcategories.length,
                    itemBuilder: (context, index) {
                      var cat = snapshot.data.todos[index];
                      return Dismissible(
                        background: Container(color: Colors.red,),
                        key: ValueKey(index),
                        onDismissed: (direction) {
                          setState(() {
                            allcategories.removeAt(index);
                          });
                        },
                        child: ListTile(
                          title: Text(cat.name),
                          leading: Text("ID: "+cat.id.toString()),
                          subtitle: Text("Created: "+cat.createdAt.toString()),
                        ),
                      );
                      // final cat = allcategories[index];
                      // return Dismissible(
                      //   background: Container(color: Colors.red,),
                      //   key: ValueKey(index),
                      //   onDismissed: (direction) {
                      //     setState(() {
                      //       allcategories.removeAt(index);
                      //     });
                      //   },
                      //   child: ListTile(
                      //     title: Text(allcategories[index].catname),
                      //   ),
                      // );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ))
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(20, 2, 20, 20),
            //     child: Container(
            //       // height: size.height * .73,
            //       width: size.width,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(25),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Pallete.bgColor.withOpacity(0.5),
            //             spreadRadius: 5,
            //             blurRadius: 7,
            //             offset: Offset(0, 3), // changes position of shadow
            //           ),
            //         ],
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 20, vertical: 15),
            //         child: Column(
            //           children: [
            //             ListView.builder(
            //               itemCount: allcategories.length,
            //               itemBuilder: (context, index) {
            //                 final cat = categoryConstant.catname[index];
            //                 return Dismissible(
            //                   key: Key(cat),
            //                   onDismissed: (direction){
            //                     setState(() {
            //                       allcategories.removeAt(index);
            //                     });
            //                   },
            //                   child: ListTile(
            //                     title: Text(allcategories[index].catname),
            //                   ),
            //                 );
            //               },
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

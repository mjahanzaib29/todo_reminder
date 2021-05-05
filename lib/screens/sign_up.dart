import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/screens/sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _rusernameTextEditingController =
  TextEditingController();
  final TextEditingController _remailTextEditingController =
  TextEditingController();
  final TextEditingController _rpasswordTextEditingController =
  TextEditingController();
  final String docId;

  _SignUpState({this.docId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: size.width,
                  height: size.height * .5,
                  decoration: BoxDecoration(
                    color: Pallete.bgColor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(90.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "New Here ?",
                          style: Pallete.kheading,
                        ),
                        Text(
                          "Enter your personal details and start journey with us!",
                          style: Pallete.kpara,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: size.height * .2,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height * .6,
                    width: size.width * .8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Pallete.bgColor,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                    BorderSide(color: Colors.grey[400]))),
                            child: TextField(
                              controller: _rusernameTextEditingController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                labelStyle: Pallete.khint,
                                labelText: "User Name",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                    BorderSide(color: Colors.grey[400]))),
                            child: TextField(
                              controller: _remailTextEditingController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelStyle: Pallete.khint,
                                labelText: "Email",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                    BorderSide(color: Colors.grey[400]))),
                            child: TextField(
                              controller: _rpasswordTextEditingController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                labelStyle: Pallete.khint,
                                labelText: "Password",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            width: size.width,
                            decoration: new BoxDecoration(
                              color: Pallete.bgColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: TextButton(
                              child: new Text(
                                'SIGN UP',
                                style: Pallete.kbtn,
                              ),
                              onPressed: () {
                                _rusernameTextEditingController
                                    .text.isNotEmpty &&
                                    _remailTextEditingController
                                        .text.isNotEmpty &&
                                    _rpasswordTextEditingController
                                        .text.isNotEmpty
                                    ? registerUser()
                                    : showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Fill all fields"),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          InkWell(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Already have an account?",
                                    style: Pallete.khint),
                                TextSpan(
                                    text: "Sign In ", style: Pallete.kpopbtn)
                              ]),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignIn(),
                                  ));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    // StreamBuilder(
    //     stream: FirebaseFirestore.instance
    //         .collection('YOUR COLLECTION NAME')
    //         .doc(docId) //ID OF DOCUMENT
    //         .snapshots(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return new CircularProgressIndicator();
    //       }
    //       var document = snapshot.data;
    //       return new Text(document["name"]);
    //     }
    // );

    // QuerySnapshot querySnapshot ;
    // var id = querySnapshot.docs[].id;
    FirebaseFirestore.instance.collection("users").add({
    "Email": _remailTextEditingController.text.toString(),
    "Password": _rpasswordTextEditingController.text.toString(),
    "User_Name": _rusernameTextEditingController.text.toString(),
    // "Id": FirebaseFirestore.instance.collection("users").doc(docId).id
    });
  }
}

import 'package:flutter/material.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/screens/home_page.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                          "Welcome back!",
                          style: Pallete.kheading,
                        ),
                        Text(
                          "To keep connected with us please login with personal info",
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
                              controller: _emailTextEditingController,
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
                              controller: _passwordTextEditingController,
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
                                'SIGN IN',
                                style: Pallete.kbtn,
                              ),
                              onPressed: () {
                                _emailTextEditingController.text.isNotEmpty &&
                                        _passwordTextEditingController
                                            .text.isNotEmpty
                                    ? loginUser()
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => Homepage(),
                                    //     ))
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
                                    text: "Dont't have an account ?",
                                    style: Pallete.khint),
                                TextSpan(
                                    text: "Sign Up ", style: Pallete.kpopbtn)
                              ]),
                            ),
                            onTap: () {
                              Navigator.pop(context);
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

  void loginUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog();
      },
    );
  }
}

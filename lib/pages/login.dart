import 'package:flutter/material.dart';
import 'package:HagereGebeya/commons/common.dart';
import 'package:HagereGebeya/commons/loading.dart';
import 'package:HagereGebeya/pages/signup.dart';
import 'package:provider/provider.dart';
import 'package:HagereGebeya/provider/user_provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20.0, top: 120, bottom: 120),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[350],
                            blurRadius:
                                20.0, // has the effect of softening the shadow
                          )
                        ],
                      ),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "Sign In",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 25),
                                    )),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      'images/cart.png',
                                      width: 120.0,
//                height: 240.0,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        icon: Icon(Icons.alternate_email),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(pattern);
                                          if (!regex.hasMatch(value))
                                            return 'Please make sure your email address is valid';
                                          else
                                            return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _password,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        icon: Icon(Icons.lock_outline),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "the password has to be at least 6 characters long";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: deepOrange,
                                    elevation: 0.0,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          if (!await user.signIn(
                                              _email.text, _password.text)) {
                                            _key.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text("Sign in Failed"),
                                            ));
                                          }
                                        }
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      child: Text(
                                        "Sign In",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () {},
                                          child: Text(
                                            "Forget Password",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: deepOrange),
                                          ))),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Signup()));
                                          },
                                          child: Text(
                                            "Create an account",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: deepOrange),
                                          ))),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "or sign in with",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MaterialButton(
                                          onPressed: () async {
                                            if (!await user.signInWithGoogle())
                                              _key.currentState
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text("Something is wrong"),
                                              ));
                                          },
                                          child: Image.asset(
                                            "images/ggg.png",
                                            width: 30,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

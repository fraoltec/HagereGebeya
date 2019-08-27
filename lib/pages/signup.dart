import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shopapp_tut/commons/common.dart';
import 'package:shopapp_tut/commons/loading.dart';
import 'package:shopapp_tut/pages/home.dart';
import 'package:shopapp_tut/provider/user_provider.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool loading = false;

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
                        left: 20, right: 20.0, top: 90, bottom: 120),
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
                            //  Padding(
                            //     padding: const EdgeInsets.all(0.0),
                            //     child: Container(
                            //       alignment: Alignment.topCenter,
                            //       child: Text("Register", textAlign: TextAlign.left,style: TextStyle(fontSize: 25),)
                            //     ),
                            //  ),
                            //  Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  'images/cart.png',
                                  width: 120.0,
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
                                    controller: _name,
                                    decoration: InputDecoration(
                                      hintText: "First Name",
                                      icon: Icon(Icons.person_outline),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "The Name cannot be empty";
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
                                      hintText: "Password",
                                      icon: Icon(Icons.lock_outline),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "The Password cannot be empty";
                                      } else if (value.length < 6) {
                                        return "The password has to be atleast 6 characters long";
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
                                color: Colors.deepOrange,
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      if (!await user.signUp(_name.text,
                                          _email.text, _password.text)) {
                                        _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Sign up Failed"),
                                        ));
                                      } else {
                                        _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Sign up Successfull"),
                                        ));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      }
                                    }
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Register",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Already have an account?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: deepOrange),
                                        ))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //  Visibility(
                //    visible: loading ?? true,
                //    child: Center(
                //      child: Container(
                //        alignment: Alignment.center,
                //        color: Colors.white.withOpacity(0.9),
                //        child: CircularProgressIndicator(
                //        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                //        ),
                //      ),
                //    ),
                //  )
              ],
            ),
    );
  }
}

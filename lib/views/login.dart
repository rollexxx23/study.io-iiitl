import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import './start.dart';
import './mainscreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "SignUp");
  }

  navigateToStart() async {
    Navigator.pushReplacementNamed(context, "start");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(25, 23, 32, 1),
        body: SingleChildScrollView(
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
                top: 30,
                left: 30,
                child: GestureDetector(
                  onTap: navigateToStart,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                )),
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Positioned(
                  top: 80,
                  left: 25,
                  child: RichText(
                    text: TextSpan(
                      text: "Welcome Back!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Positioned(
                  top: 130,
                  left: 25,
                  child: RichText(
                    text: TextSpan(
                      text: "Please sign in to continue",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(height: 100),
                Container(
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: new Border.all(
                                color: Colors.blueGrey[500], width: 1.0),
                          ),
                          child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Email';
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:
                                    TextStyle(color: Colors.blueGrey[50]),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.blueGrey,
                                ),
                                focusColor: Colors.white,
                              ),
                              onSaved: (input) => _email = input),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: new Border.all(
                                  color: Colors.blueGrey[500], width: 1.0),
                            ),
                            child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator: (input) {
                                  if (input.length < 8)
                                    return 'Provide Minimum 8 Character';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter Password',
                                  labelStyle:
                                      TextStyle(color: Colors.blueGrey[50]),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                obscureText: true,
                                onSaved: (input) => _password = input),
                          ),
                        ),
                        SizedBox(height: 70),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed: login,
                          child: Text('LogIn',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          color: Color.fromRGBO(84, 104, 255, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        FlatButton(
                            onPressed: navigateToRegister,
                            child: Text(
                              "Signup instead",
                              style: TextStyle(color: Colors.grey),
                            ))
                      ])),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

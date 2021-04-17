import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "mainScreen");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          await _auth.currentUser.updateProfile(displayName: _name);
        }
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

  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
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
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Positioned(
                    top: 80,
                    left: 25,
                    child: RichText(
                      text: TextSpan(
                        text: "Create new account",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Positioned(
                    top: 130,
                    left: 25,
                    child: RichText(
                      text: TextSpan(
                        text: "Please fill in the form to continue",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 82,
                  ),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
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
                                    if (input.isEmpty) return 'Enter Name';
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle:
                                        TextStyle(color: Colors.blueGrey[50]),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  onSaved: (input) => _name = input),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
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
                                    )),
                                onSaved: (input) => _email = input),
                          ),
                          SizedBox(
                            height: 12,
                          ),
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
                                  if (input.length < 6)
                                    return 'Provide Minimum 6 Character';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle:
                                      TextStyle(color: Colors.blueGrey[50]),
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.blueGrey),
                                ),
                                obscureText: true,
                                onSaved: (input) => _password = input),
                          ),
                          SizedBox(height: 70),
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                            onPressed: signUp,
                            child: Text('SignUp',
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
                            onPressed: navigateToLogin,
                            child: Text("Login instead",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          )),
    );
  }
}

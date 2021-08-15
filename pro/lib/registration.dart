// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pro/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool visible = false;
  var email1 = TextEditingController();
  var password1 = TextEditingController();
  final confirmpassword1 = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool v = false;
  bool v1 = false;
  Future senddata() async {
    setState(() {
      visible = true;
    });
    String email = email1.text;
    String password = password1.text;
    var data = {'email': email, 'password': password};
    var url = Uri.parse(
        'https://motherless-admiralt.000webhostapp.com/registration.php');
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future senddata2() async {
    setState(() {
      visible = true;
    });
    String email = email1.text;
    String password = password1.text;
    var data = {'email': email, 'password': password};
    var url = Uri.parse(
        'https://motherless-admiralt.000webhostapp.com/registration2.php');
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  child: Image.asset('assets/images/logo.jpg'),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: email1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      email1 = value as TextEditingController;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: password1,
                    keyboardType: TextInputType.text,
                    obscureText: !v1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon:
                            Icon(v1 ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            v1 = !v1;
                          });
                        },
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&~]).{6,}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid password which contains: \n Minimum 1 upper case \n Minimum 1 lower case \n Minimum 1 Numeric Number \n Minimum 1 Special Character \n Common Allow Character (!@#\$&*~) \n Password length should be minimum 6 characters';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      password1 = value as TextEditingController;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: confirmpassword1,
                    obscureText: !v,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(v ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            v = !v;
                          });
                        },
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please re-enter password';
                      }
                      print(password1.text);
                      print(confirmpassword1.text);
                      if (password1.text != confirmpassword1.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 170,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.brown,
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            senddata();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => MyApp()));
                          } else {
                            print("UnSuccessfull");
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.brown, width: 2)),
                        textColor: Colors.white,
                        child: Text(
                          "Sign Up As Host",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.brown,
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            senddata2();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => MyApp()));
                          } else {
                            print("UnSuccessfull");
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.brown, width: 2)),
                        textColor: Colors.white,
                        child: Text(
                          "Sign Up As Guard",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: visible,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: CircularProgressIndicator())),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

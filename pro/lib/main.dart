//@dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pro/registration.dart';
import 'package:pro/scan.dart';
import 'profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Splash2(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class Splash2 extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<Splash2> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginDemo())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Image.asset(
      'assets/images/splash.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    )));
  }
}

class _LoginDemoState extends State<LoginDemo> {
  bool visible = false;
  bool v1 = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future userLogin() async {
    setState(() {
      visible = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    var url =
        Uri.parse('https://motherless-admiralt.000webhostapp.com/login.php');

    var data = {'email': email, 'password': password};
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);

    if (message == 'Login Matched') {
      setState(() {
        visible = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp2(email: email.toString())));
    } else {
      setState(() {
        visible = false;
      });
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
  }

  Future userLogin2() async {
    setState(() {
      visible = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    var url =
        Uri.parse('https://motherless-admiralt.000webhostapp.com/login2.php');

    var data = {'email': email, 'password': password};
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);

    if (message == 'Login Matched') {
      setState(() {
        visible = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ScanPage()));
    } else {
      setState(() {
        visible = false;
      });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/logo.jpg')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@xyz.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwordController,
                obscureText: !v1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password',
                  suffixIcon: IconButton(
                    icon: Icon(v1 ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        v1 = !v1;
                      });
                    },
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.brown, fontSize: 15),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 160,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.brown,
                    onPressed: () {
                      userLogin();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.brown, width: 2)),
                    textColor: Colors.white,
                    child: Text(
                      "Login As Host",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  width: 165,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.brown,
                    onPressed: () {
                      userLogin2();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.brown, width: 2)),
                    textColor: Colors.white,
                    child: Text(
                      "Login As Guard",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              width: 250,
              margin: EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignUpPage()));
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Visibility(
                visible: visible,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator())),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}

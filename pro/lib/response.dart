//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pro/scan.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'profile.dart';

class Response extends StatefulWidget {
  var result;
  String guest;
  Response({Key key, this.result, this.guest}) : super(key: key);
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
    );
  }

  @override
  _ResponseState createState() => _ResponseState();
}

class _ResponseState extends State<Response> {
  bool circular = true;
  String _imageFile;
  void initState() {
    super.initState();
    fetch();
  }

  Future delete() async {
    String guest = '${widget.guest}';
    var email = '${widget.result[0]['email']}';
    var url2 =
        Uri.parse('https://motherless-admiralt.000webhostapp.com/delete.php');

    var data2 = {'email': email, 'guest': guest};
    print(data2);
    print("ok");
    var response = await http.post(url2, body: json.encode(data2));
    if (response.statusCode == 200) {
      print("ok");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ScanPage()));
    }
  }

  var result2;
  void fetch() async {
    String guest = '${widget.guest}';
    var email = '${widget.result[0]['email']}';
    var url2 =
        Uri.parse('https://motherless-admiralt.000webhostapp.com/status.php');

    var data2 = {'email': email, 'guest': guest};
    print(data2);
    var response = await http.post(url2, body: json.encode(data2));

    if (response.statusCode == 200) {
      setState(() {
        result2 = json.decode(response.body);
        if (result2[0]['Status'] == 'Pending') {
          _imageFile = "assets/images/B.png";
        } else if (result2[0]['Status'] == 'Accepted') {
          _imageFile = "assets/images/A.png";
        } else if (result2[0]['Status'] == 'Rejected') {
          _imageFile = "assets/images/d.png";
        }
        circular = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = '${widget.result[0]['photo']}';

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Request"),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => super.widget));
                },
                icon: Icon(Icons.refresh, color: Colors.white))
          ],
        ),
        body: circular
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                ),
                Center(
                    child: Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                  ),
                  CircleAvatar(
                    radius: 130.0,
                    backgroundImage: NetworkImage(
                        'https://motherless-admiralt.000webhostapp.com/$name'),
                  ),
                ])),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0, bottom: 0),
                    child: Text(
                      '${widget.result[0]['fname']}' +
                          " " +
                          '${widget.result[0]['lname']}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0, bottom: 0),
                    child: Text(
                      "Mobile Number: " + '${widget.result[0]['mobile']}',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0, bottom: 0),
                    child: Text(
                      "Property Number: " + '${widget.result[0]['property']}',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0, bottom: 0),
                    child: Container(
                      height: 150,
                      width: 250,
                      child: new Image.asset(
                        _imageFile,
                        fit: BoxFit.fill,
                      ),
                    )),
                Container(
                  height: 50,
                  width: 150,
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10, bottom: 15),
                  decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      delete();
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 130,
                ),
              ])));
  }
}

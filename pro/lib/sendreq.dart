//@dart=2.9
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pro/response.dart';
import 'package:pro/scan.dart';
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

class Send extends StatefulWidget {
  String qrData;
  Send({Key key, this.qrData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
    );
  }

  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<Send> {
  GlobalKey globalKey = new GlobalKey();
  String fname, lname, mobile, property;
  TextEditingController name = TextEditingController();
  Future profile() async {
    var url = Uri.parse(
        'https://motherless-admiralt.000webhostapp.com/profiledisplay.php');
    var data = {
      'fname': fname,
      'lname': lname,
      'mobile': mobile,
      'property': property,
    };
    var result;
    var response = await http.post(url, body: json.encode(data));
    if (response.statusCode == 200) {
      print("ok");
      result = json.decode(response.body);
      if (result == 'QR Code Expired') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(result),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScanPage()));
                  },
                ),
              ],
            );
          },
        );
      } else {
        var email = result[0]['email'];
        print(result[0]['photo']);
        var guest = name.text;
        var status = 'Pending';
        var url2 = Uri.parse(
            'https://motherless-admiralt.000webhostapp.com/table.php');

        var data2 = {'email': email, 'guest': guest, 'status': status};
        print(data2);
        var response = await http.post(url2, body: json.encode(data2));
        if (response.statusCode == 200) {
          print("ok");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Response(result: result, guest: guest.toString()),
              ));
        }
      }
    }
  }

  Widget build(BuildContext context) {
    String qrData = '${widget.qrData}';
    print('${widget.qrData}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 60.0, bottom: 5),
            ),
            RepaintBoundary(
              key: globalKey,
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: QrImage(
                    size: 300,
                    data: qrData,
                  ),
                ),
              ),
            ),
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      height: 53,
                      width: 250,
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10, bottom: 15),
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(20)),
                      child: FlatButton(
                        onPressed: () {
                          var dataSp = qrData.split('\n');
                          print(dataSp);
                          Map<String, String> mapData = Map();
                          dataSp.forEach((element) =>
                              mapData[element.split(':')[0]] =
                                  element.split(':')[1]);
                          fname = (mapData['First Name']);
                          lname = (mapData['Last Name']);
                          mobile = (mapData['Mobile']);
                          property = (mapData['Property No']);
                          fname = fname.substring(1);
                          lname = lname.substring(1);
                          mobile = mobile.substring(1);
                          property = property.substring(1);

                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: Text('Enter Name'),
                                    content: TextField(
                                      controller: name,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')),
                                      FlatButton(
                                          onPressed: () {
                                            String a = name.text;
                                            print(a);
                                            profile();
                                            Navigator.pop(context);
                                          },
                                          child: Text('Ok'))
                                    ]);
                              });
                        },
                        child: Text(
                          "Send Request",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

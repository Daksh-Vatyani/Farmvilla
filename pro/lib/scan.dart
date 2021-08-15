//@dart=2.9
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:pro/pendingreq.dart';
import 'package:pro/registration.dart';
import 'package:pro/sendreq.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => List3()));
              },
              icon: Icon(Icons.pending_actions_sharp, color: Colors.white))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              color: Colors.brown,
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                String codeSanner = await BarcodeScanner.scan();
                setState(() {
                  qrCodeResult = codeSanner;
                });
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text(
                        "Owner Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      content: new Text(qrCodeResult),
                      actions: <Widget>[
                        FlatButton(
                          child: new Text("OK"),
                          onPressed: () {
                            String qrData;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Send(
                                          qrData: qrCodeResult.toString(),
                                        )));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.brown, width: 2)),
              textColor: Colors.white,
              child: Text("Open Scanner"),
            )
          ],
        ),
      ),
    );
  }
}

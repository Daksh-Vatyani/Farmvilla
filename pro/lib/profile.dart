// @dart=2.9
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pro/list.dart';
import 'package:pro/profiledisplay.dart';

class MyApp2 extends StatefulWidget {
  String email;
  MyApp2({Key key, this.email}) : super(key: key);
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
  _ProfileDemoState createState() => _ProfileDemoState();
}

class _ProfileDemoState extends State<MyApp2> {
  File _imageFile;
  String status = '';
  String error = 'Error';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController fname1 = TextEditingController();
  TextEditingController lname1 = TextEditingController();
  TextEditingController mobile1 = TextEditingController();
  TextEditingController property1 = TextEditingController();

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  @override
  bool visible = false;
  Future profile(String fileName, String base64Image) async {
    setState(() {
      visible = true;
    });
    String email1 = '${widget.email}'.toString();
    String fname = fname1.text;
    String lname = lname1.text;
    String mobile = mobile1.text;
    String property = property1.text;

    var url = Uri.parse('https://192.168.0.187/profile.php');
    var data = {
      "image": base64Image,
      "name": fileName,
      'email': email1,
      'fname': fname,
      'lname': lname,
      'mobile': mobile,
      'property': property,
    };

    var response = await http.post(
        'https://motherless-admiralt.000webhostapp.com/profile.php',
        body: {
          "image": base64Image,
          "name": fileName,
          'email': email1,
          'fname': fname,
          'lname': lname,
          'mobile': mobile,
          'property': property,
        });
    if (response.statusCode == 200) {
      print("ok");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileDisplay(email: email1.toString())));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            List2(email: '${widget.email}'.toString())));
              },
              icon: Icon(Icons.person_add_alt_1_sharp, color: Colors.white))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
              ),
              Center(
                  child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: (_imageFile == null)
                        ? AssetImage("assets/images/profile.png")
                        : FileImage(File(_imageFile.path)),
                  ),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()),
                        );
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.teal,
                        size: 28.0,
                      ),
                    ),
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 0),
                child: TextFormField(
                  controller: fname1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter First Name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Please a valid name';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    fname1 = value as TextEditingController;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: lname1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter Last Name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Please a valid name';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    lname1 = value as TextEditingController;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: mobile1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile Number',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter Mobile Number';
                    }
                    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                        .hasMatch(value)) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    mobile1 = value as TextEditingController;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextFormField(
                  controller: property1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Property Number',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter Property No.';
                    }
                    if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                      return 'Please a valid property number';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    property1 = value as TextEditingController;
                  },
                ),
              ),
              Container(
                height: 55,
                width: 250,
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    if (_imageFile == null) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Please select photo"),
                              actions: <Widget>[
                                FlatButton(
                                  child: new Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                    if (_formkey.currentState.validate()) {
                      String base64Image =
                          base64Encode(_imageFile.readAsBytesSync());
                      File tmpFile = _imageFile;
                      String fileName = tmpFile.path.split('/').last;
                      profile(fileName, base64Image);
                    } else {
                      print("UnSuccessfull");
                    }
                  },
                  child: Text(
                    'Create QR Code',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
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
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    var pickedFile = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
    setStatus('');
  }
}

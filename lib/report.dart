import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalproject/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen>{

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Reports');
  }

  final User? user = Auth().currentUser;
  final reportController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed:signOut,
      style: ElevatedButton.styleFrom(
        primary: Colors.lightBlue[900],
        onPrimary: Colors.lightBlue[50],
      ),
      child: Icon(
        Icons.cancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          title: Text(
            "WheelWatch",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          backgroundColor: Colors.lightBlue[900],
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                  children: <Widget>[
                    Container(
                      width: 500,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.cyan[800],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    ),
          
                    Positioned(
                      child: Container(
                          margin: EdgeInsets.only(top: 35, left: 35, right: 35),
                          child: Center(
                              child: Text(
                                  "NEW REPORT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25,
                                    letterSpacing: 5,
                                  )
                              )
                          )
                      ),
                    ),
                  ]
              ),
          
              Stack(
                  children: <Widget>[
                    Container(
                      width: 500,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.cyan[800],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin:  EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    ),
                    Positioned(
                      bottom: 50,
                      right: 46,
                      child: Container(
                        child: ElevatedButton(
                          onPressed:() {},
                          child: Text("Upload Image or Take Photo",
                              style: TextStyle(fontSize: 20)
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue[50],
                            onPrimary: Colors.cyan[800],
                          ),
                        ) ,
                      ),
                    )
                  ]
              ),
          
              Container(
                  margin: EdgeInsets.only(top: 30, left: 35, right: 35),
                  child: Center(
                      child: TextField(
                        controller: reportController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Report Subject',
                        ),
                      )
                  )
              ),
          
              Container(
                  margin: EdgeInsets.only(top: 15, left: 35, right: 35),
                  child: Center(
                      child: TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Location',
                        ),
                      )
                  )
              ),
          
              Container(
                  margin: EdgeInsets.only(top: 15, left: 35, right: 35),
                  child: Center(
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Description',
                        ),
                      )
                  )
              ),
          
              Stack(
                  children: <Widget>[
                    Container(
                      width: 260,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.cyan[800],
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      margin:  EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 5),
                    ),
                    Positioned(
                      top: 35,
                      bottom: 10,
                      right: 35,
                      child: Container(
                        width: 250.0,
                        child: ElevatedButton(
                          onPressed:() {
                            Map<String, dynamic> reports = {
                              'report':reportController.text,
                              'location':locationController.text,
                              'description':descriptionController.text,
                              'isFavorite': false,
                            };
          
                            dbRef.push().set(reports);
                          },
                          child: Text("Upload Report",
                              style: TextStyle(fontSize: 20)
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue[50],
                            onPrimary: Colors.cyan[800],
                          ),
                        ) ,
                      ),
                    )
                  ]
              ),
          
              Row(
                children: <Widget>[
                  Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 50, bottom: 15, top: 15),
                          child: Center(
                            child: ElevatedButton(
                              onPressed:()
                              {
                                Navigator.pushReplacementNamed(context, "/");
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue[900],
                                onPrimary: Colors.lightBlue[50],
                              ),
                              child: Icon(
                                Icons.home,
                              ),
                            ) ,
                          ),
                        ),
          
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 15, right: 160, left: 160),
                          child: Center(
                            child: ElevatedButton(
                              onPressed:null,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue[900],
                                onPrimary: Colors.lightBlue[50],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                              ),
                            ) ,
                          ),
                        ),
          
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 270, bottom: 15),child: Center(
                          child: Center(
                            child: ElevatedButton(
                              onPressed:()
                              {
                                Navigator.pushReplacementNamed(context, "/profile");
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue[900],
                                onPrimary: Colors.lightBlue[50],
                              ),
                              child: Icon(
                                Icons.person,
                              ),
                            ) ,
                          ),
                        ),
                        ),
          
                      ]
                  )
                ],
              )
          
            ],
          ),
        )


    );
  }
}
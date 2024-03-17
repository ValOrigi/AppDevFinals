import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalproject/auth.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final User? user = Auth().currentUser;

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

        body: Column(
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
                                "PROFILE",
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
                    height: 175,
                    decoration: BoxDecoration(
                      color: Colors.cyan[800],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin:  EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 150),
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 100.0,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 80, left: 105),
                      child: Text(
                        "Jerry Khogh",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 36,
                        ),
                      ),

                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 119,
                    child: Container(
                      width: 150.0,
                      height: 25.0,
                      child: ElevatedButton(
                        onPressed:() {},
                        child: Text("Edit Profile",
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

            Stack(
                children: <Widget>[
                  Container(
                    width: 500,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.cyan[800],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin:  EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  Positioned(
                    child: Container(
                        margin: EdgeInsets.only(top: 20, left: 35, right: 35),
                        child: Center(
                            child: Text(
                                "I'm Jerry and this is my profile.\nMale 25",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontSize: 20,
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
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.cyan[800],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin:  EdgeInsets.only (left: 30, right: 30),
                  ),
                  Positioned(
                    child: Container(
                        margin: EdgeInsets.only(top: 10, left: 35, right: 35),
                        child: Center(
                            child: Text(
                                "Posts",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontSize: 20,
                                )
                            )
                        )
                    ),
                  ),
                ]
            ),

            Row(
              children: <Widget>[
                Stack(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 175,
                        decoration: BoxDecoration(
                          color: Colors.cyan[800],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        margin:  EdgeInsets.only (top:10, left: 30, right: 30),
                      ),

                      Container(
                        width: 100,
                        height: 175,
                        decoration: BoxDecoration(
                          color: Colors.cyan[800],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        margin:  EdgeInsets.only (top:10, left: 146),
                      ),

                      Container(
                        width: 100,
                        height: 175,
                        decoration: BoxDecoration(
                          color: Colors.cyan[800],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        margin:  EdgeInsets.only (top:10, left: 262, right: 30),
                      ),

                    ]
                )
              ],
            ),

            Row(
              children: <Widget>[
                Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 50, top: 15, bottom: 15),
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
                        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 160),
                        child: Center(
                          child: ElevatedButton(
                            onPressed:()
                            {
                              Navigator.pushReplacementNamed(context, "/report");
                            },
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
                        margin: EdgeInsets.only(left: 270, top: 15, bottom: 15),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: null,
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

                    ]
                )
              ],
            )

          ],
        )


    );
  }
}
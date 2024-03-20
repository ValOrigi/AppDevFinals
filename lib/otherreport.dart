import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:finalproject/auth.dart';

class OtherReportScreen extends StatefulWidget {
  const OtherReportScreen({Key? key}) : super(key: key);

  @override
  State<OtherReportScreen> createState() => _HomePage();
}

class _HomePage extends State<OtherReportScreen> {

  final User? user = Auth().currentUser;
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Reports');

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
        primary: Colors.red[900],
        onPrimary: Colors.lightBlue[50],
      ),
      child: Icon(
        Icons.cancel,
      ),
    );
  }

  Query dbRef = FirebaseDatabase.instance.ref().child('OtherReports');

  Widget listItem({required Map report}) {
    return Container(
        margin: const EdgeInsets.only(left:35, right: 35, bottom: 20),
        padding: const EdgeInsets.all(10),
        height: 225,
        decoration: BoxDecoration(
          color: Colors.cyan[800],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report['person'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            Text(
              report['report'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            Text(
              report['location'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            Text(
              report['description'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    reference.child(report['key']).remove();
                  },
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() => report['isFavorite'] = !report['isFavorite']);
                        },
                        icon: report['isFavorite']
                            ? Icon(Icons.check, color: Colors.white, size: 25) : Icon(Icons.timer, color: Colors.grey, size: 25),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
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
        drawer: Drawer(
          backgroundColor: Colors.lightBlue[50],
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.cyan[800],
                ),
                child: Text(
                    'WheelWatch Application',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                      letterSpacing: 1,
                    )
                ),
              ),
              ListTile(
                title: const Text(
                    'Home',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                      letterSpacing: 1,
                    )
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
              ),
              ListTile(
                title: const Text(
                    'Other Reports',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                      letterSpacing: 1,
                    )
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/otherReport");
                },
              ),
              ListTile(
                title: const Text(
                    'Report',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                      letterSpacing: 1,
                    )
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/report");
                },
              ),
              ListTile(
                title: const Text(
                    'Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                      letterSpacing: 1,
                    )
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/profile");
                },
              ),
            ],
          ),
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
                                  "OTHER REPORTS",
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

              Container(
                  height: 500,
                  child: Center(
                    child: FirebaseAnimatedList(
                      query: dbRef,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                        Map report = snapshot.value as Map;
                        report['key'] = snapshot.key;

                        return listItem(report: report);
                      },
                    ),
                  )
              ),

              Row(
                children: <Widget>[
                  Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 50, bottom: 15),
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
                          margin: EdgeInsets.only(top: 20, right: 160, left: 160, bottom: 15),
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
                          margin: EdgeInsets.only(top: 20, left: 270, bottom: 35),
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

                      ]
                  )
                ],
              ),

            ],
          ),
        )
    );
  }

}

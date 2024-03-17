import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:finalproject/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

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

  Query dbRef = FirebaseDatabase.instance.ref().child('Reports');

  Widget listItem({required Map report}) {
    return Container(
      margin: const EdgeInsets.only(left:35, right: 35, bottom: 20),
      padding: const EdgeInsets.all(10),
      height: 170,
      color:Colors.cyan[800],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    Icon(
                      Icons.delete_forever,
                      color: Colors.red[800],
                      size: 25,
                    )
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
                                  "MY REPORTS",
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _signOutButton()
                                ],
                              )
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

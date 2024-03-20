import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalproject/auth.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try{
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text (errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
        isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'LOGIN' : 'REGISTER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 5,
          )
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.cyan[800],
        onPrimary: Colors.cyan[800],
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead',
        style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.cyan[900],
        fontSize: 15,
      )),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
                children: <Widget>[
                  Container(
                    width: 500,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.cyan[800],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 100),
                  ),
        
                  Positioned(
                    child: Container(
                        margin: EdgeInsets.only(top: 110, left: 35, right: 35),
                        child: Center(
                            child: Text(
                                "WHEELWATCH\nby Joshua M. Reyna",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 25,
                                  letterSpacing: 4,
                                ),
                            )
                        )
                    ),
                  ),
                ]
            ),
        
            Container(
              height: 450,
              width: 500,
              padding: const EdgeInsets.only(left: 25, right: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _entryField('email', _controllerEmail),
                  _entryField('password', _controllerPassword),
                  _errorMessage(),
                  _submitButton(),
                  _loginOrRegisterButton(),
                ],
        
              )
            ),
          ],
        ),
      )
    );
  }
}
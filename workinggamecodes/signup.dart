
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _sucess;
  late String _userEmail;

  void _register() async {
    final User? user = (
      await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
    ) .user;

    if(user !=null) {
      setState(() {
        _sucess = 2 as bool;
        _userEmail = user.email!;
      });
    } else {
      setState(() {
        _sucess = 3 as bool;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Container(
          child:Stack(
            children: <Widget> [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: Text("RegisterPage",
                style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold
                )
                ),
              )
            ],
          )
          ),
                    Container(
            padding: EdgeInsets.only(top: 35, left: 20, right: 30),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'EMAIL-ID',
                    labelStyle: TextStyle(
                      fontFamily: 'Ewert',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.blue
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                      TextField(
                        controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                      fontFamily: 'Ewert',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.blue
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 5.0,),

                SizedBox(height: 40,),
                Container(
                  height: 40,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.red,
                    color: Colors.blue,
                    elevation: 7,
                    child: GestureDetector(
                      onTap: () async{
                        _register();
                      },
                      child: Center(
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ewert',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    InkWell(
                      onTap: () { Navigator.of(context).pop();
                      },
                      child: Text(
                        'GOBACK',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ]
      ),
    );
  }

}
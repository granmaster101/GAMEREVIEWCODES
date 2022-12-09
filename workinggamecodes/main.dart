import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Signup.dart';
import 'firebase_options.dart';
import 'package:flutter/src/widgets/sliver.dart';
import 'package:flutter/src/cupertino/text_theme.dart';
import 'package:http/http.dart';
import 'package:loginandsignup/views/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material/material.dart';
import 'package:responsive_layout_builder/responsive_layout_builder.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MaterialApp(
    home:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _sucess = 1;
  String _userEmail ="";

  void _signIn() async {
    final User? user = (await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)).user;
    
    if (user !=null) {
      setState(() {
        _sucess = 2;
        _userEmail = user.email!;
      });

  } else{
    setState(() {
      _sucess = 3;
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
          child:Stack(
            children: <Widget> [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: Text("Welcome to the world of reviewing games",
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
                  obscureText: true,
                ),
                SizedBox(height: 5.0,),
                Container(
                  alignment: Alignment(1,0),
                  padding: EdgeInsets.only(top: 15, left: 20),
                  child: InkWell(
                    child: Text(
                      'FORGOT PASSWORD',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ewert',
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _sucess == 1
                        ? ''
                        : (
                      _sucess == 2
                      ? 'Successfully signed in' + _userEmail
                      :'Sign in failed'),
                      style: TextStyle(color: Colors.red),
                    )
                  ),
                SizedBox(height: 40,),
                Container(
                  height: 40,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.red,
                    color: Colors.blue,
                    elevation: 7,
                    child: GestureDetector(
                      onTap: () async {
                        _signIn();
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
                          return Homescreen();
                         }),);
                      },
                      child: Center(
                        child: Text(
                          'LOGIN',
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
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Text(
                        'REGISTER',
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
        ], 
      )
    );

  }
  
}



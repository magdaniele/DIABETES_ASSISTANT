// ignore_for_file: prefer_const_constructors, unnecessary_new, deprecated_member_use, use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:diabetes_assistant/pages/signUp.dart';
import 'package:diabetes_assistant/privatePages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSubmitted: (value) {
        emailController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final passwordField = TextField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      onSubmitted: (value) {
        passwordController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF84BDCE),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/diabetesFree.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registration()));
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                color: Color(0xFF84BDCE),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      )),
    );
  }
}

class LoginGet extends StatelessWidget {
  String url = "";
  Future<String> res() async{
    var respuesta = await http.get(Uri.parse(url));

    print(respuesta.body);
    return respuesta.body;
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: RaisedButton(child: Text(""), onPressed: (){res();},),);
  }
} 

class LoginPost extends StatelessWidget {
  String url = "";
  Future<String> userLogin() async{
    var respuesta = await http.post(Uri.parse(url),body: {"username":"name","password":"*****"});

    print(respuesta.body);
    return respuesta.body;
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: RaisedButton(child: Text(""), onPressed: (){userLogin();},),);
  }
} 

// ignore_for_file: prefer_const_constructors, unnecessary_new, file_names, import_of_legacy_library_into_null_safe, unnecessary_null_comparison
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_assistant/model/user.dart';
import 'package:diabetes_assistant/privatePages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  static final _formKey = GlobalKey<FormState>();

  final firstNameController = new TextEditingController();
  final secondNameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();
  final birthdayController = new TextEditingController();
  String gender = '';
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}');
        if (value!.isEmpty) {
          return ("Nombre no puede estar vacío.");
        }
        if (!regex.hasMatch(value)) {
          return ("Por favor introduzca un Name(Min. 3 Character");
        }
        return null;
      },
      onSaved: (value) {
        firstNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Nombre',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Apellido no puede estar vacío.");
        }
        return null;
      },
      onSaved: (value) {
        secondNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Apellido',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Por favor introduzca su e-mail.");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@.[a-z]").hasMatch(value)) {
          return ("Por favor introduzca un e-mail válido.");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'E-mail',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}');
        if (value!.isEmpty) {
          return ('Por favor introduzca su contraseña.');
        }
        if (!regex.hasMatch(value)) {
          return ("Por favor introduzca una contraseña válida (mínimo 6 caracteres).");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordController,
      obscureText: true,
      validator: (value) {
        if (passwordController.text != confirmPasswordController.text) {
          return ('La contraseña no concuerda.');
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Confirmar contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final birthdayField = TextFormField(
      autofocus: false,
      controller: birthdayController,
      readOnly: true,
      obscureText: false,
      validator: (value) {
        if (birthdayController.text == '') {
          return ('Por favor introduzca su fecha de nacimiento.');
        }
        return null;
      },
      onSaved: (value) {
        birthdayController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Fecha de nacimiento',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2023));
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          birthdayController.text = formattedDate; //
        } else {
          birthdayController.text = '';
          //print("Date is not selected");
        }
      },
    );
    final genderField = Column(children: [
      ListTile(
        title: Text("Hombre"),
        leading: Radio(
            value: "Hombre",
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            }),
      ),
      ListTile(
        title: Text("Mujer"),
        leading: Radio(
            value: "Mujer",
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            }),
      )
    ]);

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF84BDCE),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (gender != '') {
            signUp(emailController.text, passwordController.text);
          } else {
            Fluttertoast.showToast(msg: 'Seleccione su género.');
          }
        },
        child: Text(
          'Registrar',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF84BDCE)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
                    firstNameField,
                    SizedBox(height: 20),
                    secondNameField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    birthdayField,
                    SizedBox(height: 30),
                    Text(
                      'Select your gender: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF84BDCE),
                      ),
                    ),
                    genderField,
                    SizedBox(height: 45),
                    signUpButton,
                    SizedBox(height: 15),
                  ]),
            ),
          ),
        ),
      )),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestrore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestrore() async {
    //calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel(
        uid: user!.uid,
        firstName: firstNameController.text,
        secondName: secondNameController.text,
        email: user.email,
        imagePath: '',
        about: '',
        birthday: birthdayController.text,
        height: 0,
        weight: 0,
        gender: gender,
        isDarkMode: false);

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Cuenta creada.');

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}

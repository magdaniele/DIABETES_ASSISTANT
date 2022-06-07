// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, unnecessary_null_comparison, file_names, unused_local_variable
import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:diabetes_assistant/widget/buildAppBar.dart';
import 'package:diabetes_assistant/widget/profileWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final _formKey = GlobalKey<FormState>();
  PlatformFile? pickedFile;
  late UserModel user;
  late TextEditingController firstNameController =
      TextEditingController(text: user.firstName);
  late TextEditingController secondNameController =
      TextEditingController(text: user.secondName);
  late TextEditingController aboutController =
      TextEditingController(text: user.about);
  late TextEditingController weightController =
      TextEditingController(text: user.weight.toString());
  late TextEditingController heightController =
      TextEditingController(text: user.height.toString());
  String urlImage = '';
  bool _load = false;
  UploadTask? uploadTask;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserPreferences>(context, listen: false).user!;

    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Nombre no puede estar vacío.");
        }
        if (!RegExp(r'^.{3,}').hasMatch(value)) {
          return ("Por favor introduzca un nombre válido (mínimo 3 caracteres).");
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

    final heightField = TextFormField(
      autofocus: false,
      controller: heightController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Por favor introduzca su altura.");
        }
        if (!RegExp("^[0-9]+(.[0-9]+)?").hasMatch(value)) {
          return ("Por favor introduzca una altura válida.");
        }
        return null;
      },
      onSaved: (value) {
        heightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.straighten),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Altura',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final weightField = TextFormField(
      autofocus: false,
      controller: weightController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Por favor introduzca su peso.");
        }
        if (!RegExp("^[0-9]+(.[0-9]+)?").hasMatch(value)) {
          return ("Por favor introduzca un peso válido.");
        }
        return null;
      },
      onSaved: (value) {
        weightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.scale),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Peso',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final aboutField = TextFormField(
      autofocus: false,
      controller: aboutController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        aboutController.text = value!;
      },
      textInputAction: TextInputAction.next,
      maxLines: 5,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Descripción',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final updateUser = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF84BDCE),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Provider.of<UserPreferences>(context, listen: false).updateUser({
            "firstName": firstNameController.text,
            "secondName": secondNameController.text,
            "about": aboutController.text,
            "weight": double.parse(weightController.text),
            "height": double.parse(heightController.text),
            "imagePath": urlImage,
          });
          Navigator.of(context).pop();
        },
        child: Text(
          'Guardar datos',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: Padding(
            padding: const EdgeInsets.only(top: 36.0, left: 36.0, right: 36.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 24),
                      imageProfile(user.imagePath! == ''
                          ? 'assets/defaultProfileImg.jpg'
                          : user.imagePath!),
                      const SizedBox(height: 24),
                      firstNameField,
                      const SizedBox(height: 24),
                      secondNameField,
                      const SizedBox(height: 24),
                      aboutField,
                      const SizedBox(height: 24),
                      weightField,
                      const SizedBox(height: 24),
                      heightField,
                      const SizedBox(height: 24),
                      updateUser,
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Subir foto de perfil',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                  onPressed: selectPicture,
                  icon: Icon(Icons.camera),
                  label: Text('Camara')),
              ElevatedButton.icon(
                  onPressed: uploadPicture,
                  icon: Icon(Icons.image),
                  label: Text('Galería')),
            ],
          )
        ],
      ),
    );
  }

  Future selectPicture() async {}

  Future uploadPicture() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
      _load = true;
    });
    final path = 'files/${pickedFile?.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    urlImage = urlDownload;
    /* print('Download link: $urlDownload'); */
    imageProfile(urlDownload);
  }

  Widget imageProfile(imagePath) {
    return Container(
        child: _load
            ? ProfileWidget(
                imagePath: imagePath,
                onClicked: () async {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));
                },
                isPath: true,
                fileImage: urlImage,
              )
            : ProfileWidget(
                imagePath: imagePath,
                onClicked: () async {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));
                },
                isPath: false,
              ));
  }

  Widget buildEditButton(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: const Color(0xFF84BDCE),
        all: 8,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
          child: (Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      )));
}

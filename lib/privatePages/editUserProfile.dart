// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, unnecessary_null_comparison, file_names
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:diabetes_assistant/widget/buildAppBar.dart';
import 'package:diabetes_assistant/widget/profileWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController firstNameController;
  late TextEditingController secondNameController;
  late TextEditingController aboutController;
  late TextEditingController weightController;
  late TextEditingController heightController;
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserPreferences>(context, listen: false).user!;
    firstNameController = TextEditingController(text: user.firstName);
    secondNameController = TextEditingController(text: user.secondName);
    aboutController = TextEditingController(text: user.about);
    weightController = TextEditingController(text: user.weight.toString());
    heightController = TextEditingController(text: user.height.toString());

    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("First name cannot be empty");
        }
        if (!RegExp(r'^.{3,}').hasMatch(value)) {
          return ("Please enter a valid Name(Min. 3 Character");
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
        hintText: 'First Name',
      ),
    );

    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Second name cannot be empty");
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
        hintText: 'Second Name',
      ),
    );

    final heightField = TextFormField(
      autofocus: false,
      controller: heightController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Height");
        }
        if (!RegExp("^[0-9]+(.[0-9]+)?").hasMatch(value)) {
          return ("Please Enter a valid height");
        }
        return null;
      },
      onSaved: (value) {
        heightController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.rule),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Height',
      ),
    );

    final weightField = TextFormField(
      autofocus: false,
      controller: weightController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Weight");
        }
        if (!RegExp("^[0-9]+(.[0-9]+)?").hasMatch(value)) {
          return ("Please Enter a valid weight");
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
        hintText: 'Weight',
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
        hintText: 'About',
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
          });
          Navigator.of(context).pop();
        },
        child: Text(
          'Save Data',
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
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
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
            ],
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
            'Choose Profile Picture',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                  onPressed: () {
                    takePicture(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              ElevatedButton.icon(
                  onPressed: () {
                    takePicture(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

  void takePicture(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
      _load = true;
    });
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
                fileImage: _imageFile.path,
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

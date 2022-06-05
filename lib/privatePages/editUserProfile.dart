// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, unnecessary_null_comparison, file_names
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:diabetes_assistant/widget/buildAppBar.dart';
import 'package:diabetes_assistant/widget/profileWidget.dart';
import 'package:diabetes_assistant/widget/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  UserModel user = userPreferences.myUser;
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _load = false;
  
  @override
  Widget build(BuildContext context) {
      final updateUser = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF84BDCE),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
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
              const SizedBox(
                        height: 24,
                      ),
              imageProfile(),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'Full Name',
                text: user.firstName!+' '+user.secondName!,
                onChanged: (name) {},
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'Email',
                text: user.email!,
                onChanged: (email) {},
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'About',
                text: user.about!,
                maxLines: 5,
                onChanged: (about) {},
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'Weight',
                text: user.weight.toString(),
                onChanged: (weight) {},
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'Height',
                text: user.height.toString(),
                onChanged: (height) {},
              ),
              const SizedBox(
                height: 24,
              ),
              updateUser,
            ],
          ),
        ),
      ));
      }
  Widget bottomSheet(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text('Choose Profile Picture',
          style: TextStyle(fontSize: 20.0),),
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: (){
                  takePicture(ImageSource.camera);
                }, 
                icon: Icon(Icons.camera), 
                label: Text('Camera')),
                ElevatedButton.icon(
                onPressed: (){
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
  final pickedFile = await _picker.getImage(source: source,);
  setState(() {
    _imageFile = pickedFile!;
    _load = true;
  });
}
  Widget imageProfile(){
    return Container(
      child: _load ==true?
        ProfileWidget(
                        imagePath: user.imagePath!,
                        onClicked: () async {
                          showModalBottomSheet(
                      context: context, 
                      builder: ((builder)=>bottomSheet()));
                          
                        },
                        isPath: true,
                        fileImage: _imageFile.path,)
                        :
    ProfileWidget(
                        imagePath: user.imagePath!,
                        onClicked: () async {
                          showModalBottomSheet(
                      context: context, 
                      builder: ((builder)=>bottomSheet()));
                          
                        },
                        isPath: false,
    ),
    );
  }

    Widget buildEditButton(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
      color: const Color(0xFF84BDCE),
      all: 8,
      child: Icon(
        Icons.edit ,
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

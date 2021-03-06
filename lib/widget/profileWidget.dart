// ignore_for_file: override_on_non_overriding_member, annotate_overrides, file_names, unnecessary_null_comparison
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  @override
  final String imagePath;
  final bool isEdit;
  final bool isPath;
  final String fileImage; 
  final VoidCallback onClicked;
  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit=false,
    required this.onClicked,
    this.isPath=false,
    this.fileImage = '',
  }) : super(key: key);

  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
        child: Stack(children: [
      buildImage(),
      Positioned(
        bottom: 0,
        right: 4,
        child: buildEditButton(color),
      )
    ]));
  }

  Widget buildImage() {
    final image = imagePath;
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: isPath? (fileImage!=null)? NetworkImage(fileImage) : AssetImage(image) as ImageProvider : AssetImage(image),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
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
        isEdit? Icons.add_a_photo : Icons.edit ,
        color: Colors.white,
        size: 20,
      )));

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

// ignore_for_file: prefer_const_constructors

import 'package:diabetes_assistant/utils/advices.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Advices consejo;

  const DetailPage({Key? key, required this.consejo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            /*  Positioned(
              right: -64, 
              child: Hero(
                tag: consejo.position,
                child: Image.asset(consejo.iconImage))), */
            Positioned(
              top: 60,
              left: 32,
              child: Text(
                consejo.position.toString(),
                style: const TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 180,
                  color: Color.fromARGB(255, 172, 190, 223),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 300,
                        ),
                        Text(
                          consejo.name,
                          style: const TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 56,
                            color: Color(0XFF215466),
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Text(
                          'Cuida tú salud',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 31,
                            color: Color(0XFF215466),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Divider(
                          color: Colors.black38,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Text(
                            consejo.description,
                            style: const TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 20,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* const Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Some more pics',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 25,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.only(left: 32.0),
                    child: ListView.builder(
                        itemCount: consejo.images.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  consejo.images[index],
                                  fit: BoxFit.cover,
                                )),
                          );
                        }),
                  ) */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

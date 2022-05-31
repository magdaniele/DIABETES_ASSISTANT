// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, unused_import, import_of_legacy_library_into_null_safe, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/privatePages/detail.dart';
import 'package:diabetes_assistant/themes.dart';
import 'package:diabetes_assistant/utils/advices.dart';
import 'package:diabetes_assistant/widget/navigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
                title: const Text('Home'), backgroundColor: Color(0xFF8215466)),
            drawer: const NavigationDrawer(),
            body: _homePage(context),
          ),
        ),
      );

  Widget _homePage(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: <Widget>[
                Text(
                  'Consejos',
                  style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 40,
                      color: Color(0xFF8215466),
                      fontWeight: FontWeight.w900),
                )
              ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height- 4 * 64,
              padding: const EdgeInsets.only(left: 32),
              child: Swiper(
                itemCount: consejos.length,
                itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                layout: SwiperLayout.STACK,
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    activeSize: 15,
                    space: 8,
                    activeColor: Color(0XFF215466)
                  ),
                  alignment: Alignment.bottomCenter,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, PageRouteBuilder(pageBuilder: (context,a,b)=>DetailPage(consejo: consejos[index])));
                    },
                    child: Stack(children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                            color: Color(0xffE5f5f3),
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 100),
                                    Text(
                                      consejos[index].name,
                                      style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                          textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 32),
                                    Text(
                                      consejos[index].description,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 50),
                                    /* Row(
                                      children: <Widget>[
                                        Text(
                                          'Mas información',
                                          style: TextStyle(
                                              fontFamily: 'Avenir',
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.right,
                                        ),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    ) */
                                  ]),
                            ),
                          )
                        ],
                      ),
                      Hero(
                        tag: consejos[index].position,
                        child: Image.asset(consejos[index].iconImage))
                    ]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, unnecessary_new, file_names, prefer_final_fields, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

Future<void> main() async => {
      WidgetsFlutterBinding.ensureInitialized(),
      runApp(MaterialApp(home: BottomNavBar()))
    };

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          height: 60.0,
          items: <Widget>[
            const Icon(Icons.home, size: 30),
            const Icon(Icons.list, size: 30),
            const Icon(Icons.compare_arrows, size: 30),
            const Icon(Icons.calculate, size: 30),
            const Icon(Icons.perm_identity, size: 30),
          ],
          color: Color.fromARGB(255, 47, 154, 255),
          buttonBackgroundColor: Color.fromARGB(255, 47, 154, 255),
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                /* ElevatedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    final CurvedNavigationBarState? navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState?.setPage(1);
                  } ,
                )*/
              ],
            ),
          ),
        ));
  }
}

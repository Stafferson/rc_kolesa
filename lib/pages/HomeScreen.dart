import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_kolesa/pages/HomePages/ApartmentsScreen.dart';
import 'package:rc_kolesa/pages/HomePages/ChatBotScreen.dart';
import 'package:rc_kolesa/pages/HomePages/ProfileScreen.dart';
import 'package:upgrader/upgrader.dart';

import '../utilities/animated_indexed_stack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    ApartmentScreen(),
    ChatbotScreen(),
    ProfileScreen(),
  ];

  List<Icon> icons = [
    const Icon(Icons.apartment_rounded, color: Colors.white,),
    const Icon(Icons.chat_rounded, color: Colors.white,),
    const Icon(Icons.person_rounded, color: Colors.white,),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
        upgrader: Upgrader(
          messages: UpgraderMessages(code: "ru"),
          dialogStyle: UpgradeDialogStyle.cupertino,
        ),
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: AnimatedIndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
          bottomNavigationBar: CurvedNavigationBar(
            color: Color(0xff5a43f3),
            backgroundColor: Colors.transparent,
            height: 50.h.round().toDouble(),
            items: icons,
            onTap: (index) {
              _onItemTapped(index);
            },
          ),
        ));
  }
}

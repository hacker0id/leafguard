import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../Theme/colors.dart';
import '../screens/WelcomePage.dart';
import '../screens/developers.dart';
import '../screens/onBoardingScreen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        index: 1,
        height: device.height * 0.07,
        backgroundColor: primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        color: secondaryColor,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => WelcomePage()));
          } else if (index == 0) {
            setState(() {
              Share.share(
                  ' https://drive.google.com/file/d/12wE0XpAIXFbiUsW7JJvAvefQ1fftFkZj/view?usp=drive_link');
            });
          } else if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => DevelopersPage()));
          }
        },
        items: const [
          Icon(FontAwesomeIcons.share),
          Icon(FontAwesomeIcons.house),
          Icon(FontAwesomeIcons.userGroup),
        ]);
  }
}

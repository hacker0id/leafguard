import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leafguard/Theme/colors.dart';
import 'package:leafguard/Theme/styling.dart';
import 'package:leafguard/screens/onBoardingScreen.dart';
import 'package:leafguard/widgets/navBar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components.dart';

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({super.key});

  @override
  State<DevelopersPage> createState() => _DevelopersPageState();
}

List<Color> colors = [
  Colors.yellow.shade300,
  secondaryColor,
  Colors.black54,
];

class _DevelopersPageState extends State<DevelopersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: NavBar(),
      backgroundColor: primaryColor,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: device.height * 0.6,
          width: device.width * 0.75,
          child: Swiper(
              duration: 1200,
              layout: SwiperLayout.TINDER,
              scrollDirection: Axis.horizontal,
              itemHeight: device.height * 0.5,
              itemWidth: device.width * 0.75,
              itemCount: 3,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        print('Arooj');
                        launchUrl1();
                      } else if (index == 1) {
                        launchUrl2();
                      } else if (index == 2) {
                        launchUrl3();
                      }
                    },
                    child: Container(
                      // height: device.height,
                      // width: 500,
                      // padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: colors,

                            /// [Colors.yellow.shade300, secondaryColor, Colors.black54]
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: CircleAvatar(
                              backgroundColor: primaryColor,
                              radius: 65,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: icon[index],
                              ),
                            ),
                          ),
                          Text(
                            names[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              fontSize: 30,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            designations[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.black54,
                                  height: device.height * 0.005,
                                  // width: device.width * 0.22,
                                ),
                              ),
                              const Text('Contact Dev'),
                              Expanded(
                                child: Container(
                                  color: Colors.black54,
                                  height: device.height * 0.005,
                                  // width: device.width * 0.22,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white38,
                              ),
                              height: device.height * 0.06,
                              width: device.width * 0.45,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('LinkedIn',
                                      style: TextStyle(fontSize: 20)),
                                  Icon(FontAwesomeIcons.linkedin)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor.withOpacity(0.85),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(device.height * 0.1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: device.height * 0.06, left: device.width * 0.08),
                child: Text(
                  'LeafGuard',
                  style: kBodyText.copyWith(fontSize: 40, color: Colors.black),
                ),
              ),
              SizedBox(width: device.width * 0.05),
              Text(
                '..',
                style: kBodyText.copyWith(fontSize: 40, color: Colors.black),
              ),
              const Icon(
                FontAwesomeIcons.leaf,
                size: 45,
              ),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(2500),
          bottomLeft: Radius.circular(1200),
        )));
  }
}

// class Cards extends StatelessWidget {
//   String designation;
//   String devName;
//   String icon;
//   List<Color> colors;
//   VoidCallback function;
//   Cards({
//     required this.icon,
//     required this.colors,
//     required this.devName,
//     required this.designation,
//     required this.function,
//   });
//   @override
//   Widget build(BuildContext context) {

//   }
// }

// SwipeDeck(
//           onSwipeLeft: () {},
//           onSwipeRight: () {},
//           startIndex: 1,
//           cardSpreadInDegrees: 30,
//           widgets: colors.map((e) => swipingCards(e)).toList(),
//         ),

final Uri url1 = Uri.parse('https://www.linkedin.com/in/arooj-shafi-b00283265');
Future<void> launchUrl1() async {
  if (!await launchUrl(url1)) {
    throw Exception('Could not launch " Arooj @ LinkedIn "');
  }

  print('Pressed');
}

final Uri url2 =
    Uri.parse('https://www.linkedin.com/in/syed-mohtashim-a4160120a');
Future<void> launchUrl2() async {
  if (!await launchUrl(url1)) {
    throw Exception('Could not launch" Mohtashim @ LinkedIn "');
  }
}

final Uri url3 =
    Uri.parse('https://www.linkedin.com/in/shabih-nazir-b38a941ba');
Future<void> launchUrl3() async {
  if (!await launchUrl(url1)) {
    throw Exception('Could not launch " Shabih @ LinkedIn "');
  }
}

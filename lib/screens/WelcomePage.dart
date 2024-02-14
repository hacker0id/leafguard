// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafguard/Theme/colors.dart';
import 'package:leafguard/Theme/styling.dart';
import 'package:leafguard/screens/results.dart';
import 'package:leafguard/widgets/navBar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'onBoardingScreen.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

var currentIndex = 0;
var carouselController = CarouselController();
File? image;

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    //
    Future<void> getImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
      }
    }

    device = MediaQuery.sizeOf(context);
    return Scaffold(
      bottomNavigationBar: NavBar(),
      appBar: appBar(),
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: device.height * 0.08),
              CarouselSlider(
                carouselController: carouselController,
                items: [
                  sliderImage(1),
                  sliderImage(2),
                  sliderImage(3),
                  sliderImage(4),
                  sliderImage(5)
                ],
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  onPageChanged: (index, _) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  autoPlayCurve: Curves.easeInBack,
                  autoPlay: true,
                ),
              ),
              SizedBox(height: device.height * 0.02),
              SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.black,
                    activeDotColor: secondaryColor,
                  ),
                  controller: PageController(initialPage: currentIndex),
                  count: 5),
              SizedBox(height: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Buttons(
                    buttonText: 'Click Picture',
                    icon: FontAwesomeIcons.camera,
                    function: () async {
                      await getImage(ImageSource.camera);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ResultsPage()));
                    },
                  ),
                  SizedBox(height: device.height * 0.035),
                  Buttons(
                    buttonText: 'Choose Picture',
                    icon: FontAwesomeIcons.image,
                    function: () async {
                      await getImage(ImageSource.gallery);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ResultsPage()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  sliderImage(int imgNumber) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          // height: 200,
          // width: 200,
          decoration: BoxDecoration(
        border: Border.all(color: secondaryColor, width: 5),
        borderRadius: BorderRadius.circular(28),
        image: DecorationImage(
          image: AssetImage('assets/Images/$imgNumber.jpg'),
          fit: BoxFit.cover,
        ),
      )),
    );
  }

  //
  /// Custom App Bar
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

class Buttons extends StatelessWidget {
  String buttonText;
  IconData icon;
  VoidCallback function;
  Buttons(
      {required this.buttonText, required this.icon, required this.function});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: device.height * 0.07,
      width: device.width * 0.65,
      child: FilledButton.tonalIcon(
        style: FilledButton.styleFrom(
            side: const BorderSide(width: 2, color: Colors.black),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            backgroundColor: secondaryColor,
            elevation: 10,
            shadowColor: Colors.black),
        label: Padding(
            padding: EdgeInsets.all(10),
            child: Text(buttonText,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16.5,
                    color: Colors.black))),
        onPressed: function,
        icon: Icon(icon, color: Colors.black),
      ),
    );
  }
}

// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leafguard/Theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Theme/styling.dart';
import 'WelcomePage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

var device;
final pageviewController = PageController();

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageviewController.addListener(() {
      final newIndex = pageviewController.page!.toInt();
      if (newIndex != currentPageIndex) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            currentPageIndex = newIndex;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    device = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageviewController,
                children: [
                  page1(),
                  page2(),
                  page3(context),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.black,
                    activeDotColor: secondaryColor,
                  ),
                  controller: pageviewController,
                  count: 3,
                ),

                //Button
                Container(
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    height: device.height * 0.05,
                    width: pageviewController.hasClients &&
                            pageviewController.page == 2
                        ? device.width * 0.5
                        : device.width * 0.4,
                    child: GestureDetector(
                      onTap: () async {
                        if (pageviewController.hasClients) {
                          if (pageviewController.page == 2) {
                            // Last page reached (page3)

                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('viewHome', true);
                            // Navigate to another screen or perform an action
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()),
                            );
                          } else {
                            // Go to the next page
                            pageviewController.nextPage(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeIn,
                            );
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pageviewController.hasClients &&
                                    pageviewController.page == 2
                                ? 'Get Started'
                                : 'Continue',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          hSpace(0.1),
                          const Icon(
                            FontAwesomeIcons.arrowRight,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ))
              ],
            ),
            vSpace(0.05)
          ],
        ),
        // SmoothPageIndicator(
        //   controller: pageviewController,
        //   count: 2,
        // ),
      ),
    );
  }

// Page 1 Starts Here
  page1() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        vSpace(0.2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset('assets/Images/logo.jpg')),
        ),
        vSpace(0.09),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText('Welcome to',
                style: kBodyText2.copyWith(fontSize: 26)),
            hSpace(0.015),
            const AutoSizeText('LeafGuard!', style: kBodyText),
          ],
        ),
        vSpace(0.04),
      ],
    );
  }

  // Page2 Starts Here

  page2() {
    return Column(
      children: [
        vSpace(0.15),
        header('assets/Images/leaf1.png'),
        vSpace(0.025),
        onBoardingText(
            'Our mission is to provide accurate and reliable deep learning technology for identifying and predicting various types of apple diseases by analyzing infected leaves.By using our app, you can significantly improve your existing disease management system and ensure the health of your apple crops.'),
      ],
    );
  }

  // Page 3 Starts Here

  page3(BuildContext context) {
    setState(() {});

    return Column(
      children: [
        vSpace(0.15),
        header('assets/Images/Image3.png'),
        vSpace(0.025),
        onBoardingText(
            'Let\'s Get Started\nJoin us on this journey to revolutionize apple disease detection and management.\nTap "Get Started" to explore the app\'s features and empower your farming practices.'),
        vSpace(0.02),
        onBoardingText(
            'You could feed in data by :\n1. Clicking a Picture\n2. Choosing an Image')
      ],
    );
  }

//Onboarding Header Image
  header(String imageName) {
    return SizedBox(
        height: device.height * 0.4,
        width: device.width * 0.9,
        child: Image(fit: BoxFit.contain, image: AssetImage(imageName)));
  }

  // Onboarding Text

  onBoardingText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AutoSizeText(text, textAlign: TextAlign.center, style: kBodyText2),
    );
  }

// Spacers
  vSpace(double value) {
    return SizedBox(height: device.height * value);
  }

  hSpace(double value) {
    return SizedBox(width: device.width * value);
  }
}

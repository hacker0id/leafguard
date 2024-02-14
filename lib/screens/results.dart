import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leafguard/networking/api.dart';
import '../Theme/colors.dart';
import '../Theme/styling.dart';
import '../widgets/navBar.dart';
import 'WelcomePage.dart';
import 'onBoardingScreen.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

bool showProgressBar = false;
bool showResult = false;
bool showResetButton = false;

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    Widget widgetToDisplay;

    //!  Some Widget Logic

    if (image == null) {
      widgetToDisplay = Text('No Image Selected');
    } else {
      widgetToDisplay = Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(width: 4, color: secondaryColor)),
        height: device.height * 0.4,
        width: device.width * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            image!,
            fit: BoxFit.cover,
            // height: device.height * 0.3,
            // width: device.width * 0.8,
          ),
        ),
      );
    }

    //! Fn For API and Progress Bar

    mainFunction() async {
      await uploadImage(image!);
      setState(() {
        showProgressBar = false;
        showResetButton = true;
        showResult = true;
      });
    }

    return Scaffold(
      bottomNavigationBar: NavBar(),
      appBar: appBar(),
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: device.height * 0.06),
            widgetToDisplay,
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: device.width * 0.5,
                  height: device.height * 0.055,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: secondaryColor),
                    onPressed: () async {
                      print(showProgressBar);
                      print('Button Clicked\n');
                      setState(() {
                        showProgressBar = true;
                      });

                      mainFunction();
                    },
                    child: showProgressBar
                        ? CircularProgressIndicator(
                            color: primaryColor,
                          )
                        : Text('Send',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                fontSize: 19,
                                color: Colors.black)),
                  ),
                ),
                SizedBox(width: device.width * 0.03),
                showResetButton
                    ? Transform.scale(
                        scale: 0.8,
                        child: Ink(
                          decoration: ShapeDecoration(
                              shape: CircleBorder(), color: secondaryColor),
                          child: IconButton(
                            iconSize: 30,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomePage(),
                                  ));

                              showResetButton = false;
                              showResult = false;
                            },
                            icon: Icon(
                              FontAwesomeIcons.arrowsRotate,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(height: device.height * 0.05),
            showResult
                ? Container(
                    height: device.height * 0.045,
                    width: device.width * 0.7,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Center(
                        child: serverRunning
                            ? Text('Result :  $displayResult',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Montserrat',
                                  fontSize: 19,
                                ))
                            : Text('Check Server',
                                style: TextStyle(
                                  color: Colors.red.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  fontSize: 24,
                                ))),
                  )
                : SizedBox(),
          ],
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

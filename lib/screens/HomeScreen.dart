
import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../widgets/BasicButton.dart';
import '../BasicRoute.dart';
import 'CameraScreen.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        padding: mediaQueryData.padding,
        height: mediaQueryData.size.height,
        width: mediaQueryData.size.width,
        color: CrowdRaterColors.primaryBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Crowd Rater',
              style: const TextStyle(
                  fontFamily: 'Righteous',
                  fontSize: 48.0,
                  color: CrowdRaterColors.primaryRed
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'Tap below to rate your crowd!',
                    style: const TextStyle(
                        fontFamily: 'Righteous',
                        fontSize: 24.0,
                        color: CrowdRaterColors.primaryGold
                    ),
                  ),
                ),
                BasicButton(
                  onClick: () => Navigator.of(context).push(BasicRoute(CameraScreen())),
                  color: Colors.white,
                  size: 64.0,
                  body: Text(
                    '📷',
                    style: TextStyle(fontSize: 32.0),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
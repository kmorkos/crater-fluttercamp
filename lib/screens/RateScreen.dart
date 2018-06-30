
import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../widgets/BasicButton.dart';
import '../BasicRoute.dart';
import 'CameraScreen.dart';

class RateScreen extends StatefulWidget {

  final String filePath;

  RateScreen({
    Key key,
    @required this.filePath,
  }) : super(key: key);

  @override
  _RateScreenState createState() => _RateScreenState();

}

class _RateScreenState extends State<RateScreen> {

  @override
  void initState() {
    super.initState();
  }

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              widget.filePath
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              child: BasicButton(
                onClick: () => Navigator.of(context).push(BasicRoute(CameraScreen())),
                color: Colors.white,
                size: 64.0,
                body: Text(
                  '📷',
                  style: TextStyle(fontSize: 32.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

import '../widgets/BasicButton.dart';
import '../BasicRoute.dart';
import 'RateScreen.dart';

class CameraScreen extends StatefulWidget {

  CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();

}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  CameraController _controller;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.resumed:
        _initializeCameras(CameraLensDirection.front);
        break;
      case AppLifecycleState.suspending:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        _controller?.dispose();
        break;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future _load() async {
    bool permissionGranted = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
    if (!permissionGranted) {
      permissionGranted = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
      if (!permissionGranted) {
        print('File permission not granted');
        return;
      }
    }

    await _initializeCameras(CameraLensDirection.front);
    WidgetsBinding.instance.addObserver(this);
  }

  Future _initializeCameras(CameraLensDirection direction) async {
    if (_controller != null && _controller.value.isInitialized) {
      await _controller.dispose();
    }

    List<CameraDescription> cameras = await availableCameras();
    _controller = CameraController(cameras[direction.index], ResolutionPreset.high)
      ..initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> _takePicture() async {
    if (!_controller.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (_controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await _controller.takePicture(filePath);
    } on CameraException catch (e) {
      print(e);
      return null;
    }
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    if (_controller == null || !_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: mediaQueryData.padding,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 36.0,
                child: Container(
                  width: mediaQueryData.size.width,
                  child: Center(
                    child: BasicButton(
                      onClick: () => _takePicture().then((String path) => Navigator.of(context).push(BasicRoute(RateScreen(filePath: path)))),
                      color: Colors.white,
                      size: 64.0,
                      body: Text(
                        '🧀',
                        style: TextStyle(fontSize: 48.0),
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

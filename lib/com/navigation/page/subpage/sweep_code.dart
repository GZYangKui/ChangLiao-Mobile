///
/// 扫码添加好友界面
///
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class SweepCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SweepCodeState();
}

class _SweepCodeState extends State<SweepCode> {
  CameraController controller;
  List<CameraDescription> cameras;
  bool _isInitial = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitial) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CircularProgressIndicator(), Text("相机正在初始化在...")],
        ),
      );
    } else {
      if (!controller.value.isInitialized) {
        return new Container();
      }
      return new AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: new CameraPreview(controller));
    }
  }

  void _initCamera() async {
    cameras = await availableCameras();
    controller = new CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isInitial = true;
      });
    });
  }
}

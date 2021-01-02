import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';
import 'package:flutter/services.dart';
import 'dart:async';
// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     _onOpenPressed(PresentationStyle.modal);
//     return Container(
//       padding: EdgeInsets.all(0),
//       margin: EdgeInsets.all(0),
//       height: 1,
//       width: 1,
//       child: MaterialApp(
//         home: Container(),
//       ),
//     );

//     // CupertinoApp(
//     //   debugShowCheckedModeBanner: false,
//     //   home: Column(
//     //     mainAxisAlignment: MainAxisAlignment.center,
//     //     children: [
//     //       CupertinoButton(
//     //         child: Text('Open as modal'),
//     //         onPressed: () => _onOpenPressed(PresentationStyle.modal),
//     //       ),
//     //       SizedBox(height: 16.0),
//     //       CupertinoButton(
//     //         child: Text('Open as sheet'),
//     //         onPressed: () => _onOpenPressed(PresentationStyle.sheet),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _windowSize = 'Unknown';

  @override
  void initState() {
    super.initState();
    setSize();
  }

  Future _getWindowSize() async {
    var size = await DesktopWindow.getWindowSize();
    setState(() {
      _windowSize = '${size.width} x ${size.height}';
    });
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  Future<void> _onOpenPressed(PresentationStyle presentationStyle) async {
    final webview = FlutterMacOSWebView(
      onOpen: () => print('Opened'),
      onClose: () {
        print('Closed');
        pop();
      },
      onPageStarted: (url) => print('Page started: $url'),
      onPageFinished: (url) => print('Page finished: $url'),
      onWebResourceError: (err) {
        print(
          'Error: ${err.errorCode}, ${err.errorType}, ${err.domain}, ${err.description}',
        );
      },
    );

    await webview.open(
      url: 'https://flomoapp.com/mine',
      presentationStyle: presentationStyle,
      size: Size(400.0, 400.0),
      userAgent:
          'Mozilla/5.0 (iPhone; CPU iPhone OS 14_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1',
    );
  }

  setSize() async {
    await DesktopWindow.setWindowSize(Size(1, 1));
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).size;
    _onOpenPressed(PresentationStyle.modal);
    return MaterialApp(
      home: SizedBox(),
    );
  }
}

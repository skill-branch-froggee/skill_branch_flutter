import 'dart:io';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';

import 'package:FlutterGalleryApp/res/res.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: buildAppTextTheme(),
      ),
      onGenerateRoute: (RouteSettings setting) {
        if (setting.name == '/fullScreenImage') {
          FullScreenImageArguments args =
              (setting.arguments as FullScreenImageArguments);
          final route = FullScreenImage(
            photo: args.photo,
            altDescription: args.altDescription,
            name: args.name,
            userName: args.userName,
            heroTag: args.heroTag,
            userPhoto: args.userPhoto,
            key: key,
          );
          if (Platform.isAndroid) {
            return MaterialPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          }
        }
      },
      home: Home(Connectivity().onConnectivityChanged),
    );
  }
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    // реализуйте отображение Overlay.
    OverlayState overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (BuildContext context) =>
       child);

    overlayState.insert(overlayEntry);
    print(overlayEntry);
    //await Future.delayed(Duration(seconds: 3));
  }

  void removeOverlay(BuildContext context) {
// реализуйте удаление Overlay.
    print(overlayEntry);
    overlayEntry?.remove();
    print(overlayEntry);
  }
}

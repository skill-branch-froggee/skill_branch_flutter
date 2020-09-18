import 'dart:io';

import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class FullScreenImageArguments {
//   final String photo;
//   final String altDescription;
//   final String name;
//   final String userName;
//   final String userPhoto;
//   final String heroTag;
//   final Key key;

//   FullScreenImageArguments({
//     this.photo,
//     this.altDescription,
//     this.name,
//     this.userName,
//     this.userPhoto,
//     this.heroTag,
//     this.key,
//   });
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

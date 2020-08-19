import 'package:flutter/material.dart';
import 'package:widgets_lesson/res/res.dart';
import 'package:widgets_lesson/screens/feed_screen.dart';
import 'package:widgets_lesson/widgets/widgets.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({this.photo, Key key}) : super(key: key);

  final String photo;

  @override
  State<StatefulWidget> createState() {
    return FullScreenImageState();
  }
}

class FullScreenImageState extends State<FullScreenImage> {
  String photo;

  @override
  void initState() {
    super.initState();
    photo = (widget.photo != null) ? widget.photo : kFlutterDash;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Photo',
          style: AppStyles.h2Black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Photo(
          photoLink: kFlutterDash,
        ),
      ),
    );
  }
}

/*
  const 
   final String kFlutterDash =
     'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

  @override
  Widget build(BuildContext context) {
    return 
}
*/

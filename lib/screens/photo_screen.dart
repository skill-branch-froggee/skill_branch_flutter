//import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreenImageArguments {
  final String photo;
  final String altDescription;
  final String name;
  final String userName;
  final String userPhoto;
  final String heroTag;
  final Key key;
  final RouteSettings routeSettings;

  FullScreenImageArguments({
    this.routeSettings,
    this.photo,
    this.altDescription,
    this.name,
    this.userName,
    this.userPhoto,
    this.heroTag,
    this.key,
  });
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.photo = '',
      this.altDescription = '',
      this.name = '',
      this.userName = '',
      Key key,
      this.heroTag = '',
      this.userPhoto = ''})
      : super(key: key);

  final String photo;
  final String altDescription;
  final String name;
  final String userName;
  final String userPhoto;
  final String heroTag;

  @override
  State<StatefulWidget> createState() {
    return FullScreenImageState();
  }
}

class FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);

    _playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;

      //  await _controller.reverse().orCancel;
    } on TickerCanceled {
      //анимация была отменена, тк была уничтожена
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.heroTag);

    return Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    // прилетающая картика с др страницы
                    tag: widget.heroTag,
                    child: Photo(
                      photoLink: widget.photo,
                    ),
                  ),
                  Padding(
                    //описание под картинкой
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      widget.altDescription,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  StaggerAnimation(
                    animationController: _controller,
                    name: widget.name,
                    userName: widget.userName,
                    userPhoto: widget.userPhoto,
                  ), // аватарка, имя, username анимация прозрачности

                  Row(
                    // строка с кнопками лайков и Text @ Visit
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          width: 105,
                          height: 60,
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          // margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          child: LikeButton(10, true)), // кнопка с лайками
                      SizedBox(width: 12),
                      _buildButton('Save', () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Downloading photos"),
                                  content: Text(
                                      "Are you sure you want to upload a photo?"),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          GallerySaver.saveImage(widget.photo)
                                              .then((bool success) {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: Text('Download')),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Close')),
                                  ],
                                ));
                      }),
                      SizedBox(width: 12),
                      _buildButton('Visit', () async {
                        OverlayState overlayState = Overlay.of(context);

                        OverlayEntry overlayEntry =
                            OverlayEntry(builder: (BuildContext context) {
                          return Positioned(
                              top: MediaQuery.of(context).viewInsets.top + 50,
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    padding:
                                        EdgeInsets.fromLTRB(16, 10, 16, 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.mercury,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Text('Skill Branch'),
                                  ),
                                ),
                              ));
                        });
                        overlayState.insert(overlayEntry);
                        await Future.delayed(Duration(seconds: 1));
                        overlayEntry.remove();
                      }),
                    ],
                  ),
                ])));
  }

  Widget _buildAppBar(context) {
    String title = ModalRoute.of(context).settings.arguments;
    return AppBar(
      elevation: 0,
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ClaimBottomSheet();
                  });
            }),
      ],
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  Widget _buildButton(String text, VoidCallback callback) {
    //кнопки
    return GestureDetector(
        //behavior: HitTestBehavior.opaque,
        onTap: callback,
        child: Container(
          width: 105,
          height: 36,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          // margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.dodgerBlue,
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),

          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: AppColors.white),
          ),
        ));
  }
}

class StaggerAnimation extends StatelessWidget {
  final Animation<double> opacityUserAvatar;
  final Animation<double> opacityText;
  final Animation<double> animationController;

  final String name;
  final String userName;
  final String userPhoto;

  StaggerAnimation(
      {Key key,
      this.animationController,
      this.name,
      this.userName,
      this.userPhoto})
      : opacityUserAvatar = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        ),
        opacityText = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0.5, 1.0, curve: Curves.ease),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildPhotoMetaData,
      animation: animationController,
    );
  }

  Widget _buildPhotoMetaData(BuildContext context, Widget child) {
    // ghjdthrf pyfxtybq

    // double a, b, c, d;
    //   a = animationController.value;
    //   b = opacityUserAvatar.value;
    //   print('$a - OpacityUserAvatar $b');
    //  c = animationController.value;
    // d = opacityText.value;
    //print('$c - opacityText $d');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              FadeTransition(
                opacity: opacityUserAvatar,
                child: UserAvatar(userPhoto),
              ),
              SizedBox(width: 6),
              FadeTransition(
                opacity: opacityText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(name, style: Theme.of(context).textTheme.headline1),
                    Text('@$userName',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: AppColors.manatee)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

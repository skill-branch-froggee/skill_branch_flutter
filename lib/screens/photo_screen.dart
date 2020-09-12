import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.photo = '',
      this.altDescription = '',
      this.name = '',
      this.userName = '',
      Key key,
      this.heroTag = 'tag0',
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
        duration: Duration(milliseconds: 5500), vsync: this);

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
                style: AppStyles.h3.copyWith(color: AppColors.grayChateau),
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
                LikeButton(10, true), // кнопка с лайками
                SizedBox(width: 12),
                GestureDetector(
                    //behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: _buildButton('Text')),
                SizedBox(width: 12),
                GestureDetector(
                  //behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: _buildButton('Visit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildAppBar(context) {
  return AppBar(
    centerTitle: true,
    title: Text(
      'Photo',
      style: AppStyles.h2Black,
    ),
    leading: IconButton(
        icon: const Icon(CupertinoIcons.back),
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}

Widget _buildButton(String text) {
  //кнопки
  return Container(
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
      style: AppStyles.h4.copyWith(color: AppColors.white),
    ),
  );
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
            curve: Interval(0.0, .5, curve: Curves.ease),
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
    /*
    double a, b, c, d;
    a = animationController.value;
    b = opacityUserAvatar.value;
    print('$a - OpacityUserAvatar $b');
    c = animationController.value;
    d = opacityText.value;
    print('$c - opacityText $d');
*/
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: opacityUserAvatar,
                    child: child,
                  );
                },
                child: UserAvatar(userPhoto),
              ),
              SizedBox(width: 6),
              //        AnimatedBuilder(
              //        animation: animationController,
              //      builder: (context, child) {
              //      return
              Opacity(
                opacity: opacityText.value,
                //        child: child,
                //     );
                //   },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(name, style: AppStyles.h1Black),
                    Text('@$userName',
                        style: AppStyles.h5Black
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

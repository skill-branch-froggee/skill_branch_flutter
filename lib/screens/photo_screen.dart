import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:widgets_lesson/res/res.dart';
import 'package:widgets_lesson/screens/feed_screen.dart';
import 'package:widgets_lesson/widgets/widgets.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.photo, this.altDescription, this.name, this.userName, Key key})
      : super(key: key);

  final String photo;
  final String altDescription;
  final String name;
  final String userName;

  @override
  State<StatefulWidget> createState() {
    return FullScreenImageState();
  }
}

class FullScreenImageState extends State<FullScreenImage> {
  String photo;
  String altDescription;
  String name;
  String userName;

  @override
  void initState() {
    super.initState();
    photo = (widget.photo != null) ? widget.photo : kFlutterDash;
    altDescription = (widget.altDescription != null)
        ? widget.altDescription
        : 'Description: Реализуй widget Text на странице с фото.Виджет должен реализован в Column вместе с Photo, Buttons и PhotoMeta. Создать widget Text. Надпись на нём должна быть передана через конструктор     полем ‘altDescription’. Ограничить максимальное кол-во строк текста до 3-х. Обработать переполнение 3-х строк текста на экране постановкой многоточия.Задать стиль текста AppStyles.h3';
    name = (widget.name != null) ? widget.name : 'Kirill Adeshchenko';
    userName = (widget.userName == null) ? 'kaparray' : widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(CupertinoIcons.back),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Photo(
              photoLink: kFlutterDash,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                altDescription,
                // textAlign: TextAlign.left,
                maxLines: 3,
                style: AppStyles.h3.copyWith(color: AppColors.grayChateau),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildPhotoMeta(name, userName),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LikeButton(10, true),
                GestureDetector(
                  //behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Container(
                    width: 105,
                    height: 36,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.dodgerBlue,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Text(
                      'Save',
                      style: AppStyles.h4.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  //behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Container(
                    width: 105,
                    height: 36,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.dodgerBlue,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Text(
                      'Visit',
                      style: AppStyles.h4.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPhotoMeta(name, userName) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            UserAvatar('http://skill-branch.ru/img/speakers/Adechenko.jpg'),
            SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(name, style: AppStyles.h1Black),
                Text('@$userName',
                    style:
                        AppStyles.h5Black.copyWith(color: AppColors.manatee)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

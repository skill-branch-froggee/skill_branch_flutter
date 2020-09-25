import 'dart:async';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:connectivity/connectivity.dart';

//import 'demo_screen.dart';
import 'feed_screen.dart';

class Home extends StatefulWidget {
  Home(this.onConnectivityChanged);

  final Stream<ConnectivityResult> onConnectivityChanged;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<Widget> pages = [Feed(), Container(), Container()];
  int currentTab = 0;

  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription =
        widget.onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
// Вызовете удаление Overlay тут
          break;
        case ConnectivityResult.mobile:
// Вызовете удаление Overlay тут
          break;
        case ConnectivityResult.none:
// Вызовете отображения Overlay тут
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 8,
        curve: Curves.ease,
        onItemSelected: (int index) async {
          //   if (index == 1) {
          //     var value = await Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Demo()));
          //     print(value);
          //   } else {
          setState(() {
            currentTab = index;
          });
          //   }
        },
        currentTab: currentTab,
        items: [
          BootomNavyBarItem(
            asset: AppIcons.home,
            title: Text('Feed'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
          BootomNavyBarItem(
            asset: AppIcons.like,
            title: Text('Searh'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
          BootomNavyBarItem(
            asset: AppIcons.like_fill,
            title: Text('User'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
        ],
      ),
      body: pages[currentTab],
    );
  }
}

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar(
      {Key key,
      this.backgroundColor = Colors.white,
      this.showElevation = true,
      this.containerHeigt = 56,
      this.items,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.onItemSelected,
      this.currentTab,
      this.animaitionDuration = const Duration(milliseconds: 270),
      this.itemCornerRadius = 25,
      this.curve})
      : super(key: key);

  final Color backgroundColor;
  final bool showElevation;
  final double containerHeigt;
  final MainAxisAlignment mainAxisAlignment;
  final List<BootomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentTab;
  final Duration animaitionDuration;
  final double itemCornerRadius;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor, boxShadow: [
        if (showElevation) const BoxShadow(color: Colors.black12, blurRadius: 2)
      ]),
      child: SafeArea(
          child: Container(
        width: double.infinity,
        height: containerHeigt,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: items.map((item) {
            var index = items.indexOf(item);
            return GestureDetector(
              onTap: () => onItemSelected(index),
              child: _ItemWidget(
                curve: curve,
                animationDuration: animaitionDuration,
                backgroundColor: backgroundColor,
                isSelected: currentTab == index,
                itemCornerRadius: itemCornerRadius,
                item: item,
              ),
            );
          }).toList(),
        ),
      )),
    );
  }
}

class BootomNavyBarItem {
  BootomNavyBarItem({
    this.asset,
    this.title,
    this.activeColor,
    this.inactiveColor,
    this.textAlign,
  }) {
    assert(asset != null, 'Asset is null');
    assert(title != null, 'Title is null');
  }

  final IconData asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
}

class _ItemWidget extends StatelessWidget {
  final bool isSelected;
  final BootomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;
  final double itemCornerRadius;

  _ItemWidget({
    @required this.isSelected,
    @required this.item,
    @required this.backgroundColor,
    @required this.animationDuration,
    @required this.itemCornerRadius,
    this.curve = Curves.linear,
  })  : assert(animationDuration != null, 'animationDuration is null'),
        assert(isSelected != null, 'isSelected is null'),
        assert(item != null, 'item is null'),
        assert(itemCornerRadius != null, 'itemCornerRadius is null'),
        assert(backgroundColor != null, 'backgroundColor is null');

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: isSelected
          ? 150
          : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
      curve: curve,
      decoration: BoxDecoration(
          color:
              isSelected ? item.activeColor.withOpacity(.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius)),
      child: Row(
        children: <Widget>[
          Icon(item.asset,
              size: 20,
              color: isSelected ? item.activeColor : item.inactiveColor),
          SizedBox(width: 4),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: DefaultTextStyle.merge(
                child: item.title,
                textAlign: item.textAlign,
                maxLines: 1,
                style: TextStyle(
                  color: isSelected ? item.activeColor : item.inactiveColor,
                  fontWeight: FontWeight.bold,
                )),
          ))
        ],
      ),
    );
  }
}

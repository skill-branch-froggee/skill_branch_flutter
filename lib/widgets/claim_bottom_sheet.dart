import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  final List<String> claim = [
    'adult',
    'harm',
    'bully',
    'spam',
    'copyright',
    'hate'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: claim.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
              //    crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildClaimItem(context, index),
                Divider(
                  thickness: 2,
                ),
              ]);
        });
  }

  Widget _buildClaimItem(BuildContext context, int index) {
    return Material(
        //animationDuration: Duration(seconds: 2),
        child: InkWell(
      splashColor: Colors.blueAccent,
      child: Container(
        constraints: BoxConstraints.tightForFinite(height: 40),
        alignment: Alignment.center,
        child: Text(
          claim[index].toUpperCase(),
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      onTap: () {
        // Future.delayed(Duration(seconds: 10));
        Navigator.pop(context);
      },
    ));
  }
}

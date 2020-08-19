import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar(this.avatarLink);

  final String avatarLink;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      child: CachedNetworkImage(
        imageUrl: avatarLink,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
        width: 40,
        height: 40,
        fit: BoxFit.fill,
      ),
    );
  }
}

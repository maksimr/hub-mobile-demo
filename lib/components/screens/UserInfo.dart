import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final Map userInfo;

  UserInfo(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new InkWell(
        onTap: () => _navigateBack(context),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new _UserAvatar(userInfo),
            new _UserName(userInfo),
          ],
        ),
      ),
    );
  }

  _navigateBack(context) {
    Navigator.of(context).pop();
  }
}

class _UserName extends StatelessWidget {
  final Map userInfo;

  _UserName(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.only(top: 2 * 8.0),
      child: new Text(
        userInfo["name"],
        style: new TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final Map userInfo;

  _UserAvatar(this.userInfo);

  @override
  Widget build(BuildContext context) {
    final userAvatarUrl = userInfo["profile"]["avatar"]["url"];
    return new CircleAvatar(
      radius: 50.0,
      backgroundImage: new NetworkImage(userAvatarUrl),
    );
  }
}

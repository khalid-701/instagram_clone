import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton(
      {Key key, @required this.isCurrentUser, @required this.isFollowing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? FlatButton(
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
            child: const Text(
              "Edit Profile",
              style: TextStyle(fontSize: 16),
            ),
          )
        : FlatButton(
            textColor: isFollowing ? Colors.black : Colors.white,
            color:
                isFollowing ? Colors.grey[300] : Theme.of(context).primaryColor,
            onPressed: () {},
            child: Text(
              isFollowing ? "Unfollow" : "Following",
              style: TextStyle(fontSize: 16),
            ),
          );
  }
}

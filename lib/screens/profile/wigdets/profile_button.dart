import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/screens/edit_profile/edit_profile_screen.dart';
import 'package:instagram_clone/screens/profile/bloc/profile_bloc.dart';

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
            onPressed: () => Navigator.of(context).pushNamed(
                EditProfileScreen.routeName,
                arguments: EditProfileScreenArgs(context: context)),
            child: const Text(
              "Edit Profile",
              style: TextStyle(fontSize: 16),
            ),
          )
        : FlatButton(
            textColor: isFollowing ? Colors.black : Colors.white,
            color:
                isFollowing ? Colors.grey[300] : Theme.of(context).primaryColor,

      //implement follower and following
            onPressed: () => isFollowing ? context.read<ProfileBloc>().add(ProfileUnfollowUser()) :
            context.read<ProfileBloc>().add(ProfileFollowUser()),
            child: Text(
              isFollowing ? "Unfollow" : "Following",
              style: TextStyle(fontSize: 16),
            ),
          );
  }
}

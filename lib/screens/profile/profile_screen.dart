import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/blocs/blocs.dart';
import 'package:instagram_clone/screens/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/screens/profile/wigdets/profile_info.dart';
import 'package:instagram_clone/widgets/widgets.dart';

import 'wigdets/profile_stats.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showDialog(
              context: context,
              builder: (context) =>
                  ErrorDialog(content: state.failure.message));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.user.username),
            actions: [
              if (state.isCurrentUser)
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () =>
                      context.read<AuthBloc>().add(AuthLogoutRequested()),
                )
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                      child: Row(
                        children: [
                          UserProfileImage(
                            radius: 40,
                            profileImageUrl: state.user.profileImageUrl,
                          ),
                          ProfileStats(
                            isCurrentUser: state.isCurrentUser,
                            isFollowing: state.isFollowing,
                            followers: state.user.followers,
                            following: state.user.following,
                            posts: 0, //state.posts.length
                          ),

                        ],
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal:30, vertical: 10),
                    child: ProfileInfo(
                      username: state.user.username,
                      bio: state.user.bio
                    ),)
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

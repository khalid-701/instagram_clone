part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadUser extends ProfileEvent {
  final String userId;

  const ProfileLoadUser({@required this.userId});

  @override
  List<Object> get props => [userId];
}

//handle toggle grid and list view
class ProfileToggleGridView extends ProfileEvent {
  final bool isGridView;

  const ProfileToggleGridView({@required this.isGridView});

  @override
  List<Object> get props => [isGridView];
}


class ProfileUpdatePosts extends ProfileEvent{
  final List<Post> posts;

  const ProfileUpdatePosts({@required this.posts});
  @override
  // TODO: implement props
  List<Object> get props => [posts];
}

//implement follower and following
class ProfileFollowUser extends ProfileEvent{}

class ProfileUnfollowUser extends ProfileEvent{}

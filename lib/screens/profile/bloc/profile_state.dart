part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, error }

@immutable
class ProfileState extends Equatable {
  final User user;

   final List<Post> posts;
  final bool isCurrentUser;
  final bool isGridView;
  final bool isFollowing;
  final ProfileStatus status;
  final Failure failure;

  ProfileState copyWith({
    final User user,
    final List<Post> posts,
    final bool isCurrentUser,
    final bool isGridView,
    final bool isFollowing,
    final ProfileStatus status,
    final Failure failure,
  }) {
    return ProfileState(
      user: user ?? this.user,
      posts: posts ?? this.posts,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      isGridView: isGridView ?? this.isGridView,
      isFollowing: isFollowing ?? this.isFollowing,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  const ProfileState(
      {@required this.user,
      @required this.isCurrentUser,
      @required this.posts,
      @required this.isGridView,
      @required this.isFollowing,
      @required this.status,
      @required this.failure});

  //1.
  factory ProfileState.initial() {
    return const ProfileState(
      user: User.empty,
      posts: [],
      isCurrentUser: false,
      isGridView: true,
      isFollowing: false,
      status: ProfileStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object> get props =>
      [user, isCurrentUser, isGridView, isFollowing, status, failure, posts];
}

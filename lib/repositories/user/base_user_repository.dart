import 'package:instagram_clone/models/models.dart';

abstract class BaseUserRepository {
  Future<User> getUserWithId({String userId});

  Future<void> updateUser({User user});

  Future<List<User>> searchUsers({String query});

  //implement follower and following
  void followUser({String userId, String followUserId});
  void unfollowUser({String userId, String unfollowUserId});
  Future<bool> isFollowing ({String  userId, String otherUserId});
}
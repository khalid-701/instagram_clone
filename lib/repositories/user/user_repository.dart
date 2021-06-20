import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/config/paths.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/repositories/repositories.dart';
import 'package:meta/meta.dart';

class UserRepository extends BaseUserRepository {
  //membuat dependensi di firebase data store
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<User> getUserWithId({@required String userId}) async {
    //read document from firebase and store to user model
    final doc =
        await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    return doc.exists ? User.fromDocument(doc) : User.empty;
  }

  @override
  Future<void> updateUser({@required User user}) async {
    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user.id)
        .update(user.toDocument());
  }
}

const functions = require("firebase-functions");

const admin = require('firebase-admin');

admin.initializeApp();

exports.onFollowers = functions.firestore.document('/followers/{userId}/userFollowers/{followerId}').onCreate(async (_, context) => {
    const userId = context.params.userId;
    const followerId = context.params.followerId;

    // Increment followed user followers count
    const followedUserRef = admin.firestore().collection('users').doc(userId);
    const followedUserDoc = await followedUserRef.get();
    if (followedUserDoc.get('followers') !== undefined) {
        followedUserRef.update({
            followers: followedUserDoc.get('followers') + 1,
        });
    } else {
        followedUserRef.update({ followers: 1 })
    }


    //increment users following count
    const userRef = admin.firestore().collection('users').doc(followerId);
    const userDoc = await userRef.get();
    if (userDoc.get('following') !== undefined) {
        userRef.update({
            following: userDoc.get('following') + 1,
        }

        );
    } else {
        userRef.update({ following: 1 });
    }

    //Add followed users posts to user's post feed
    const followedUserPostsRef = admin
    .firestore()
    .collection('posts')
    .where('author', '==', followedUserRef);

    const userFeedRef = admin
    .firestore()
    .collection('feeds')
    .doc(followerId)
    .collection('userFeed');

    const followedUserPostsSnapshot= await followedUserPostsRef.get();
    followedUserPostsSnapshot.forEach((doc) => {
        if (doc.exists){
            userFeedRef.doc(doc.id).set(doc.data());
        }
    });



});

exports.onUnfollowUser = functions.firestore
.document('/followers/{userId}/userFollowers/{followerId}')
.onDelete(async (_, context) => {
    const userId = context.params.userId;
    const followerId = context.params.followerId;

    //Decrement unfollowed users followers count
    const followedUserRef = admin.firestore().collection('users').doc(userId);
    const followedUserDoc = await followedUserRef.get();
    if (followedUserDoc.get('followers') !== undefined) {
        followedUserRef.update({
            followers: followedUserDoc.get('followers') - 1,
        });
    } else {
        followedUserRef.update({ followers: 0 })
    }

    //Decreent users following count

    const userRef = admin.firestore().collection('users').doc(followerId);
    const userDoc = await userRef.get();
    if (userDoc.get('following') !== undefined) {
        userRef.update({
            following: userDoc.get('following') - 1,
        }

        );
    } else {
        userRef.update({ following: 0 });
    }


    //Remove unfollowed users post from user post feed 
    const userFeedRef = admin
    .firestore()
    .collection('feeds')
    .doc(followerId)
    .collection('userFeed')
    .where('author', '==', followedUserRef);

    const userPostsSnapshot =  await userFeedRef.get();
    userPostsSnapshot.forEach((doc) => {
        if (doc.exists) {
            doc.ref.delete();
        }
    });

    //gabisa lanjut ke bagian payment karna ga punya kartunya video ke 44. Cloud Functions Follow and Unfollow Users 
    //run firebase deploy in terminal


});


exports.onCreatePost = functions.firestore.document('/posts/{post}')
.onCreate(async (snapshot, context) => {
    const postId = context.params.postId;

    // Get author id.
    const authorRef = snapshot.get('author');
    const authorId = authorRef.path.split('/')[1];

    // Add new post to feeds of all followers.
    const userFollowersRef = admin
      .firestore()
      .collection('followers')
      .doc(authorId)
      .collection('userFollowers');
    const userFollowersSnapshot = await userFollowersRef.get();
    userFollowersSnapshot.forEach((doc) => {
      admin
        .firestore()
        .collection('feeds')
        .doc(doc.id)
        .collection('userFeed')
        .doc(postId)
        .set(snapshot.data());
    });
  });

  exports.onUpdatePost = functions.firestore
  .document('/posts/{postId}')
  .onUpdate(async (snapshot, context) => {
    const postId = context.params.postId;

    // Get author id.
    const authorRef = snapshot.after.get('author');
    const authorId = authorRef.path.split('/')[1];

    // Update post data in each follower's feed.
    const updatedPostData = snapshot.after.data();
    const userFollowersRef = admin
      .firestore()
      .collection('followers')
      .doc(authorId)
      .collection('userFollowers');
    const userFollowersSnapshot = await userFollowersRef.get();
    userFollowersSnapshot.forEach(async (doc) => {
      const postRef = admin
        .firestore()
        .collection('feeds')
        .doc(doc.id)
        .collection('userFeed');
      const postDoc = await postRef.doc(postId).get();
      if (postDoc.exists) {
        postDoc.ref.update(updatedPostData);
      }
    });
  });

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

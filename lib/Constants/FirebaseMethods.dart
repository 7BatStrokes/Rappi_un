import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rappi_un/Constants/AppRepository.dart';

//This Might come in handy someday
//String docId;
//    QuerySnapshot result = await fire
//        .collection("users")
//        .where("email", isEqualTo: currentUser.email)
//        .getdocs();
//
//    List<DocumentSnapshot> g = result.docs;
//    print("Hi I want to know my id, is it this one? " + currentUser.uid);
//    for (var i in g) {
//      print(i.docID);
//    }
//    docId = g[0].docID;

AppRepo _apprepo = AppRepo();

class FireMethods {
  static final FirebaseFirestore fire = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  AppRepo _appRepo = AppRepo();

  //Gets Current User
  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _auth.currentUser!;
    return currentUser;
  }

  //Gets Current Username
  Future<String> getMyUsername() async {
    String myu = "";
    User currentUser;
    currentUser = _auth.currentUser!;

    QuerySnapshot query =  await fire
        .collection("users")
        .where("uid", isEqualTo: currentUser.uid)
        .get();
    myu = query.docs[0]["username"];

    return myu;
  }

  //Signs In with Google
  Future<User> gSignIn(String y) async {
    if (y == null) {
      try {
        _googleSignIn.signOut();
      } catch (e) {
        print("Error signing out: ");
        print(e);
      }
    }
    GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
    var us;
    if (signInAccount == null) {
      us = null;
    } else {
      GoogleSignInAuthentication _signInAuthen =
          await signInAccount.authentication;
      final AuthCredential cred = GoogleAuthProvider.credential(
          idToken: _signInAuthen.idToken,
          accessToken: _signInAuthen.accessToken);
      User? user = (await _auth.signInWithCredential(cred)).user;
      us = user;
      print(user!.email);
    }

    return us;
  }

  //Signs Out with Google
  Future<void> sadlySignOut() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
    return await _auth.signOut();
  }

  //Checks if Signed In with Google
  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  //Check if Google User is Signing for the first time
  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await fire
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get();
    final List<DocumentSnapshot> doc = result.docs;

    return doc.length == 0 ? true : false;
  }

  //Firebase updates both Normal and Google User's data
  Future<void> updatelastdateDatatoDb(User currentUser) async {
    DocumentReference docRef = fire.collection("users").doc(currentUser.uid);
    docRef.update({
      "lastdate": DateTime.now(),
    });
  }

  Future<void> updateUsername(String newname) async {
    User user = await getCurrentUser();
    String currentname = await getMyUsername();

    try {
      fire.collection("users").doc(user.uid).update(
          {"username": newname, "key": newname.toLowerCase().substring(0, 1)});

      DocumentReference docRef =
          fire.collection("names").doc("KZAAyKRJXPqbDSbqEgwI");
      docRef.update({
        "usernames": FieldValue.arrayRemove([currentname])
      });
      docRef.update({
        "usernames": FieldValue.arrayUnion([newname])
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> changeUsername(String x) async {
    String allusers = " ";
    try {
      await fire.collection("names").get().then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((f) {
          allusers = ('${f['usernames']}');
        });
      });
    } catch (E) {
      print(E);
    }
    bool b = await _apprepo.wordingNew(allusers, x);

    return b;
  }

  //Firebase gets both Normal and Google User's data
  Future<void> addUserDatatoDb(
      User currentUser, String email) async {
    fire.collection("users").doc(currentUser.uid).set({
      "email": currentUser.email != null ? currentUser.email : email,
      "firstdate": DateTime.now(),
      "lastdate": DateTime.now(),
      "uid": currentUser.uid,
      "profpic": Random().nextInt(21)
    });
  }

  //Adds Friend to Database
  Future<void> receivingFriendRequest(
      bool add, String frienduid, String friendName) async {
    User cu = await getCurrentUser();
    String myusername = await getMyUsername();

    print(frienduid);
    if (add) {
      try {
        DocumentReference myRef = fire
            .collection("users")
            .doc(cu.uid)
            .collection("myfriends")
            .doc(frienduid);

        myRef.set({
          "uid": frienduid,
          "key": friendName.toLowerCase().substring(0, 1),
          "username": friendName,
        });
        DocumentReference friendRef = fire
            .collection("users")
            .doc(frienduid)
            .collection("myfriends")
            .doc(cu.uid);
        friendRef.set({
          "uid": cu.uid,
          "key": myusername.toLowerCase().substring(0, 1),
          "username": myusername,
        });
      } catch (e) {
        print(e);
      }
    }

    fire
        .collection("users")
        .doc(cu.uid)
        .collection("newfriends")
        .doc(frienduid)
        .delete();
    try {
      fire
          .collection("users")
          .doc(frienduid)
          .collection("newfriends")
          .doc(cu.uid)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> didIRequestAlready(String frienduid) async {
    User cu = await getCurrentUser();
    bool d = false;

    QuerySnapshot didreq = await fire
        .collection("users")
        .doc(frienduid)
        .collection("newfriends")
        .get();

    for (var i in didreq.docs) {
      if (i.id == cu.uid) {
        d = true;
      }
    }

    return d;
  }

  Future<void> requestFriend(String frienduid) async {
    bool canI = await didIRequestAlready(frienduid);

    if (!canI) {
      User cu = await getCurrentUser();
      String myusername = "";
      int profpic = 0;

      QuerySnapshot query = await fire.collection("users").get();
      for (var i in query.docs) {
        if (i.id == cu.uid) {
          myusername = i["username"];
          profpic = i["profpic"];
        }
      }

      DocumentReference requestRef = fire
          .collection("users")
          .doc(frienduid)
          .collection("newfriends")
          .doc(cu.uid);

      try {
        requestRef.set({
          "uid": cu.uid,
          "date": _appRepo.givemedatepls(),
          "username": myusername,
          "profpic": profpic,
        });
      } catch (e) {
        print(e);
      }
    }
  }

  //Sends Friend to Database
  Future<void> removeFriend(String frienduid) async {
    User cu = await getCurrentUser();

    DocumentReference myRef = fire
        .collection("users")
        .doc(cu.uid)
        .collection("myfriends")
        .doc(frienduid);

    DocumentReference friendRef = fire
        .collection("users")
        .doc(frienduid)
        .collection("myfriends")
        .doc(cu.uid);

    await myRef.delete();
    await friendRef.delete();
  }

  //Searches for new/already friend
  Future<List<DocumentSnapshot>> searchforFriend(
      bool addfriend, String search) async {
    User cu = await getCurrentUser();
    List<DocumentSnapshot> retr = [];

    if (addfriend) {
      QuerySnapshot result = await fire
          .collection("users")
          .where("key", isEqualTo: search.toLowerCase())
          .get();

      for (var i in result.docs) {
        retr.add(i);
      }
    } else {
      QuerySnapshot result = await fire
          .collection("users")
          .doc(cu.uid)
          .collection("myfriends")
          .where("key", isEqualTo: search.toLowerCase())
          .get();

      for (var i in result.docs) {
        retr.add(i);
      }
    }
    return retr;
  }

  Future<List<DocumentSnapshot>> initiaterequests() async {
    User cu = await getCurrentUser();
    List<DocumentSnapshot> requests = [];

    QuerySnapshot query = await fire
        .collection("users")
        .doc(cu.uid)
        .collection("newfriends")
        .get();

    for (var i in query.docs) {
      requests.add(i);
    }

    return requests;
  }

  Future<bool> ismyFriend(String search) async {
    User cu = await getCurrentUser();
    List<DocumentSnapshot> friends = [];

    QuerySnapshot query = await fire
        .collection("users")
        .doc(cu.uid)
        .collection("myfriends")
        .where("uid", isEqualTo: search)
        .get();

    for (var i in query.docs) {
      friends.add(i);
    }

    if (friends.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getProfilePic(String uid) async {
    DocumentSnapshot doc = await fire.collection("users").doc(uid).get();

    int number = doc["profpic"];
    String st = 'images/$number.png';

    return st;
  }
  Future<List<DocumentSnapshot>> getRestaurants() async {
    List<DocumentSnapshot> restaurants = [];
    QuerySnapshot query = await fire
        .collection("restaurantes")
        .get();

    for (var i in query.docs) {
      restaurants.add(i);
    }
    return restaurants;
  }

  Future<List<DocumentSnapshot>> getPeticiones() async{
    List<DocumentSnapshot> peticiones = [];
    QuerySnapshot query = await fire.collection("peticiones").get();
    for(var i in query.docs){
      peticiones.add(i);
    }
    return peticiones;
  }

}

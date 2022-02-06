import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rappi_un/Constants/FirebaseMethods.dart';

class FireRepo {
  FireMethods _fireMethods = FireMethods();

  Future<User> getCurrentUser() => _fireMethods.getCurrentUser();

  Future<User> gSignIn(String writesomethingifsignOut) =>
      _fireMethods.gSignIn(writesomethingifsignOut);

  Future<bool> authenticateUser(User user) =>
      _fireMethods.authenticateUser(user);

  Future<void> updatelastdateDatatoDb(User user) =>
      _fireMethods.updatelastdateDatatoDb(user);

  Future<void> addUserDatatoDb(User user, String email) =>
      _fireMethods.addUserDatatoDb(user, email);

  Future<void> sadlySignOut() => _fireMethods.sadlySignOut();

  Future<bool> isSignedIn() => _fireMethods.isSignedIn();

  Future<void> receivingFriendRequest(
          bool add, String frienduid, String friendName) =>
      _fireMethods.receivingFriendRequest(add, frienduid, friendName);

  Future<List<DocumentSnapshot>> initiaterequests() =>
      _fireMethods.initiaterequests();

  Future<void> requestFriend(String frienduid) =>
      _fireMethods.requestFriend(frienduid);

  Future<bool> didIRequestAlready(String frienduid) =>
      _fireMethods.didIRequestAlready(frienduid);

  Future<void> removeFriend(String frienduid) =>
      _fireMethods.removeFriend(frienduid);

  Future<List<DocumentSnapshot>> searchforFriend(
          bool addfriend, String search) =>
      _fireMethods.searchforFriend(addfriend, search);

  Future<String> getMyUsername() => _fireMethods.getMyUsername();

  Future<bool> ismyFriend(String search) async =>
      _fireMethods.ismyFriend(search);

  Future<void> updateUsername(String username) =>
      _fireMethods.updateUsername(username);

  Future<bool> changeUsername(String username) =>
      _fireMethods.changeUsername(username);

  Future<String> getProfilePic(String uid) => _fireMethods.getProfilePic(uid);

  Future<List<DocumentSnapshot>>  getRestaurants() => _fireMethods.getRestaurants();

  Future<List<DocumentSnapshot>>  getPeticiones() => _fireMethods.getPeticiones();

  Future<DocumentSnapshot>  getdatos(String email) => _fireMethods.getdatos(email);
}

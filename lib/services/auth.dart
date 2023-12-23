import 'package:brew_crew/models/MyUser.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create MyUser object based on FirebaseUser
  MyUser? _userFromfFirebaseUser(User? user){
    return user != null ? MyUser(uid: user.uid) :null;
  }

  // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
     .map((User? user) => _userFromfFirebaseUser(user));
    //.map(_userFromfFirebaseUser(user));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromfFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;

    }
  }
    //sign in with email&password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid:user!.uid).updateUserData('0','new crew member',100);
      return _userFromfFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

    //register with email&password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromfFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

    //sign out

    Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
    print(e.toString());
    return null;
  }
  }
}
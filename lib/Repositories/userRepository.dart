import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _fireBaseAuth;
  final GoogleSignIn _googleSignIn;
  
  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
    : _fireBaseAuth = firebaseAuth ?? FirebaseAuth.instance,
    _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken);
    await _fireBaseAuth.signInWithCredential(credential);
    return _fireBaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password){
    return _fireBaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp({String email, String password}) async{
    return await _fireBaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password);
  }

  Future<void> signOut() async {
    return Future.wait([
     _fireBaseAuth.signOut(),
     _googleSignIn.signOut() 
    ]);
  }

  Future<bool> isSignIn() async{
    final currentUser = await _fireBaseAuth.currentUser();
    return currentUser != null;
  }  
  
  Future<FirebaseUser> getCurrentUser() async{
    return await _fireBaseAuth.currentUser();
  }

}
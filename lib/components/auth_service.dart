import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  FirebaseUser user;
  Map<String, dynamic> profile;

  Future<bool> googleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      if (credential != null) {
        final AuthResult authResult =
            await _auth.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;
        assert(user.email != null);
        assert(user.displayName != null);
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);

        if (user != null) {
          updateUserData(user);
          print("signed in " + user.displayName);
        } else {
          print("user can't be null");
          return false;
        }
      } else {
        print("user can't be null");
        return false;
      }
    } else {
      print("user can't be null");
      return false;
    }
    return true;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document('${user.email}');

    profile = {
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'phoneNr': user.phoneNumber,
      'lastSeen': DateTime.now(),
    };

    return await ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'phoneNr': user.phoneNumber,
      'lastSeen': DateTime.now(),
    }, merge: true);
  }

  void signOut() {
    _googleSignIn.signOut();
    _auth.signOut();
    print('user sign out!!!');
  }
}

final AuthService authService = AuthService();

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {

  signInWithGoogle() async {
    
    final GoogleSignInAccount? gUSer = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUSer!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  }

  signInWithEmailPassword(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }

  registerWithEmailPassword(String email, String password) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();
      return true;
    } catch (e) {
      print("Error while signout!");
      return false;
    }
  }
}

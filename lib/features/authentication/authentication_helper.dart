import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_management/utilities/appconfigs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Sign up successful, return null for no error
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message if sign up fails
    }
  }

  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    final pref = await  SharedPreferences.getInstance();
    bool? loggedstate = pref.getBool(AppConfig.loggedStateKey);
    print('loggedstate $loggedstate');
    return (loggedstate ?? false);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

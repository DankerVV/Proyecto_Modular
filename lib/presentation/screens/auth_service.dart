import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<void> signIn(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _saveUserSession(userCredential.user?.uid);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _clearUserSession();
  }

  Future<UserCredential> register(String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _saveUserSession(userCredential.user?.uid);
    return userCredential;
  }

  //Guardar sesión del usuario
  Future<void> _saveUserSession(String? userId) async {
    if (userId != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userId);
    }
  }

  //Cargar sesión del usuario
  Future<String?> loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  //Limpiar sesión del usuario
  Future<void> _clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_ar/screens/loginSignup/login_page.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

login(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return "Success";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return ('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      return ('Wrong password provided for that user.');
    } else {
      return (e.code);
    }
  }
}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();

  test("check login", () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
          email: "test@test.com", password: "test123"),
    );
    expect(await login("test@test.com", "test123"), "Success");
  });
}

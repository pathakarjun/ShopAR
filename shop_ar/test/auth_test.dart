import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_ar/services/auth.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser,
    ]);
  }
}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockFirebaseAuth);
  setUp(() {});
  tearDown(() {});

  test("emit occurs", () async {
    expectLater(auth.user, emitsInOrder([_mockUser]));
  });

  test("create an account for user", () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
          email: "test@test.com", password: "test123"),
    );

    expect(
        await auth.createAccount(email: "test@test.com", password: "test123"),
        "Success");
  });

  test("sign in or login / Authentication", () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
          email: "test@test.com", password: "test123"),
    );

    expect(await auth.signIn(email: "test@test.com", password: "test123"),
        "Success");
  });

  test("sign in exception/ Authentication error", () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
          email: "test@test.com", password: "test123"),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "Error", code: ''));

    expect(await auth.signIn(email: "test@test.com", password: "test123"),
        "Error");
  });

  test("sign out/ Log out", () async {
    when(
      mockFirebaseAuth.signOut(),
    );

    expect(await auth.signOut(), "Success");
  });

 
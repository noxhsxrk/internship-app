import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class InternshipFirebaseUser {
  InternshipFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

InternshipFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<InternshipFirebaseUser> internshipFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<InternshipFirebaseUser>(
            (user) => currentUser = InternshipFirebaseUser(user));

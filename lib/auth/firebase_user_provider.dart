import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MCXTTokenFirebaseUser {
  MCXTTokenFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

MCXTTokenFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MCXTTokenFirebaseUser> mCXTTokenFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<MCXTTokenFirebaseUser>(
      (user) {
        currentUser = MCXTTokenFirebaseUser(user);
        return currentUser!;
      },
    );

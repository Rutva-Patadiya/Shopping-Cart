import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc()
    : super(
        const EmptyAuthState(
          isLoading: false,
          obscureText: true,
          confirmPass: true,
        ),
      ) {
    on<AppStarted>(_handleAppStarted);
    on<SignUpStarted>(_handleSignUp);
    on<LoginStarted>(_handleLogin);
    on<PasswordVisibilityToggled>(_handlePasswordVisibility);
    on<ConfirmPassVisibilityToggled>(_handleConfirmPasswordVisibility);
    on<LoggedOut>(_handleLogOut);
  }

  Future<void> _handleAppStarted(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    final user = _auth.currentUser;

    if (user != null) {
      emit(
        AuthSuccess(
          photoUrl: user.photoURL,
          name: user.displayName,
          email: user.email,
        ),
      );
    } else if (user == null) {
      emit(AuthInitial());
      await _auth.signOut();
    }
  }

  Future<void> _handleSignUp(
    SignUpStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      AuthInProgress(),
    ); //when this emits the state changes and bloc builder will rebuild the ui
    try {
      await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthRegistrationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? 'Unknown error'));
    }
  }

  Future<void> _handleLogin(LoginStarted event, Emitter<AuthState> emit) async {
    emit(state.withLoading());
    try {
      //if user exists with correct credentials then stores user credentials in it
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      final user = userCredential.user;
      final token = await user?.getIdToken();

      log('Email: ${event.email}');
      log('Password: ${event.password}');

      log('Token: $token');

      if (user != null) {
        user.updateDisplayName("Rutva Patadiya");
        user.updatePhotoURL(
          "https://cdn-icons-png.flaticon.com/128/12118/12118541.png",
        );
        //reload the user
        await user.reload();
        final updated = _auth.currentUser;
        emit(
          AuthSuccess(
            email: event.email,
            name: updated?.displayName,
            photoUrl: updated?.photoURL,
          ),
        );
        log('displayName: ${user.displayName}');
      } else if (user == null) {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(message: 'User not found or invalid credentials.'));
    }
  }

  Future<void> _handlePasswordVisibility(
    PasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        obscureText: !state.obscureText,
        confirmPass: state.confirmPass,
      ),
    );
  }

  Future<void> _handleConfirmPasswordVisibility(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(confirmPass: !state.confirmPass));
  }

  Future<void> _handleLogOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    await _auth.signOut();
    emit(AuthLogOutSuccess());
  }
}

// on<SignUpStarted>((event, emit) async {
//   emit(
//     AuthInProgress(),
//   ); //when this emits the state changes and bloc builder will rebuild the ui
//   try {
//     await _auth.createUserWithEmailAndPassword(
//       email: event.email,
//       password: event.password,
//     );
//     emit(AuthRegistrationSuccess());
//   } on FirebaseAuthException catch (e) {
//     emit(AuthFailure(message: e.message ?? 'Unknown error'));
//   }
// });
//
// // It will be called when the app starts to check if the user is already logged in
// on<AppStarted>((event, emit) async {
//   final user = _auth.currentUser;
//
//   if (user != null) {
//     emit(
//       AuthSuccess(
//         photoUrl: user.photoURL,
//         name: user.displayName,
//         email: user.email,
//       ),
//     );
//   } else if (user == null) {
//     emit(AuthInitial());
//     await _auth.signOut();
//   }
// });
//
// on<LoginStarted>((event, emit) async {
//   emit(AuthInProgress());
//
//   try {
//     //if user exists with correct credentials then stores user credentials in it
//     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//       email: event.email,
//       password: event.password,
//     );
//
//     final user = userCredential.user;
//     final token = await user?.getIdToken();
//
//     log('Email: ${event.email}');
//     log('Password: ${event.password}');
//
//     log('Token: $token');
//
//     if (user != null) {
//       user.updateDisplayName("Rutva Patadiya");
//       user.updatePhotoURL(
//         "https://cdn-icons-png.flaticon.com/128/12118/12118541.png",
//       );
//       //reload the user
//       await user.reload();
//       final updated = _auth.currentUser;
//       emit(
//         AuthSuccess(
//           email: event.email,
//           name: updated?.displayName,
//           photoUrl: updated?.photoURL,
//         ),
//       );
//       log('displayName: ${user.displayName}');
//     } else if (user == null) {
//       emit(AuthInitial());
//     }
//   } catch (e) {
//     emit(AuthFailure(message: 'User not found or invalid credentials.'));
//   }
// });
//
// // Text visibility toggle (e.g., for password visibility)
// on<PasswordVisibilityToggled>((event, emit) {
//   emit(
//     state.copyWith(
//       obscureText: !state.obscureText,
//       confirmPass: state.confirmPass,
//     ),
//   );
// });
//
// on<ConfirmPassVisibilityToggled>((event, emit) async {
//   emit(state.copyWith(confirmPass: !state.confirmPass));
// });
//
// on<LoggedOut>((event, emit) async {
//   emit(AuthInProgress());
//   await _auth.signOut();
//   emit(AuthLogOutSuccess());
// });
// }

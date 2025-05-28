import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(const AuthState()) {
    on<SignUpStarted>((event, emit) async {
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
    });

    on<AppStarted>((event, emit) async {
      final user = _auth.currentUser;

      if (user != null) {
        emit(AuthSuccess());
      } else if (user == null) {
        emit(AuthInitial());
        await _auth.signOut();
      }
    });

    on<LoginStarted>((event, emit) async {
      emit(AuthInProgress());

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        final user = userCredential.user;

        log('Email: ${event.email}');
        log('Password: ${event.password}');

        if (user != null) {
          emit(AuthSuccess(email: event.email, password: event.password));
        } else if (user == null) {
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthFailure(message: 'User not found or invalid credentials.'));
      }
    });

    // Text visibility toggle (e.g., for password visibility)
    on<PasswordVisibilityToggled>((event, emit) {
      emit(
        state.copyWith(
          obscureText: !state.obscureText,
          confirmPass: state.confirmPass,
        ),
      );
    });

    on<ConfirmPassVisibilityToggled>((event, emit) async {
      emit(state.copyWith(confirmPass: !state.confirmPass));
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthInProgress());
      await _auth.signOut();
      emit(AuthLogOutSuccess());
    });
  }
}

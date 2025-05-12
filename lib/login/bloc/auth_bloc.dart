import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  LoginBloc() : super(const AuthState()) {
    on<SignUpRequested>((event, emit) async {
      emit(
        AuthLoading(),
      ); //when this emits the state changes and bloc builder will rebuild the ui
      try {
        await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(UserCreated());
      } on FirebaseAuthException catch (e) {
        emit(AuthError(message: e.message ?? 'Unknown error'));
      }
    });

    // Login request handler
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        // Await the result of the login request
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        //for check entered email adn pass
        log('Email: ${event.email}');
        log('Password: ${event.password}');

        // Get the user object after login attempt
        final user = userCredential.user;

        // Check if the user object exists and is email-verified
        if (user != null) {
          emit(Authenticated());
        } else {
          // If email is not verified, ask user to verify email
          emit(AuthError(message: "Please verify your email address."));
        }
      } catch (e) {
        // Handle any unexpected errors
        emit(AuthError(message: 'User not Found'));
      }
    });

    // Text visibility toggle (e.g., for password visibility)
    on<TextVisibility>((event, emit) {
      emit(
        state.copyWith(
          obscureText: !state.obscureText,
          confirmPass: state.confirmPass,
        ),
      );
    });

    on<ConfirmPass>((event, emit) async {
      emit(state.copyWith(confirmPass: !state.confirmPass));
    });

    on<LogOut>((event, emit) async {
      emit(AuthLoading());

      await _auth.signOut();
      emit(LogOutUser());
    });
  }
}

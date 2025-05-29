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
        user.updateDisplayName("Rutva Patadiya");
        user.updatePhotoURL(
          "https://img.freepik.com/free-photo/soybean-oil-soybean-food-beverage-products-food-nutrition-concept_1150-26348.jpg?ga=GA1.1.1440446866.1746703288&semt=ais_hybrid&w=740",
        );
        emit(AuthSuccess(photoUrl: user.photoURL));
      } else if (user == null) {
        emit(AuthInitial());
        await _auth.signOut();
      }
    });

    on<LoginStarted>((event, emit) async {
      emit(AuthInProgress());

      try {
        //if user exists with correct credentials then stores user credentials in it
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        final user = userCredential.user;
        final token = await user?.getIdToken();
        // final displayName = user?.displayName;
        // final imageUrl = user?.photoURL;
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
              password: event.password,
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

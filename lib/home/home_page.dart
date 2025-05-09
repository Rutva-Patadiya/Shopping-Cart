import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/theme/text_theme.dart';
import '../login/bloc/auth_bloc.dart';
import '../login/bloc/auth_event.dart';
import '../login/bloc/auth_state.dart';
import '../login/login_page.dart';

class HomePage extends StatelessWidget {
  static const route = '/Home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, AuthState>(
      listener: (context, state) {
        log("State received: $state");

        if (state is LogOutUser) {
          Navigator.pushNamed(context, Login.route);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // center vertically
            // crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
            children: [
              Text(
                "Successfully logged in....",
                style: TTextTheme.lightTextTheme.displaySmall,
              ),

              BlocBuilder<LoginBloc, AuthState>(
                builder: (context, state) {
                  return state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: ElevatedButton(
                          onPressed:
                              () => context.read<LoginBloc>().add(LogOut()),
                          child: Text("Logout", style: TextStyle(height: 0.3)),
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

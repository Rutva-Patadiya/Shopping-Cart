import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/login/bloc/auth_state.dart';

import '../core/utils/theme/text_theme.dart';
import '../login/bloc/auth_bloc.dart';
import '../login/bloc/auth_event.dart';
import '../login/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.profileTitle,
          style: TTextTheme.lightTextTheme.headlineLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.brown,
      ),
      body: BlocBuilder<LoginBloc, AuthState>(
        builder:
            (context, state) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 10),

                  state is AuthSuccess
                      ? Column(
                        children: [
                          Center(
                            child: Text(
                              'Email : ${state.email}  ${'\n Name: ${state.name}'}',
                            ),
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(state.photoUrl!),

                            onBackgroundImageError: (error, stackTrace) {
                              debugPrint("Image failed to load: $error");
                            },
                          ),
                        ],
                      )
                      : Text("not logged in"),
                  // Text(context.loc.profileName),
                  SizedBox(height: 64),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(LoggedOut());
                        Navigator.popAndPushNamed(context, Login.route);
                      },
                      child: Text(
                        context.loc.logOutButton,
                        style: TextStyle(height: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

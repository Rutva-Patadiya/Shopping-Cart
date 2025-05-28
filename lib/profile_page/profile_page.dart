import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/login/bloc/auth_state.dart';

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
        title: Text(context.loc.profileTitle),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<LoginBloc, AuthState>(
        builder:
            (context, state) => Column(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.lGreen,
                  maxRadius: 30,
                  child: Image(image: AssetImage('assets/images/profile.png')),
                  // height: 30,
                  // width: 30,
                ),

                SizedBox(height: 10),

                state is AuthSuccess
                    ? Center(
                      child: Text(
                        'Email : ${state.email!}  ${'\nPassword : ${state.password!}'}',
                      ),
                    )
                    : Text("not logged in"),
                // Text(context.loc.profileName),
                SizedBox(height: 64),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: AppColors.lGreen,
                    ),
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
    );
  }
}

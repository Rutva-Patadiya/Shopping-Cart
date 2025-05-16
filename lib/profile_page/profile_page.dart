import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

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
        title: Text("Profile"),
        // automaticallyImplyLeading: false,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.arrow_circle_left_outlined),
        //  ),

        //for left arrow
        // leading: CircleAvatar(
        //   backgroundColor: Colors.white,
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.arrow_back_outlined),
        //   ),
        // ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.lGreen,
            maxRadius: 30,
            child: Image(image: AssetImage('assets/images/profile.png')),
            // height: 30,
            // width: 30,
          ),

          SizedBox(height: 10),
          Text("Esther Howard"),
          SizedBox(height: 64),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: AppColors.lGreen,
              ),
              onPressed: () {
                context.read<LoginBloc>().add(LogOut());
                Navigator.popAndPushNamed(context, Login.route);
              },
              child: Text("Log out", style: TextStyle(height: 0.5)),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import '../login/bloc/auth_bloc.dart';
import '../login/bloc/auth_event.dart';
import '../login/bloc/auth_state.dart';
import '../login/login_page.dart';
import '../widgets/custom_textfield.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const route = '/signup';

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, AuthState>(
      listener: (context, state) {
        log("State received: $state");

        if (state is AuthRegistrationSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("User Successfully created")));
          Navigator.popAndPushNamed(context, Login.route);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),

                      Text(
                        "Sign Up Page",
                        style: TTextTheme.lightTextTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),

                      CustomTextField(
                        label: "Name",
                        keyboardType: TextInputType.name,
                        hint: "Enter your name",
                        hintStyle: TTextTheme.lightTextTheme.bodyLarge
                            ?.copyWith(color: Colors.black38),
                        obscureText: false,
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        decoration: null,
                        prefixIcon: Icons.person,
                        suffixIcon: null,
                      ),

                      SizedBox(height: 16),
                      CustomTextField(
                        // width: null,
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        hint: "abc@example.com",
                        hintStyle: TTextTheme.lightTextTheme.bodyLarge
                            ?.copyWith(color: Colors.black38),
                        obscureText: false,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        decoration: null,
                        prefixIcon: Icons.mail_outline,
                        suffixIcon: null,
                      ),

                      const SizedBox(height: 16),

                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return CustomTextField(
                            // width: null,
                            label: "Password",
                            keyboardType: TextInputType.text,
                            hint: "Password",
                            hintStyle: TTextTheme.lightTextTheme.bodyLarge
                                ?.copyWith(color: Colors.black38),
                            obscureText: state.obscureText,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              String pattern =
                                  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value)) {
                                return 'Enter a valid password';
                              }
                              return null;
                            },
                            decoration: null,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.obscureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                                size: 25,
                              ),
                              onPressed: () {
                                context.read<LoginBloc>().add(PasswordVisibilityToggled());
                              },
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 18),

                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return CustomTextField(
                            // width: null,
                            label: "Confirm Password",
                            keyboardType: TextInputType.text,
                            hint: "Confirm Password",
                            hintStyle: TTextTheme.lightTextTheme.bodyLarge
                                ?.copyWith(color: Colors.black38),
                            obscureText: state.confirmPass,
                            controller: _conPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }

                              // RegExp regex = RegExp(pattern);
                              if (value != _passwordController.text) {
                                return 'Password must match';
                              }
                              return null;
                            },
                            decoration: null,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.confirmPass
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                                size: 25,
                              ),
                              onPressed: () {
                                context.read<LoginBloc>().add(ConfirmPassVisibilityToggled());
                              },
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 16),
                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return state is AuthInProgress
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                        SignUpStarted(
                                          _emailController.text,
                                          _passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(color: Colors.white),
                                      strutStyle: StrutStyle(leading: 1.5),
                                    ),
                                  ),
                                ),
                              );
                        },
                      ),

                      SizedBox(height: 16),
                      InkWell(
                        onTap:
                            () => {
                              Navigator.popAndPushNamed(context, Login.route),
                            },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "Already Signed Up? Click here to login",
                            style: TTextTheme.lightTextTheme.labelMedium
                                ?.copyWith(
                                  color: AppColors.darkBlue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.darkBlue,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import '../login/blocs/auth_bloc.dart';
import '../login/blocs/auth_event.dart';
import '../login/blocs/auth_state.dart';
import '../login/login_page.dart';

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

        if (state is UserCreated) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("User Successfully created")));
          Navigator.pushNamed(context, Login.route);
        } else if (state is AuthError) {
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

                        prefixIcon: Icons.person,
                        suffixIcon: null,
                      ),

                      SizedBox(height: 16),
                      CustomTextField(
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
                        prefixIcon: Icons.mail_outline,
                        suffixIcon: null,
                      ),

                      const SizedBox(height: 16),

                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return CustomTextField(
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
                                context.read<LoginBloc>().add(TextVisibility());
                              },
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 18),

                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return CustomTextField(
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
                                context.read<LoginBloc>().add(ConfirmPass());
                              },
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 16),
                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return state is AuthLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                        SignUpRequested(
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
                            () => {Navigator.pushNamed(context, Login.route)},
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

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator? validator;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.keyboardType,
    required this.hint,
    required this.hintStyle,
    required this.obscureText,
    required this.controller,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 3),
          child: Text(
            label ?? ' ',
            style: TTextTheme.lightTextTheme.headlineMedium?.copyWith(
              fontFamily: 'Poppins-Light',
            ),
          ),
        ),
        // SizedBox(height: 5),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          //to validate when user interacts
          cursorColor: Colors.blueAccent,
          style: TTextTheme.lightTextTheme.bodyLarge,

          decoration: InputDecoration(
            isDense: true,
            // labelText: label,
            hintText: hint,
            // contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            hintStyle: hintStyle,
            prefixIcon: Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(prefixIcon, color: Colors.grey, size: 25),
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

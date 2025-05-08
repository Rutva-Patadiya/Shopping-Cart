import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import '../product/product_page.dart';
import 'blocs/auth_bloc.dart';
import 'blocs/auth_event.dart';
import 'blocs/auth_state.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const route = '/LoginPage';

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, AuthState>(
      listener: (context, state) {
        log("State received: $state");

        if (state is Authenticated) {
          Navigator.pushNamed(context, ProductList.route);
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
                        "Log in to E-Mart",
                        style: TTextTheme.lightTextTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 26),

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

                      //bloc builder is generally used when we want to call bloc on some event
                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return CustomTextField(
                            label: "Password",
                            keyboardType: TextInputType.text,
                            hint: "Enter Password",
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

                      InkWell(
                        onTap: () {
                          // Handle forgot password tap

                          Text("Forgot Password clicked");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Forgot Password?",
                            style: TTextTheme.lightTextTheme.labelMedium
                                ?.copyWith(color: AppColors.bgAccent),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return state is AuthLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<LoginBloc>().add(
                                          LoginRequested(
                                            _emailController.text,
                                            _passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        "Log In",
                                        style: TextStyle(color: Colors.white),
                                        strutStyle: const StrutStyle(
                                          leading: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                        },
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
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator validator;
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
            label,
            style: TTextTheme.lightTextTheme.headlineSmall?.copyWith(
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/product/product_page.dart';
import 'package:shopping_cart/signup/signup_page.dart';

import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import '../widgets/custom_textfield.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

//Login Page for User
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

        if (state is AuthSuccess) {
          Navigator.popAndPushNamed(context, ProductPage.route);
        } else if (state is AuthInitial) {
          Navigator.popAndPushNamed(context, Login.route);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is AuthLogOutSuccess) {
          Navigator.popAndPushNamed(context, Login.route);
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
                        context.loc.loginTitle,
                        style: TTextTheme.lightTextTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 26),

                      CustomTextField(
                        // width: null,
                        label: context.loc.emailLabel,
                        keyboardType: TextInputType.emailAddress,
                        hint: context.loc.emailHint,
                        hintStyle: TTextTheme.lightTextTheme.bodyLarge
                            ?.copyWith(color: Colors.black38),
                        obscureText: false,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.loc.enterEmailValidation;
                          }
                          String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return context.loc.enterEmailValidation;
                          }
                          return null;
                        },
                        prefixIcon: Icons.mail_outline,
                      ),

                      const SizedBox(height: 16),

                      //bloc builder is generally used when we want to call bloc on some event
                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return CustomTextField(
                            label: context.loc.passwordLabel,
                            keyboardType: TextInputType.text,
                            hint: context.loc.passwordHint,
                            hintStyle: TTextTheme.lightTextTheme.bodyLarge
                                ?.copyWith(color: Colors.black38),
                            obscureText: state.obscureText,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.loc.validPasswordValidation;
                              }
                              String pattern =
                                  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value)) {
                                return context.loc.validPasswordValidation;
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
                                context.read<LoginBloc>().add(
                                  PasswordVisibilityToggled(),
                                );
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
                            context.loc.forgotPassword,
                            style: TTextTheme.lightTextTheme.labelMedium
                                ?.copyWith(color: AppColors.bgAccent),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      BlocBuilder<LoginBloc, AuthState>(
                        builder: (context, state) {
                          return state is AuthInProgress
                              ? const Center(child: CircularProgressIndicator())
                              : Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<LoginBloc>().add(
                                          LoginStarted(
                                            _emailController.text,
                                            _passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        context.loc.loginButton,
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
                      InkWell(
                        onTap: () {
                          Navigator.popAndPushNamed(context, SignupPage.route);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            context.loc.noAccountText,
                            style: TTextTheme.lightTextTheme.labelMedium
                                ?.copyWith(color: AppColors.bgAccent),
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

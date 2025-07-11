// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signupTitle => 'Sign Up Page';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameHint => 'Enter your name';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'abc@example.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Confirm Password';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get alreadySignedUpText => 'Already Signed Up? Click here to login';

  @override
  String get loginTitle => 'Log in to Shopping Cart';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginButton => 'Log In';

  @override
  String get noAccountText => 'Don\'t have an account?';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileName => 'Esther Howard';

  @override
  String get logOutButton => 'Log out';

  @override
  String get enterNameValidation => 'Please enter name';

  @override
  String get enterEmailValidation => 'Please enter email';

  @override
  String get validEmailValidation => 'Enter a valid email address';

  @override
  String get enterPasswordValidation => 'Please enter password';

  @override
  String get validPasswordValidation => 'Enter a valid password';

  @override
  String get confirmPasswordValidation => 'Password must match';

  @override
  String get registrationSuccess => 'User Successfully created';

  @override
  String get authFailure => 'Authentication failed';

  @override
  String get searchHint => 'Search';

  @override
  String get categories => 'Category';

  @override
  String get failedToLoadProducts => 'Failed to load initial products';

  @override
  String get noData => 'No data found';

  @override
  String get noInternet => 'No internet connection';

  @override
  String get location => 'Location';

  @override
  String get productDetails => 'Product Details';

  @override
  String get femaleStyle => 'Female\'s Style';

  @override
  String get selectSize => 'Select Size';

  @override
  String get selectColor => 'Select Color';

  @override
  String get selectLitre => 'Select Litre';

  @override
  String get selectWeight => 'Select Weight';

  @override
  String get selectQuantity => 'Select No of Colors';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get addToCart => 'Add to Cart';
}

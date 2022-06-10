import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_news/app/router/router.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:stacked/stacked.dart';

import '../../../app/utils/snackbar.dart';
import '../../../main.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  FocusNode loginFocus = FocusNode();
  String intialCountryCode = 'BD';
  String countryCode = '99';
  int minNumberLength = 10;
  int maxNumberLength = 10;

  String? phoneValidator(PhoneNumber? number) {
    if (number != null && number.number.isEmpty) {
      return 'Mobile number cannot be empty.';
    } else if (number?.number.length != maxNumberLength) {
      return 'Enter a valid mobile number';
    }
    return null;
  }

  countryCodeChange(Country value) {
    countryCode = value.dialCode;
    debugPrint(countryCode);
    maxNumberLength = value.maxLength;
    minNumberLength = value.minLength;
    notifyListeners();
  }

  Future<void> signin() async {
    if (!_formKey.currentState!.validate()) return;
    String number = '+$countryCode${phoneController.text.trim()}';
    try {
      setBusy(true);
      await Amplify.Auth.signIn(username: number, password: 'not-needed');
      setBusy(false);

      navigatorKey.currentState!.pushNamed(
        Routes.otp,
        arguments: {
          'phone_number': phoneController.text.trim(),
          'country_code': countryCode,
        },
      );
    } catch (e) {
      setBusy(false);
      if (e is UserNotFoundException) {
        await signUp();
      } else {
        ScaffoldMessenger.maybeOf(navigatorKey.currentContext!)?.showSnackBar(
          getSnack(
            title: 'Oh snap!',
            msg: (e as AmplifyException).message,
            type: ContentType.failure,
          ),
        );
      }
    }
  }

  signUp() async {
    String number = '+$countryCode${phoneController.text.trim()}';
    try {
      setBusy(true);
      await Amplify.Auth.signUp(
        username: number,
        password: 'not-needed',
        options: CognitoSignUpOptions(
            userAttributes: {CognitoUserAttributeKey.phoneNumber: number}),
      );
      setBusy(false);
      await signin();
    } catch (e) {
      setBusy(false);
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  void dispose() {
    debugPrint('Loginviewmodel disposed');
    phoneController.dispose();
    loginFocus.dispose();
    super.dispose();
  }
}

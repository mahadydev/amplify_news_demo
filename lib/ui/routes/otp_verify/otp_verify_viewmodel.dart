import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_news/main.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/router/router.dart';
import '../../../app/utils/snackbar.dart';

class OtpVerifyViewModel extends BaseViewModel {
  TextEditingController otpController = TextEditingController();

  Future<void> matchOtpSignIn() async {
    try {
      setBusy(true);
      try {
        SignInResult result = await Amplify.Auth.confirmSignIn(
            confirmationValue: otpController.text.trim());
        debugPrint('signinresult: ${result.toString()}');
      } catch (e) {
        rethrow;
      }

      setBusy(false);

      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(Routes.homeView, (route) => false);
    } catch (e) {
      setBusy(false);
      if (e is AmplifyException) {
        ScaffoldMessenger.maybeOf(navigatorKey.currentContext!)?.showSnackBar(
          getSnack(
            title: 'Oh snap!',
            msg: (e).message,
            type: ContentType.failure,
          ),
        );
      }
    }
  }
}

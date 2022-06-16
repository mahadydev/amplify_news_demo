import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_news/main.dart';
import 'package:amplify_news/services/fcmService/fcmService.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../amplifyconfiguration.dart';
import '../../../app/locator/locator.dart';
import '../../../app/router/router.dart';
import '../../../models/ModelProvider.dart';
import '../../../services/auth/auth_services.dart';

class SplashViewModel extends BaseViewModel {
  final AuthServices _authServices = locator<AuthServices>();
  final FCMService _fcmService = locator<FCMService>();

  SplashViewModel() {
    Future.delayed(const Duration(seconds: 1), () => goToNextScreen());
  }

  Future<void> _configureFcm() async {
    await _fcmService.init();
  }

  Future<void> _configureAmplify() async {
    if (!Amplify.isConfigured) {
      try {
        await Amplify.addPlugins([
          AmplifyAuthCognito(),
          AmplifyDataStore(modelProvider: ModelProvider.instance),
          AmplifyAPI(),
        ]);
        await Amplify.configure(amplifyconfig);
      } on AmplifyAlreadyConfiguredException {
        debugPrint(
            'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  goToNextScreen() async {
    try {
      await _configureFcm();
      await _configureAmplify();
      bool isUserLoggedIn = await _authServices.isUserLoggedIn();
      if (isUserLoggedIn) {
        navigatorKey.currentState!.pushReplacementNamed(Routes.homeView);
      } else {
        navigatorKey.currentState!.pushReplacementNamed(Routes.loginView);
      }
    } catch (e) {
      debugPrint('inside catch block next screen: ${e.runtimeType}');
    }
  }
}

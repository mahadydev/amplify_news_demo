import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_news/app/router/router.dart';
import 'package:amplify_news/main.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../data_models/user.dart';

@lazySingleton
class AuthServices with ReactiveServiceMixin {
  ReactiveValue<UserModel?> user = ReactiveValue(null);

  // ignore: non_constant_identifier_names
  AuthService() {
    listenToReactiveValues([user]);
  }

  Future getUserData() async {
    try {
      List<AuthUserAttribute> data = await Amplify.Auth.fetchUserAttributes();
      Map<String, dynamic> userData = {};
      for (var element in data) {
        userData[element.userAttributeKey.toString()] = element.value;
      }
      user.value = UserModel.fromMap(userData);

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<bool> isUserLoggedIn() async {
    try {
      AuthSession authUser = await Amplify.Auth.fetchAuthSession();
      debugPrint('user signed in: ${authUser.isSignedIn}');
      if (authUser.isSignedIn) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await Amplify.Auth.signOut();
    await Amplify.DataStore.clear();
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(Routes.loginView, (route) => false);
  }
}

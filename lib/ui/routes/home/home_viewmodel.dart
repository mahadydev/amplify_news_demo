import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_news/models/News.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator/locator.dart';
import '../../../app/utils/snackbar.dart';
import '../../../data_models/user.dart';
import '../../../main.dart';
import '../../../services/auth/auth_services.dart';

class HomeViewModel extends ReactiveViewModel {
  HomeViewModel() {
    fetchUser();
    getNewsSteam();
  }
  final AuthServices _authServices = locator<AuthServices>();

  UserModel? get user => _authServices.user.value;
  List<News> newsList = [];

  signOut() => _authServices.logout();

  fetchUser() => _authServices.getUserData();

  getNewsSteam() async {
    Stream<QuerySnapshot<News>> stream =
        Amplify.DataStore.observeQuery(News.classType);
    stream.listen((event) {
      newsList = event.items;
      debugPrint(event.items.toString());
      notifyListeners();
    });
  }

  onTapNews(News news) async {
    ScaffoldMessenger.maybeOf(navigatorKey.currentContext!)?.showSnackBar(
      getSnack(
        title: news.title ?? '',
        msg: news.content ?? '',
        type: ContentType.success,
      ),
    );
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _authServices,
      ];
}

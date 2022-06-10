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

  TextEditingController titleC = TextEditingController();
  TextEditingController contentC = TextEditingController();

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

  addNews() async {
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) => SimpleDialog(
        contentPadding: const EdgeInsets.all(20),
        children: [
          const Text('Add a news'),
          const SizedBox(height: 20),
          TextField(
            controller: titleC,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: contentC,
            maxLines: 3,
            decoration: const InputDecoration(hintText: 'Content'),
          ),
          const SizedBox(height: 30),
          OutlinedButton(
              onPressed: () async {
                if (titleC.text.isNotEmpty && contentC.text.isNotEmpty) {
                  navigatorKey.currentState!.pop();
                  final n = News(
                    content: contentC.text,
                    title: titleC.text,
                  );
                  await Amplify.DataStore.save(n);
                  contentC.clear();
                  titleC.clear();
                }
              },
              child: const Text('Add')),
        ],
      ),
    );
  }

  deleteNews(News news) async {
    await Amplify.DataStore.delete(news);
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

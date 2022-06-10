import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.user?.phone_number ?? ''),
            actions: [
              IconButton(
                onPressed: model.signOut,
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: model.addNews,
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: model.newsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final news = model.newsList[index];
                    return Card(
                      child: ListTile(
                        onTap: (() => model.onTapNews(news)),
                        title: Text(news.title ?? ''),
                        leading: news.image != null
                            ? CircleAvatar(
                                foregroundImage: NetworkImage(news.image!))
                            : null,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => model.deleteNews(news),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

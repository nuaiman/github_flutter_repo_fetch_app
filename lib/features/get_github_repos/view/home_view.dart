import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:github_app_nuaiman_ashiq/features/get_github_repos/view/details_view.dart';
import 'package:github_app_nuaiman_ashiq/model/github_repo_model.dart';
import 'package:intl/intl.dart';

import '../controller/get_github_repo_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<GithubRepo>> _githubRepos;

  late ConnectivityResult _connectivity;
  var outputFormat = DateFormat('dd/MM/yy hh:mm a');
  bool sortByStar = true;

  Future<void> checkConnectivity() async {
    _connectivity = await (Connectivity().checkConnectivity());

    if (_connectivity == ConnectivityResult.mobile) {
      _githubRepos = GetGithubRepoController().getRepo();
    } else if (_connectivity == ConnectivityResult.wifi) {
      _githubRepos = GetGithubRepoController().getRepo();
    } else if (_connectivity == ConnectivityResult.none) {
      _githubRepos = GetGithubRepoController().getRepoFromPrefs();
    }
  }

  @override
  void initState() {
    checkConnectivity();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                sortByStar = !sortByStar;
              });
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: FutureBuilder(
        future: checkConnectivity(),
        builder: (context, connectivitySnapshot) =>
            connectivitySnapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : FutureBuilder(
                    future: _githubRepos,
                    builder: (context, snapshot) => snapshot.connectionState ==
                            ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : snapshot.hasError
                            ? const Center(
                                child: Text('error'),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  List<GithubRepo> sortedItems = snapshot.data!
                                    ..sort(
                                      (a, b) => sortByStar
                                          ? b.starCount.compareTo(a.starCount)
                                          : b.updatedAt.compareTo(a.updatedAt),
                                    );
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => DetailsView(
                                              repo: snapshot.data![index]),
                                        ));
                                      },
                                      leading: CircleAvatar(
                                        child: Text('${index + 1}'),
                                      ),
                                      title: Text(sortedItems[index].name),
                                      subtitle: Text(outputFormat.format(
                                          DateTime.parse(
                                              sortedItems[index].updatedAt))),
                                      trailing: SizedBox(
                                        width: 60,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(sortedItems[index]
                                                .starCount
                                                .toString()),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
      ),
    );
  }
}

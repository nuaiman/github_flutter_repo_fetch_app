import 'dart:convert';

import 'package:github_app_nuaiman_ashiq/model/github_repo_model.dart';
import 'package:github_app_nuaiman_ashiq/repo/get_github_repos_repo.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetGithubRepoController {
  Future<List<GithubRepo>> getRepoFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final prefsResult = prefs.getString('repos');

    final result = json.decode(prefsResult!);

    final List<GithubRepo> list = [];

    result['items']
        .map((item) => list.add(
              GithubRepo(
                  id: item['id'],
                  name: item['name'],
                  description: item['description'],
                  repoUrl: item['html_url'],
                  createdAt: item['created_at'],
                  updatedAt: item['updated_at'],
                  starCount: item['stargazers_count'],
                  ownerName: item['owner']['login'],
                  ownerAvatarUrl: item['owner']['avatar_url']),
            ))
        .toList();

    return list;
  }

  Future<List<GithubRepo>> getRepo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    GetGithubRepo getGithubRepo = GetGithubRepo(client: http.Client());

    http.Response response = await getGithubRepo.getRepos();

    final decodedData = json.decode(response.body);

    if (decodedData != null) {
      prefs.setString('repos', json.encode(decodedData));
    }

    final List<GithubRepo> list = [];

    decodedData['items']
        .map((item) => list.add(
              GithubRepo(
                  id: item['id'],
                  name: item['name'],
                  description: item['description'],
                  repoUrl: item['html_url'],
                  createdAt: item['created_at'],
                  updatedAt: item['updated_at'],
                  starCount: item['stargazers_count'],
                  ownerName: item['owner']['login'],
                  ownerAvatarUrl: item['owner']['avatar_url']),
            ))
        .toList();

    return list;
  }
}

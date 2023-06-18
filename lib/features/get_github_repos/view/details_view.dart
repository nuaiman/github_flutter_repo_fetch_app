import 'package:flutter/material.dart';
import 'package:github_app_nuaiman_ashiq/model/github_repo_model.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.repo});

  final GithubRepo repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Image.network(repo.ownerAvatarUrl),
                ),
                const SizedBox(height: 20),
                Card(
                  child: ListTile(
                    title: Text(repo.updatedAt),
                    subtitle: Text(repo.description),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

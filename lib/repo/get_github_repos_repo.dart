import 'package:http/http.dart';

abstract class IGetGithubRepo {
  Future<Response> getRepos();
}
// -----------------------------------------------------------------------------

class GetGithubRepo implements IGetGithubRepo {
  final Client _client;
  GetGithubRepo({required Client client}) : _client = client;

  @override
  Future<Response> getRepos() async {
    const uri =
        'https://api.github.com/search/repositories?q={query=flutter}&per_page=50';
    final data = await _client.get(Uri.parse(uri));

    return data;
  }
}
// -----------------------------------------------------------------------------

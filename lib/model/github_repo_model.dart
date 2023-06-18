class GithubRepo {
  final int id;
  final String name;
  final String description;
  final String repoUrl;
  final String createdAt;
  final String updatedAt;
  final int starCount;
  final String ownerName;
  final String ownerAvatarUrl;
  GithubRepo({
    required this.id,
    required this.name,
    required this.description,
    required this.repoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.starCount,
    required this.ownerName,
    required this.ownerAvatarUrl,
  });
}


class GitRepositoryResponse {
  int? id;
  String? name;
  String? fullName;
  String? description;

  GitRepositoryResponse(
      {required this.id,
      required this.name,
      required this.fullName,
      required this.description});

  factory GitRepositoryResponse.fromJson(Map<String, dynamic> json) {
    return GitRepositoryResponse(
      id: json['id'],
      fullName: json['full_name'],
      name: json['name'],
      description: json['description'],
    );
  }
}

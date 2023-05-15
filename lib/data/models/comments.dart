class CommentEntity {
  final int id;
  final String titile;
  final String content;
  final String date;
  final String email;

  CommentEntity.fromjson(Map<String, dynamic> json)
      : id = json["id"],
        titile = json["title"],
        content = json["content"],
        date = json["date"],
        email = json["author"]["email"];
}

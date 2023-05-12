class BannerEntity {
  final int id;
  final String image;

  BannerEntity.fromjson(Map<String, dynamic> json)
      : id = json["id"],
        image = json["image"];
}

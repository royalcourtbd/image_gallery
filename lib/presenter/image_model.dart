class ImageModel {
  final String id;
  final String imgUrl;

  ImageModel({
    required this.id,
    required this.imgUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imgUrl": imgUrl,
      };
}

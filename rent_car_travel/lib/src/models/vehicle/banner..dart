class BannerImage {
    final int id;
    final String imageUrl;

  BannerImage({this.id, this.imageUrl});

  factory BannerImage.fromJson(Map<String, dynamic> json) {
    return BannerImage(
      id: json['albumId'] as int,
      imageUrl: json['id'] as String,
    );
  }
}
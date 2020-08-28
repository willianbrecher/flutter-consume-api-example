class Photo {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnail;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnail});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['userId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnail: json['thumbnail'],
    );
  }
}

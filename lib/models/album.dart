class Album {
  int userI;
  int id;
  String title;

  Album({this.userI, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(userI: json['userId'], id: json['id'], title: json['title']);
  }
}

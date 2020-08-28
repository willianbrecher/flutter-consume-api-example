class AlbumService {

  static const baseURL = "https://jsonplaceholder.typicode.com";

  Future<APIResponse<List<Album>>> getAlbums(){
    return http.get(baseURL + '/users/1/albums').then(response => {
      if (response.statusCode == 200){
        final albums = jsonDecode(response.data).map(item => Album.fromJson(item)).toList();
        return APIResponse<List<Album>>(data: albums);
      }
    }){

    }
  }
}
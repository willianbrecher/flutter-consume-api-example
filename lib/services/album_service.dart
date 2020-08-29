import 'dart:convert';

import '../models/album.dart';
import '../models/photo.dart';
import 'api_response.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  static const baseURL = "https://jsonplaceholder.typicode.com";
  static const headers = {'Content-Type': 'application/json'};

  Future<APIResponse<List<Album>>> getAlbums(int userId) {
    return http
        .get(baseURL + '/users/$userId/albums', headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        final albums = jsonDecode(response.body) as List;
        List<Album> albumList =
            albums.map((item) => Album.fromJson(item)).toList();
        return APIResponse<List<Album>>(data: albumList);
      }
      return APIResponse<List<Album>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((onError) => APIResponse<List<Album>>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<Photo>>> getPhotos(int albumId) {
    return http
        .get(baseURL + '/albums/$albumId/photos', headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        final photos = jsonDecode(response.body) as List;
        List<Photo> photoList =
            photos.map((item) => Photo.fromJson(item)).toList();
        return APIResponse<List<Photo>>(data: photoList);
      }
      return APIResponse<List<Photo>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((onError) => APIResponse<List<Photo>>(
            error: true, errorMessage: 'An error occured'));
  }
}

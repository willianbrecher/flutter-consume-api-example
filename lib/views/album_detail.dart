import 'package:flutter/material.dart';

import '../models/photo.dart';
import '../services/album_service.dart';
import '../services/api_response.dart';

class AlbumDetail extends StatefulWidget {
  final int albumId;

  AlbumDetail({this.albumId});

  @override
  _AlbumDetailState createState() => _AlbumDetailState();
}

class _AlbumDetailState extends State<AlbumDetail> {
  AlbumService _albumService;

  APIResponse<List<Photo>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _albumService = AlbumService();
    _fetchAlbums();
    super.initState();
  }

  _fetchAlbums() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await _albumService.getPhotos(widget.albumId);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Photos'),
        ),
        body: Builder(builder: (BuildContext context) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }

          return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(_apiResponse.data[index].title),
                  leading: Image.network(_apiResponse.data[index].thumbnailUrl),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 1, color: Colors.grey),
              itemCount: _apiResponse.data.length);
        }));
  }
}

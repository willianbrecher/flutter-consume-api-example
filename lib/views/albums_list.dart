import 'package:flutter/material.dart';
import 'package:futtler_consume_api_example/views/album_detail.dart';

import '../models/album.dart';
import '../services/album_service.dart';
import '../services/api_response.dart';

class AlbumsList extends StatefulWidget {
  @override
  _AlbumsListState createState() => _AlbumsListState();
}

class _AlbumsListState extends State<AlbumsList> {
  AlbumService _albumService;

  APIResponse<List<Album>> _apiResponse;
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

    _apiResponse = await _albumService.getAlbums(1);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Builder(
        builder: (BuildContext context) {
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AlbumDetail(albumId: _apiResponse.data[index].id)));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 1, color: Colors.grey),
              itemCount: _apiResponse.data.length);
        },
      ),
    );
  }
}

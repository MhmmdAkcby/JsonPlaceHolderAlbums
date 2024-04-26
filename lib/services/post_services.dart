import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:json_place_holder_albums/model/album_model.dart';
import 'package:json_place_holder_albums/model/post_model.dart';

abstract class IPostService {
  Future<List<PostModel>?> fetchPostItemsAdvance();
  Future<List<AlbumModel>?> fetchRelatedAlbumsWithAlbumId(int albumId);
}

class PostServices implements IPostService {
  late final Dio _dio;
  PostServices() : _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

  @override
  Future<List<PostModel>?> fetchPostItemsAdvance() async {
    try {
      final response = await _dio.get(_PostItemPath.albums.name);

      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;

        if (datas is List) {
          return datas.map((e) => PostModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      _ShowDioException()._showDebug(exception, this);
    }
    return null;
  }

  @override
  Future<List<AlbumModel>?> fetchRelatedAlbumsWithAlbumId(int albumId) async {
    try {
      final response = await _dio.get(_PostItemPath.photos.name, queryParameters: {_PostIdQuery.albumId.name: albumId});
      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;
        if (datas is List) {
          return datas.map((e) => AlbumModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      _ShowDioException()._showDebug(exception, this);
    }
    return null;
  }
}

enum _PostItemPath { albums, photos }

enum _PostIdQuery { albumId }

class _ShowDioException {
  void _showDebug<T>(DioException exception, T type) {
    if (kDebugMode) {
      print(exception.message);
      print(type);
      print('--------------------------------------');
    }
  }
}

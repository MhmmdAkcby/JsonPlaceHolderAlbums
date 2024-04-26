import 'package:flutter/material.dart';

import 'package:json_place_holder_albums/model/post_model.dart';
import 'package:json_place_holder_albums/product/languages/langugaes.dart';
import 'package:json_place_holder_albums/services/post_services.dart';
import 'package:json_place_holder_albums/widget/detail_albums_page.dart';

class AlbumsListView extends StatefulWidget {
  const AlbumsListView({super.key});

  @override
  State<AlbumsListView> createState() => _AlbumsListViewState();
}

class _AlbumsListViewState extends State<AlbumsListView> {
  List<PostModel>? _items;
  late final IPostService _postServices;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _postServices = PostServices();
    fetchPostItemsAdvance();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchPostItemsAdvance() async {
    _changeLoading();
    _items = await _postServices.fetchPostItemsAdvance();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageItem().appBarAlbums),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              itemCount: _items?.length ?? 0,
              itemBuilder: (context, index) {
                return _PostCards(model: _items?[index]);
              },
            ),
    );
  }
}

class _PostCards extends StatelessWidget {
  const _PostCards({
    super.key,
    required PostModel? model,
  }) : _model = model;

  final PostModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          _NavigateToWidget()._navigateTo(
              context,
              DetailAlbumsPage(
                albumId: _model?.userId ?? 0,
              ));
        },
        title: Text("${_model?.id ?? 0}.  ${_model?.title?.characters.toUpperCase() ?? ''}"),
      ),
    );
  }
}

class _NavigateToWidget {
  void _navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}

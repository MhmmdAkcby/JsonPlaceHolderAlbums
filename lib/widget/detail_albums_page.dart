import 'package:flutter/material.dart';
import 'package:json_place_holder_albums/model/album_model.dart';
import 'package:json_place_holder_albums/product/languages/langugaes.dart';
import 'package:json_place_holder_albums/services/post_services.dart';

class DetailAlbumsPage extends StatefulWidget {
  const DetailAlbumsPage({super.key, required this.albumId});
  final int? albumId;

  @override
  State<DetailAlbumsPage> createState() => _DetailAlbumsPageState();
}

class _DetailAlbumsPageState extends State<DetailAlbumsPage> {
  List<AlbumModel>? _items;
  late final IPostService _postService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _postService = PostServices();
    fetchRelatedAlbumsWithAlbumId(widget.albumId ?? 0);
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchRelatedAlbumsWithAlbumId(int albumId) async {
    _changeLoading();
    _items = await _postService.fetchRelatedAlbumsWithAlbumId(albumId);
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageItem().appBarPhoto),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              itemCount: _items?.length ?? 0,
              itemBuilder: (context, index) {
                return _AlbumCards(model: _items?[index]);
              },
            ),
    );
  }
}

class _AlbumCards extends StatelessWidget {
  const _AlbumCards({
    Key? key,
    required AlbumModel? model,
  })  : _model = model,
        super(key: key);

  final AlbumModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          _navigateToImageDetail(context, _model?.url ?? '');
        },
        title: Text(_model?.title ?? ''),
        leading: CircleAvatar(backgroundImage: NetworkImage(_model?.thumbnailUrl ?? '')),
        subtitle: Text('Albums Id:  ${_model?.albumId ?? 0}'),
      ),
    );
  }

  void _navigateToImageDetail(BuildContext context, String imageUrl) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Image Detail'),
          ),
          body: Center(
            child: Image.network(imageUrl),
          ),
        );
      },
    ));
  }
}

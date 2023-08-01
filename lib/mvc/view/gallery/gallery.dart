import 'package:famlynk_version1/mvc/model/profile_model/gallery_model.dart';
import 'package:flutter/material.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/newsFeed_model.dart';
import 'package:famlynk_version1/services/profileService/gallery_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hexcolor/hexcolor.dart';

class MediaPage extends StatefulWidget {
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  List<GalleryNewsFeedModel> mediaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMedia();
  }

Future<void> _fetchMedia() async {
  try {
    final service = ShowGalleryService();
    mediaList = await service.getPhotoList();
    mediaList.sort((a, b) {
      final aDate = a.createdOn as DateTime; 
      final bDate = b.createdOn as DateTime; 
      return bDate.compareTo(aDate);
    }); 
    mediaList = mediaList.reversed.toList(); 
    setState(() {
      isLoading = false;
    });
  } catch (e) {
    print('Failed to fetch media: $e');
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    final nonEmptyMediaList =
        mediaList.where((media) => media.photo.isNotEmpty).toList();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 228, 237),
      appBar: AppBar(
        backgroundColor: HexColor('#0175C8'),
        title: Text('Media Page',style: TextStyle(color: Colors.white,),),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (nonEmptyMediaList.isEmpty
              ? Center(child: Text('No media available.'))
              : _buildMediaGridView(nonEmptyMediaList)),
    );
  }

  Widget _buildMediaGridView(List<GalleryNewsFeedModel> mediaList) {
    final padding = EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.01,
      vertical: MediaQuery.of(context).size.width * 0.01,
    );

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: padding,
          child: _buildImage(mediaList[index]),
        );
      },
    );
  }

  Widget _buildImage(GalleryNewsFeedModel media) {
    return CachedNetworkImage(
      imageUrl: media.photo.toString(),
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

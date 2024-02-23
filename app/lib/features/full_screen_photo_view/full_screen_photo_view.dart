import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../base/common_widgets/bar/nav_bar.dart';
import '../../base/utils/colors.dart';

class FullScreenPhotoView extends StatefulWidget {
  final List<String?> photoUrls;
  const FullScreenPhotoView({required this.photoUrls, super.key});

  @override
  State<FullScreenPhotoView> createState() => _FullScreenPhotoViewState();

  static Route<void> route(List<String?> photoUrls) {
    return MaterialPageRoute<void>(
        builder: (_) => FullScreenPhotoView(
              photoUrls: photoUrls,
            ));
  }
}

class _FullScreenPhotoViewState extends State<FullScreenPhotoView> {
  List<String> photoUrls = [];

  @override
  void initState() {
    photoUrls = widget.photoUrls
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
    super.initState();
  }

  String? getCacheKey(String url) {
    Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }
    return "${uri.scheme}://${uri.host}/${uri.path}";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black,
      child: Column(
        children: [
          _navBar(),
          Expanded(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: photoUrls[index].hashCode),
                  initialScale: PhotoViewComputedScale.contained * 1.0,
                  imageProvider: CachedNetworkImageProvider(photoUrls[index],
                      cacheKey: getCacheKey(photoUrls[index])),
                );
              },
              itemCount: photoUrls.length,
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _navBar() {
    return NavBar(
      navStyle: NavStyle.singleLined,
      navTitle: "",
      backgroundColor: AppColors.transparent,
      showsLeftButton: true,
      backButtonColor: AppColors.white,
      onBackButtonClicked: () {
        Navigator.pop(context);
      },
      icon: Icons.arrow_back,
    );
  }
}

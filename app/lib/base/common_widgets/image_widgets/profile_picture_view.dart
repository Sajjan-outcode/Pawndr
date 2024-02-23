import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../Loader/loader.dart';

@immutable
class ProfilePictureView extends StatelessWidget {
  final String? avatarUrl;
  final XFile? selectedImage;
  final double size;
  final bool _isPickerType;
  final Color _backgroundColor;
  const ProfilePictureView(
      {this.avatarUrl,
      this.selectedImage,
      bool isPickerType = false,
      this.size = 100,
      Color backgroundColor = AppColors.formDefault,
      super.key})
      : _isPickerType = isPickerType,
        _backgroundColor = backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(size / 2.0),
      child: SizedBox(
        height: size,
        width: size,
        child: Container(
          color: _backgroundColor,
          child: !_isPickerType
              ? _imageFromRemote()
              : ((selectedImage != null)
                  ? _imageFromLocal()
                  : _imageFromRemote()),
        ),
      ),
    );
  }

  Widget _imageFromLocal() {
    return selectedImage == null
        ? _placeholderImageView(showsDefaultPlaceholder: false)
        : Image.file(
            File(selectedImage!.path),
            fit: BoxFit.cover,
          );
  }

  Widget _imageFromRemote() {
    return (avatarUrl == null)
        ? _placeholderImageView(showsDefaultPlaceholder: !_isPickerType)
        : CachedNetworkImage(
            imageUrl: avatarUrl!,
            placeholder: (context, url) {
              return Stack(children: [
                _placeholderImageView(showsDefaultPlaceholder: true),
                const Loader()
              ]);
            },
            errorWidget: (context, url, error) =>
                _placeholderImageView(showsDefaultPlaceholder: true),
            fit: BoxFit.cover);
  }

  Widget _placeholderImageView({required bool showsDefaultPlaceholder}) {
    return (_isPickerType && !showsDefaultPlaceholder)
        ? Center(
            child: SizedBox(
              width: size * 0.3,
              height: size * 0.3,
              child: const Image(
                image: AssetImage(Images.placeholderImage),
                fit: BoxFit.cover,
              ),
            ),
          )
        : const Image(
            image: AssetImage(Images.placeholderImage),
          );
  }
}

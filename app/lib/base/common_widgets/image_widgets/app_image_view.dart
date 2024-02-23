import '../../utils/strings.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

@immutable
class AppImageView extends StatelessWidget {
  final String? avatarUrl;
  final double? _width;
  final double _height;
  final double _borderWidth;
  final Color _borderColor;
  final Color _backgroundColor;
  final String placeholderImage;
  final double placeholderHeight;
  final String initialsText;
  final double cornerRadius;
  final BoxFit _fit;
  final bool isVideoThumbnail;
  const AppImageView(
      {this.avatarUrl,
      double width = 100,
      double height = 100,
      double borderWidth = 0.0,
      Color borderColor = Colors.transparent,
      this.cornerRadius = 50,
      this.placeholderHeight = 100,
      this.initialsText = "",
      this.isVideoThumbnail = false,
      this.placeholderImage = Images.placeholderImage,
      Color backgroundColor = AppColors.transparent,
      BoxFit fit = BoxFit.cover,
      super.key})
      : _backgroundColor = backgroundColor,
        _width = width,
        _height = height,
        _borderWidth = borderWidth,
        _borderColor = borderColor,
        _fit = fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: _borderColor, width: _borderWidth),
            borderRadius: BorderRadius.circular(cornerRadius),
            color: _backgroundColor),
        child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(cornerRadius),
            child: Stack(children: [
              _imageFromRemote(),
              Visibility(
                visible: isVideoThumbnail,
                child: Container(
                  color: AppColors.black.withOpacity(0.5),
                  child: Center(
                      child: SizedBox(
                    width: _height * 0.5,
                    height: _height * 0.5,
                    child: const Icon(Icons.play_arrow),
                  )),
                ),
              )
            ])),
      ),
    );
  }

  Widget _imageFromRemote() {
    return (avatarUrl == null)
        ? _placeholderImageView()
        : Stack(children: [
            FadeInImage(
                width: _width,
                height: _height,
                image: NetworkImage(avatarUrl!),
                imageErrorBuilder: (context, error, stackTrace) {
                  return _placeholderImageView();
                },
                placeholder: AssetImage(placeholderImage),
                placeholderFit: BoxFit.cover,
                fit: _fit),
          ]);
  }

  Widget _placeholderImageView() {
    return initialsText.isEmpty
        ? Center(
            child: Image(
              width: placeholderHeight,
              height: placeholderHeight,
              image: AssetImage(placeholderImage),
              fit: BoxFit.cover,
            ),
          )
        : _getInitalView();
  }

  Widget _getInitalView() {
    return Container(
        height: _height,
        width: _height,
        color: AppColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              initialsText.initials,
              style: const TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.w300),
            ),
          ),
        ));
  }
}

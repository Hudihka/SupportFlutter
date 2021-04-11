import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qut/AppIcons.dart';

class DowloadImage extends StatelessWidget {
  String _namePlaceholder;
  double _width;
  String url;
  double height;
  double borderRadius;
  Widget _content;
  bool _addBlure;

  DowloadImage(this.url, 
               this.height, 
               this.borderRadius,
               {String namePlaceholder, 
               double width, 
               Widget content, 
               bool addBlure}) {
                 
    _namePlaceholder = namePlaceholder;
    _width = width;
    _content = content;
    _addBlure = false;

    if (namePlaceholder == null) {
      _namePlaceholder = AppImages.placeholder;
    }

    if (width == null) {
      _width = double.maxFinite;
    }

    if (addBlure != null) {
      _addBlure = addBlure;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _allContent,
    );
  }

  List<Widget> get _allContent {
    List<Widget> base = [
      ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: _width,
            height: height,
            child: url != null ? _dowloadImage : _placeholder,
          )),
    ];

    if (_addBlure) {
      base.add(Container(
        width: _width,
        height: height,
        // color: Colors.black.withAlpha(70),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(50),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      ));
    }

    if (_content != null) {
      base.add(Container(width: _width, height: height, child: _content));
    }

    return base;
  }

  Widget get _placeholder {
    return Container(
      width: _width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(_namePlaceholder),
        ),
      ),
    );
  }

  Widget get _dowloadImage {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: _width,
      height: height,
      imageUrl: url,
      placeholder: (context, url) => _placeholder,
      errorWidget: (context, url, error) => _placeholder,
    );
  }
}



// enum BoxFit {
//   fill,

//   contain,

//   cover,



//   fitWidth,

//   fitHeight,

//   none,

//   scaleDown,
// }
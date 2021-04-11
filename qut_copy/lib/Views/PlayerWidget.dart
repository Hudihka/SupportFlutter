

import 'package:flutter/material.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/DowloadImage.dart';

class PlayerWidget extends StatelessWidget {

  Content content;

  PlayerWidget({@required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 8),
          _fondationWidget,
          SizedBox(height: 83)
        ],
      )
    );
  }

  Widget get _fondationWidget {
    return Row(
      children: [
        SizedBox(width: 16,),
        Container(
          height: 44,
          width: 80,
          child: DowloadImage(content.video_preview, 44, 4, namePlaceholder: content.type.nameSplash,),
        )
      ]
    );
  }
}
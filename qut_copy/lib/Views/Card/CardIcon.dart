import 'package:qut/imports.dart';

class CardIcon extends StatelessWidget {
  const CardIcon({
    Key key,
    @required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: 50,
        width: 44,
        child: Padding(
          padding: EdgeInsets.only(left: 14, top: 14, right: 8, bottom: 14),
          child: Image.asset(path),
        ));
  }
}

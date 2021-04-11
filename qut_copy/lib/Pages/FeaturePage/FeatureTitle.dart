import 'package:qut/imports.dart';

class FeatureTitle extends StatelessWidget {
  const FeatureTitle({Key key, @required this.title, this.onTapAll, this.icon, this.viewAll}) : super(key: key);

  final String title;
  final String icon;
  final bool viewAll;
  final VoidCallback onTapAll;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Image.asset(icon ?? AppIcons.star, width: 16),
          SizedBox(width: 10),
          Text(title, style: AppTextStyle.b16),
          Spacer(),
          if (viewAll != false)
            GestureDetector(
              child: Text('View all', style: AppTextStyle.r16Color(AppColors.blue)),
              onTap: this.onTapAll,
            ),
        ],
      ),
    );
  }
}

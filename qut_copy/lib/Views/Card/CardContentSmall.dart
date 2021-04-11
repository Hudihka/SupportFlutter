import 'package:qut/imports.dart';

class CardContentSmall extends StatelessWidget {
  const CardContentSmall({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Content item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MiniPlayerSingelton.shared.getCubit.openFullScreen(item);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.only(left: 16),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  if (item.content_preview != null)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage.assetNetwork(
                          image: item.content_preview,
                          fit: BoxFit.cover,
                          placeholder: AppImages.placeholder,
                        ),
                      ),
                    )
                  else
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          AppImages.placeholder,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Row(
                      children: [
                        CardIcon(path: getIconByType(item.type)),
                        Spacer(),
                        CardIcon(path: AppIcons.threePoint),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    item.name,
                    style: AppTextStyle.sb11,
                  )),
                  Container(
                    width: 50,
                    child: Align(
                      child: Text(
                        "${item.content_qut_duration.durationContent}",
                        style: AppTextStyle.sb11,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

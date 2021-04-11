import 'package:qut/Views/Cells/LoadCell.dart';
import 'package:qut/imports.dart';

class CategoryHorizontal extends StatelessWidget {
  const CategoryHorizontal({
    Key key,
    this.item,
    this.isSearch = false,
    this.viewAll,
    this.onTapAll,
  }) : super(key: key);

  final GetExploreRequestData item;
  final bool isSearch;
  final bool viewAll;
  final VoidCallback onTapAll;

  String get categoryName {
    if (item.category == null) return '';

    if (isSearch) {
      final count = item.contents.length;

      if (count < 100)
        return "${item.category.name} (${count})";
      else
        return "${item.category.name} (100+)";
    }

    return "${item.category.name}";
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (categoryName.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  categoryName,
                  style: AppTextStyle.r16,
                ),
                Spacer(),
                if (viewAll == true)
                  GestureDetector(
                    child: Text('View all', style: AppTextStyle.r16Color(AppColors.blue)),
                    onTap: this.onTapAll,
                  ),
              ],
            ),
          ),
        if (item.contents.isNotEmpty)
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: item.contents.length,
            itemBuilder: (ctx, index) {
              Content obj = item.contents[index];

              if (obj.typeCell == EnumTupeCell.content) {
                return CardContentSmall(item: obj);
              }

              return LoadCell();
            },
          ),
        ),
        if (item.contents.isEmpty)
          Container(
          height: 200,
          child: Center(child: Text('Нет данных')),
        ),
      ],
    );
  }
}

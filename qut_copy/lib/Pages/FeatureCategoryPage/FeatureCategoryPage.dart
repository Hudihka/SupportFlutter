import 'package:qut/imports.dart';

class FeatureCategoryPageParams {
  final Category category;
  final List<Content> items;

  FeatureCategoryPageParams({@required this.category, @required this.items});
}

class FeatureCategoryPage extends StatefulWidget {
  static const route = '/FeatureCategoryPage';

  @override
  _FeatureCategoryPageState createState() => _FeatureCategoryPageState();
}

class _FeatureCategoryPageState extends State<FeatureCategoryPage> {
  final TextEditingController controller = TextEditingController();

  String text = '';

  FeatureCategoryPageParams params;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    params = ModalRoute.of(context).settings.arguments;

    this.controller.addListener(() {
      if (text != controller.text) {
        text = controller.text;
        if (text.isNotEmpty) {
          debouncer.run(() => context.read<ExploreCubit>()..search(text));
        } else {
          context.read<ExploreCubit>()..load();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppIconTop.back, width: 20),
                  Text(params.category?.name ?? 'Category', style: AppTextStyle.b16),
                  Image.asset(AppIcons.search, width: 20),
                ],
              ),
            ),
            if (text.isNotEmpty) SearchField(controller),
            Expanded(
              child: ListView.builder(
                itemCount: params.items.length,
                itemBuilder: (ctx, index) {
                  // return Text(params.items[index].name);
                  return Container(child: CardContentSmall(item: params.items[index]), height: 200);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:qut/imports.dart';

export 'package:qut/Pages/ExplorePage/CategoryHorizontal.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController controller = TextEditingController();

  String text = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

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
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Explore', style: AppTextStyle.b20),
                SearchField(controller),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ExploreCubit, ExploreState>(builder: (context, state) {
              if (state.isLoading) {
                return AppLoading(fullScreen: true);
              }

              if (!state.isLoading && state.items.isNotEmpty) {
                final items = state.items.map((e) {
                  return CategoryHorizontal(item: e, isSearch: text.isNotEmpty);
                }).toList();

                return ListView(
                  children: items,
                );
              }

              return Container(
                child: Align(child: Text('Нет данных'), alignment: Alignment.topCenter),
              );
            }),
          ),
        ],
      ),
    );
  }
}

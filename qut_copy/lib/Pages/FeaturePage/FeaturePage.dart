import 'package:qut/Cubits/FeatureCubit/FeatureCubit.dart';
import 'package:qut/imports.dart';

export 'FeatureTitle.dart';

class FeaturePage extends StatefulWidget {
  @override
  _FeaturePageState createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
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
                Text('Featured', style: AppTextStyle.b20),
                SizedBox(height: 12),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<FeatureCubit, FeatureState>(
                    builder: (context, state) {
                      return Column(children: [
                        FeatureTitle(
                          title: 'Added by you',
                          viewAll: state.addByUser.data.isNotEmpty,
                          onTapAll: () {
                            final dictionary = state.addByUser.data?.first?.category?.first;
                            if (dictionary != null) {
                              Navigator.of(context).pushNamed(
                                FeatureCategoryPage.route,
                                arguments: FeatureCategoryPageParams(
                                    category: Category.fromDictionary(dictionary), items: state.addByUser.data),
                              );
                            }
                          },
                        ),
                        CategoryHorizontal(
                            item: GetExploreRequestData(contents: state.addByUser.data, category: null),
                            isSearch: text.isNotEmpty),
                        FeatureTitle(
                          title: 'Continue watching',
                          icon: AppIcons.clock,
                          viewAll: state.continueWatching.data.isNotEmpty,
                          onTapAll: () {
                            final dictionary = state.continueWatching.data?.first?.category?.first;
                            if (dictionary != null) {
                              Navigator.of(context).pushNamed(
                                FeatureCategoryPage.route,
                                arguments: FeatureCategoryPageParams(
                                  category: Category.fromDictionary(dictionary),
                                  items: state.continueWatching.data,
                                ),
                              );
                            }
                          },
                        ),
                        CategoryHorizontal(
                          item: GetExploreRequestData(
                            contents: state.continueWatching.data,
                            category: null,
                          ),
                          isSearch: text.isNotEmpty,
                        ),
                      ]);
                    },
                  ),
                  FeatureTitle(title: 'Favourite', icon: AppIcons.heart, viewAll: false),
                  BlocBuilder<FeatureCubit, FeatureState>(builder: (context, state) {
                    if (state.isLoading) {
                      return AppLoading(fullScreen: true);
                    }

                    final List<Widget> items = state.items.map((e) {
                      return CategoryHorizontal(
                        item: e,
                        isSearch: text.isNotEmpty,
                        viewAll: true,
                        onTapAll: () {
                          if (e != null) {
                            Navigator.of(context).pushNamed(
                              FeatureCategoryPage.route,
                              arguments: FeatureCategoryPageParams(category: e.category, items: e.contents),
                            );
                          }
                        },
                      );
                    }).toList();

                    return Column(
                      children: [...items, SizedBox(height: 80)],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

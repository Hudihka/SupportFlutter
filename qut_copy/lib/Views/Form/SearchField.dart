import 'package:qut/imports.dart';

typedef SearchFieldOnEdit(String text);

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onCancel;

  SearchField(this.controller, {this.onCancel});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.controller.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.lightGray,
              ),
              prefix: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset(
                  AppIcons.search,
                  width: 16,
                  height: 16,
                ),
              ),
              placeholder: 'Поиск',
              placeholderStyle: TextStyle(color: AppColors.mediumGray),
              textAlignVertical: TextAlignVertical.center,
              controller: widget.controller,
            ),
          ),
          if (widget.controller.text.isNotEmpty)
          Container(
              child: CupertinoButton(
                minSize: 20,
                  padding: EdgeInsets.only(top: 0, bottom: 0, left: 20),
                  child: Text(
                    'Отмена',
                    style: AppTextStyle.r16.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                  onPressed: widget.controller.clear),
            )
        ],
      ),
    );
  }
}

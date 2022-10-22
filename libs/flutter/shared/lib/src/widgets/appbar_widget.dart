import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final String? searchHintText;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final TextEditingController? searchController;
  final VoidCallback? onPressedLeadingIcon;
  final ValueChanged<String>? onChanged;
  final bool? showSearch;

  const AppBarWidget({
    Key? key,
    this.leading,
    required this.title,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.searchHintText,
    this.onSubmitted,
    this.textInputAction,
    this.searchController,
    this.onPressedLeadingIcon,
    this.onChanged,
    this.showSearch = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    Widget? leadingIcon = leading;

    if (leadingIcon == null && automaticallyImplyLeading) {
      if (hasDrawer) {
        leadingIcon = IconButton(
          icon: const Icon(Icons.mood_sharp, color: Colors.yellowAccent),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      } else {
        if (canPop) {
          leadingIcon = IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black87,
            ),
            onPressed: () => onPressedLeadingIcon!(),
          );
        }
      }
    }

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: leadingIcon,
      title: Text(title, style: const TextStyle(color: Colors.black87, fontSize: 16),),
      centerTitle: centerTitle,
      actions: actions,
      bottom: showSearch! ? AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: 42,
          child: TextField(
            controller: searchController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none
              ),
              hintText: searchHintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16
              ),
              prefixIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: 18,
                child: const Icon(Icons.search),
              )
            ),
            onSubmitted: (value) => onSubmitted!(value),
            onChanged: (value) => onChanged!(value),
            textInputAction: textInputAction,
          ),
        ),
      ) : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(showSearch! ? 112 : kToolbarHeight);
}
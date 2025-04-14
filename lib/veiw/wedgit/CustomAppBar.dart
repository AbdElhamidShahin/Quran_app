import 'package:flutter/material.dart';
import '../../veiw_model/helper/thems/TextStyle.dart';
import '../../veiw_model/helper/thems/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      automaticallyImplyLeading: false,

      backgroundColor: backgroundColor,
      centerTitle: true,
      title: Text(title, style: appBarTitleStyle()),

      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_forward, color: primaryDark),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

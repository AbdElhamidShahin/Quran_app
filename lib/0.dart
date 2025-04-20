import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/veiw_model/helper/thems/ThemeProviderDarkMode.dart';
import 'package:quran_app/veiw_model/helper/thems/color.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      body: Column(
        children: [
          Container(color: Colors.red, child: Text('dsfsfsf')),
        ],
      ),
    );
  }
}

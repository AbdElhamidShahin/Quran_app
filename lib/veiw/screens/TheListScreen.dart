import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../veiw_model/helper/thems/TextStyle.dart';
import '../../veiw_model/helper/thems/ThemeProviderDarkMode.dart';
import '../../veiw_model/helper/thems/color.dart';


class Setings extends StatelessWidget {
  const Setings({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
  final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsOption(
            context,
            icon: Icons.privacy_tip,
            title: 'سياسة الخصوصية',
            onPressed: () {
              _launchUrl(
                  "https://www.freeprivacypolicy.com/live/931d000c-ebf9-46ec-a72d-a619560a7173");
            },
          ),
          _buildSettingsOption(
            context,
            icon: Icons.star,
            title: 'تقييم التطبيق',
            onPressed: () {
              _launchUrl(
                  "https://play.google.com/store/apps/details?id=com.yourcompanyname.yourappname&fbclid=IwZXh0bgNhZW0CMTAAAR1zobhWeqLMCQDh_XmcPyNn7xHySVpG1MSrQs70NWFhZ_17bsnXV9936ls_aem_xXW5vyMyfUmyH9kifCQD1Q");
            },
          ),
          _buildSettingsOption(
            context,
            icon: Icons.share,
            title: 'مشاركة',
            onPressed: () {},
          ),
          _buildSettingsOption(
            context,
            icon: Icons.warning,
            title: 'تحذير',
            onPressed: () {
              _showWarningDialog(context);
            },
          ),
          _buildSettingsOption(
            context,
            icon: Icons.question_answer_sharp,
            title: 'أسئلة شائعة',
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => FAQPage()),
              // );
            },
          ),




          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    isDarkMode ? 'Dark Mode' : 'Light Mode',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: primaryDark),
                  ),
                ),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      color: primaryDark, borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ),




        ],
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context,
      {required IconData icon,
        required String title,
        required VoidCallback onPressed}) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Icon(icon, color:primaryDark, size: 28),
        title: Text(
          title,
          style: SttingsTextStyle()
        ),
        onTap: onPressed,
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    if (!await launchUrl(Uri.parse(urlString))) {
      throw Exception("Could not launch $urlString");
    }
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تحذير',
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          content: const Text(
            'هذه رسالة تحذير.',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('موافق'),
            ),
          ],
        );
      },
    );
  }
}
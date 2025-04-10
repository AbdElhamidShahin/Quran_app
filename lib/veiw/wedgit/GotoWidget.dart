import 'package:flutter/material.dart';

import '../../veiw_model/helper/thems/TextStyle.dart';
import '../../veiw_model/helper/thems/color.dart';

class GotoWidget extends StatelessWidget {
  final VoidCallback? onpressed;
  const GotoWidget({Key? key, this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('انتقل إلى', style: buttonTextStyle()),
        SizedBox(width: 7),
        Icon(Icons.arrow_forward_ios, color: primaryColor, size: 13),
      ],
    );
  }
}

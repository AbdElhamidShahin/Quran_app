import 'package:flutter/material.dart';

import '../../veiw_model/color/coloe.dart';

class GotoWidget extends StatelessWidget {
  final VoidCallback? onpressed;
  const GotoWidget({Key? key, this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('انتقل إلى', style: miniStyle()),
        SizedBox(width: 7),
        Icon(Icons.arrow_forward_ios, color: Colors.white, size: 13),
      ],
    );
  }
}

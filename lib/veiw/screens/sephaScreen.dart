import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/model/bloc/states.dart';

import '../../model/bloc/BlocCounterSapha.dart';
import '../../veiw_model/helper/thems/TextStyle.dart';
import '../../veiw_model/helper/thems/color.dart';
import '../wedgit/CustomAppBar.dart';

class SephaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(title: 'المسبحه'),

        body: BlocProvider(
          create: (BuildContext context) => CounterCubit(),
          child: BlocConsumer<CounterCubit, PrayerState>(
            builder: (context, state) {
              var cubit = CounterCubit.get(context);

              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: Text(
                          "${cubit.Options()}",
                          style: juzNumberStyle(),
                        ),
                      ),
                    ),
                    Text('${cubit.count}', style: quranAyahStyle()),

                    GestureDetector(
                      onTap: cubit.addNumber,

                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: primaryLight,
                        ),
                      ),
                    ),
                    Text('${cubit.count}/99', style: quranAyahStyle()),
                    GestureDetector(
                      onTap: cubit.resultcount,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          child: Text('اعاده التعيين', style: juzNumberStyle()),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            listener: (BuildContext context, PrayerState state) {},
          ),
        ),
      ),
    );
  }
}

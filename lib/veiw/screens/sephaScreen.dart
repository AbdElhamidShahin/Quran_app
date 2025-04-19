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
        appBar: CustomAppBar(title: 'المسبحة'),
        body: BlocProvider(
          create: (BuildContext context) => CounterCubit(),
          child: BlocConsumer<CounterCubit, PrayerState>(
            builder: (context, state) {
              var cubit = CounterCubit.get(context);

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                onTap: cubit.addNumber,
                              child: Container(
                                height: 280,
                                width: 280,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(140),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.2),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    primaryColor.withOpacity(0.7),
                                    BlendMode.srcIn,
                                  ),
                                  child: Image.asset('assets/sebhaBody.png'),
                                ),
                              ),
                            ),
                            Text(
                              "${cubit.Options()}",
                              style: juzNumberStyle().copyWith(
                                fontSize: 28,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        // العداد
                        Text(
                          '${cubit.count}/99',
                          style: quranAyahStyle().copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    // زر الإعادة
                    GestureDetector(
                      onTap: cubit.resultcount,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.refresh,
                          size: 40,
                          color: primaryColor,
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
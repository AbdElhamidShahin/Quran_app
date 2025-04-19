import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/model/bloc/states.dart';

class CounterCubit extends Cubit<PrayerState> {
  CounterCubit() : super(PrayerInitial());

  static CounterCubit get(context) => BlocProvider.of<CounterCubit>(context);

  int count = 0;

  void addNumber() {
    count++;
    if (count > 99) {
      count = 1;
    }
    emit(addNumberState(count: count));
  }

  void resultcount() {
    count = 0;
    emit(resultcountState(count: count));
  }

  String Options() {
    if (count <= 33) {
      return 'سبحان الله ';
    } else if (count <= 66) {
      return 'الحمد الله ';
    } else if (count <= 99) {
      return ' الله اكبر';
    } else {
      return 'خطأ';
    }
  }
}

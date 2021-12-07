import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0) {
    ///initiazation
  }

  void increase() {
    emit(state + 1);
  }

  void decrease() {
    emit(state - 1);
  }
}

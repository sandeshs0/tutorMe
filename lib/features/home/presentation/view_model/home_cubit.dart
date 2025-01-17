import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<DashboardState> {
  HomeCubit() : super(DashboardState.initial());

  void selectTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}

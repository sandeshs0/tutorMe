import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tutorme/model/tutor_model.dart';

part 'tutor_event.dart';
part 'tutor_state.dart';

class TutorBloc extends Bloc<TutorEvent, TutorState> {
  TutorBloc() : super(TutorState.initial()) {
    on<TutorEvent>((event, emit) {

    });
  }
}

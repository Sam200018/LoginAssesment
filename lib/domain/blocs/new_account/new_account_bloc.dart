import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_account_event.dart';
part 'new_account_state.dart';

class NewAccountBloc extends Bloc<NewAccountEvent, NewAccountState> {
  NewAccountBloc() : super(NewAccountInitial()) {
    on<NewAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

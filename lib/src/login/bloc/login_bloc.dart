import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turizm_uz/src/login/bloc/login_state.dart';

import '../repo/login_repo.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginLoadingState()) {
    on<LoginEvent>((event, emit) {
      emit(LoginLoadingState());
    });
    on<LoginEventData>(_loginHandler);
  }

  Future<void> _loginHandler(
    LoginEventData event,
    Emitter<LoginState> emit,
  ) async {

    final result = await login(username: event.username, password: event.password);

    if(result['code'] == 1) {

    } else {

    }
  }
}

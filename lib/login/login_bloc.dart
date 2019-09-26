import 'package:bloc/bloc.dart';
import 'package:debt_collector/login/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  @override
  InitialLoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SubmitLoginEvent) {
      yield LoginInProgressState();
      //todo fetchdata to check user
    }
  }
}
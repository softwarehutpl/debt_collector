import 'package:bloc/bloc.dart';
import 'package:debt_collector/login/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  @override
  InitialLoginState get initialState => InitialLoginState();

  //mocked data
  final login = "Login";
  final pass = "Password";

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SubmitLoginEvent) {
      yield LoginInProgressState();
      final credentialsAreCorrect = await _checkCredentials(event.login, event.password);
      yield LoginResponseState(credentialsAreCorrect);
    }
  }

  Future<bool> _checkCredentials(String login, String password) {
    return Future.delayed(Duration(seconds: 1), () {
      return login == this.login && password == pass;
    });
  }
}
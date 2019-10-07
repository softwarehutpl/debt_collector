import 'package:debt_collector/login/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final loginBloc = LoginBloc();
  final _userTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        builder: (BuildContext context) => loginBloc,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16.0),
          child: BlocBuilder(
            bloc: loginBloc,
            builder: (BuildContext context, LoginState loginState) {
              if (loginState is LoginResponseState) {
                return buildLoginResponseState();
              } else if (loginState is LoginInProgressState) {
                return buildLoginInProgressState();
              } else if (loginState is InitialLoginState) {
                return buildColumnWithData(context, loginState.usernameErrorMessage, loginState.passwordErrorMessage);
              }              
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Column buildColumnWithData(BuildContext context, String userErrorTextMessage, String passwordErrorTextMessage) {
    return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: TextField(
                controller: _userTextController,
                onChanged: (value) {
                  final loginBloc = BlocProvider.of<LoginBloc>(context);
                  loginBloc.dispatch(ValidateLoginEvent(_userTextController.text, _passwordTextController.text));
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    errorText: userErrorTextMessage,
                    border: OutlineInputBorder(),
                    hintText: "Enter Email",
                    labelText: "Email"
                ),
              ),
              padding: EdgeInsets.all(10.0),
            ),
            Padding(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _passwordTextController,
                onChanged: (value) {
                  final loginBloc = BlocProvider.of<LoginBloc>(context);
                  loginBloc.dispatch(ValidateLoginEvent(_userTextController.text, _passwordTextController.text));
                },
                obscureText: true,
                decoration: InputDecoration(
                    errorText: passwordErrorTextMessage,
                    border: OutlineInputBorder(),
                    hintText: "Enter Password",
                    labelText: "Password"
                ),
              ),
              padding: EdgeInsets.all(10.0),
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                submit(context);
              },
              child: Text("Submit"),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                color: Colors.green,
                onPressed: () {
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                },
                child: Text("Register"),
              ),
            )
          ],
        );
  }

  Widget buildLoginInProgressState() {
    return Center(
      child: Text("LOADING IN PROGRESS"),
    );
  }

  Widget buildLoginResponseState() {
    return Center(
      child: Text("LOGGED IN"),
    );
  }

  void submit(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    loginBloc.dispatch(SubmitLoginEvent(_userTextController.text, _passwordTextController.text));
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.dispose();
  }
}

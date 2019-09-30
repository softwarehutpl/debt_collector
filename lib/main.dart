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
              }
              return buildColumnWithData();
            },
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Column buildColumnWithData() {
    return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<String>(
              stream : null,
              builder: (context, snapshot) => Padding(
                child: TextField(
                  onChanged: null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Email",
                      labelText: "Email"
                  ),
                ),
                padding: EdgeInsets.all(10.0),
              ),
            ),
            StreamBuilder<String>(
              stream: null,
              builder: (context, snapshot) => Padding(
                child: TextField(
                  keyboardType: TextInputType.text,
                  onChanged: null,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Password",
                      labelText: "Password"
                  ),
                ),
                padding: EdgeInsets.all(10.0),
              ),
            ),
            StreamBuilder<bool>(
              stream: null,
              builder: (context, snapshot) => RaisedButton(
                color: Colors.green,
                onPressed: (snapshot.hasData && snapshot.data == true) ?
                    () {
                  //login
                } : null,
                child: Text("Submit"),
              ),
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

  @override
  void dispose() {
    super.dispose();
    loginBloc.dispose();
  }
}

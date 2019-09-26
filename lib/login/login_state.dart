
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const[]]) : super(props);
}

class InitialLoginState extends LoginState { }

class LoginInProgressState extends LoginState { }

class LoginResponseState extends LoginState {
  final bool response;
  LoginResponseState(this.response) : super([response]);
}
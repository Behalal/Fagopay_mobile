import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();

  @override
  List<Object> get props => [];
}

class LoginStateLaoding extends LoginState {
  const LoginStateLaoding();

  @override
  List<Object> get props => [];
}

class LoginStateSuccess extends LoginState {
  const LoginStateSuccess(); 

  @override
  
  List<Object> get props => [];
}

class LoginStateerror extends LoginState {
  final String error;
  const LoginStateerror(this.error);

  @override
  List<Object> get props => [error];
}

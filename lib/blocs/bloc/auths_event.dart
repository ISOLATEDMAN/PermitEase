part of 'auths_bloc.dart';

abstract class AuthsEvent extends Equatable {
  const AuthsEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginReq extends AuthsEvent {
  final String email;
  final String pass;

  const AuthLoginReq({required this.email, required this.pass});

  @override
  List<Object> get props => [email, pass];
}

class AuthSignoutReq extends AuthsEvent {}

class AuthCreateReq extends AuthsEvent{
  final String email;
  final String pass;
  const AuthCreateReq({required this.email,required this.pass});
  @override
  List<Object> get props => [email, pass];

}

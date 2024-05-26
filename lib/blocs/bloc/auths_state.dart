part of 'auths_bloc.dart';

 class AuthsState extends Equatable {
  const AuthsState();
  
  @override
  List<Object> get props => [];
}

final class AuthsInitial extends AuthsState {}


class AuthSucces extends AuthsState{
  final User user;

  AuthSucces({required this.user});
  @override
  List<Object> get props => [user];
  
}

class AuthFailed extends AuthsState{
  final String msg;
  AuthFailed({required this.msg});
  @override
  List<Object> get props => [msg];
}

class AuthLoading extends AuthsState{}

class AuthCreate extends AuthsState{
  
}

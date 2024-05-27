part of 'profile_store_bloc.dart';

class ProfileStoreState extends Equatable {
  const ProfileStoreState();
  
  @override
  List<Object> get props => [];
}

final class ProfileStoreInitial extends ProfileStoreState {}

class ProfilecreateSuccess extends ProfileStoreState{

}

class ProfilecreateFailed extends ProfileStoreState{
  final String msg;
  const ProfilecreateFailed({required this.msg});
  @override
  List<Object> get props => [msg];
}






part of 'profile_store_bloc.dart';

abstract class ProfileStoreEvent extends Equatable {
  const ProfileStoreEvent();

  @override
  List<Object> get props => [];
}

class ProfileAdd extends ProfileStoreEvent{
  final String name;
  final String phno;
  final String email;
  final bool admin_stat;

  const ProfileAdd({required this.name,required this.phno,required this.email,required this.admin_stat});
  @override
  List<Object> get props => [name,phno,email,admin_stat];
}



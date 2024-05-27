import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permitease/utils/profile_store.dart';

part 'profile_store_event.dart';
part 'profile_store_state.dart';

class ProfileStoreBloc extends Bloc<ProfileStoreEvent, ProfileStoreState> {
  final ProfileStore _profileStore;
  ProfileStoreBloc({required ProfileStore profile_store}):_profileStore = profile_store,super(ProfileStoreInitial()) {
  on<ProfileAdd>(_addprofile);
  }
  void _addprofile(ProfileAdd event,Emitter<ProfileStoreState> emit )async{
    try{
      await _profileStore.createProfile(event.name, event.phno, event.email,event.admin_stat);
      emit(ProfilecreateSuccess());
    }
    catch(e){
      emit(ProfilecreateFailed(msg: e.toString()));
    }
  }
}

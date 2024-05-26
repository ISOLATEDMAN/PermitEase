import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permitease/utils/auth_repo.dart';

part 'auths_event.dart';
part 'auths_state.dart';

class AuthsBloc extends Bloc<AuthsEvent, AuthsState> {
  final AuthRepo _authRepo;

  AuthsBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AuthsInitial()) {
    on<AuthLoginReq>(_onLoginRequested);
    on<AuthSignoutReq>(_onSignoutRequested);
    on<AuthCreateReq>(_oncreateRequested);
  }

  void _onLoginRequested(AuthLoginReq event, Emitter<AuthsState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepo.loginwithemailpass(event.email, event.pass);
      emit(AuthSucces(user: user!));
    } catch (e) {
      emit(AuthFailed(msg: e.toString()));
    }
  }

  void _onSignoutRequested(AuthSignoutReq event, Emitter<AuthsState> emit) async {
    emit(AuthLoading());
    await _authRepo.signout();
    emit(AuthsInitial());
  }
  void _oncreateRequested(AuthCreateReq event,Emitter<AuthsState>emit)async{
    emit(AuthLoading());
    try{
      final user = await _authRepo.signupwithemailandpass(event.email, event.pass);
      emit(AuthSucces(user: user!));
    }
    catch(e){
      emit(AuthFailed(msg: e.toString()));
    }
  }
}

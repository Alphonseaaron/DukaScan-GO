import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:dukascan_go/domain/services/auth_Services.dart';
import 'package:dukascan_go/domain/models/response/response_login.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthState()) {

    on<LoginEvent>( _onLogin );
    on<CheckLoginEvent>( _onCheckLogin );
    on<LogOutEvent>( _onLogOut );

  }

  
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {

    try {

      emit( LoadingAuthState() );

      final data = await authServices.loginController(event.email, event.password);

      await Future.delayed(Duration(milliseconds: 850));

      if( data.resp ){

        final user = User.fromFirebase(data.user!);

        emit( state.copyWith(user: user, rolId: user.rolId.toString()));

      } else {
        emit(FailureAuthState(data.msg));
      }
      
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }

  }

  
  Future<void> _onCheckLogin(CheckLoginEvent event, Emitter<AuthState> emit) async {

    try {

      emit( LoadingAuthState() );

      final data = await authServices.renewLoginController();

      if( data.resp ){

        final user = User.fromFirebase(data.user!);

        emit( state.copyWith(user: user, rolId: user.rolId.toString() ));

      }else{
        emit(LogOutAuthState());
      }
      
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }

  }
  

  Future<void> _onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {

    await FirebaseAuth.instance.signOut();
    emit( LogOutAuthState() );
    return emit( state.copyWith( user: null, rolId: ''));

  }



}

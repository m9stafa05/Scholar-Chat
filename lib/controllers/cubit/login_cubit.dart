import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> logInUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final auth = FirebaseAuth.instance;
      UserCredential user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: "This email is not found"));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: "Wrong password"));
      } else if (e.code == 'invalid-email') {
        emit(
          LoginFailure(errorMessage: "Please enter a valid email"),
        );
      } else if (e.code == 'too-many-requests') {
        emit(
          LoginFailure(
            errorMessage: "Too many requests. Please try again later",
          ),
        );
      } else {
        emit(LoginFailure(errorMessage: "Unexpected error"));
        debugPrint(e.code);
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: "Opps SomeThing Went Wrong"));
    }
  }
}

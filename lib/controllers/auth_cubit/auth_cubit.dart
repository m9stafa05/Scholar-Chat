import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      final auth = FirebaseAuth.instance;
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(
          RegisterFailure(
            errorMessage: 'This email is already exists',
          ),
        );
      } else if (e.code == 'weak-password') {
        emit(
          RegisterFailure(
            errorMessage:
            'Your password is too weak, at least 8 characters',
          ),
        );
      } else if (e.code == 'invalid-email') {
        emit(
          RegisterFailure(errorMessage: 'Please enter a valid email'),
        );
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: 'Something went wrong'));
      debugPrint(e.toString());
    }
  }
}

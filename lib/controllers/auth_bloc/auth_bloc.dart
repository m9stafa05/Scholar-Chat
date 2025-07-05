import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final auth = FirebaseAuth.instance;
        UserCredential user = await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(LoginFailure(errorMessage: "This email is not found"));
        } else if (e.code == 'wrong-password') {
          emit(LoginFailure(errorMessage: "Wrong password"));
        } else if (e.code == 'invalid-email') {
          emit(LoginFailure(errorMessage: "Please enter a valid email"));
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
        emit(LoginFailure(errorMessage: "Ops SomeThing Went Wrong"));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        final auth = FirebaseAuth.instance;
        UserCredential user = await auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(RegisterSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          emit(RegisterFailure(errorMessage: 'This email is already exists'));
        } else if (e.code == 'weak-password') {
          emit(
            RegisterFailure(
              errorMessage: 'Your password is too weak, at least 8 characters',
            ),
          );
        } else if (e.code == 'invalid-email') {
          emit(RegisterFailure(errorMessage: 'Please enter a valid email'));
        }
      } catch (e) {
        emit(RegisterFailure(errorMessage: 'Something went wrong'));
        debugPrint(e.toString());
      }
    });
  }
}

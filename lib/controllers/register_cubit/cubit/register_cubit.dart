import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

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

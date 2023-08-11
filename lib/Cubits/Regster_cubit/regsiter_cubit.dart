
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'regsiter_state.dart';

class RegsiterCubit extends Cubit<RegsiterState> {
  RegsiterCubit() : super(RegsiterInitial());

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegsiterWeating());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegsiterSuccess());
    } on FirebaseException catch (e) {
      emit(RegsiterFailuer(eM: "$e"));
    }
  }
}

      
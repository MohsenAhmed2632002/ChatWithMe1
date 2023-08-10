import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginWeating());
    try {
      
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
      // return user;
      
    }on FirebaseException catch (e) {
      emit(LoginFailuer(eM: "$e"));
    }
  }
  // Future<UserCredential?> loginUser(
  //     {required String email, required String password}) async {
  //   emit(LoginWeating());
  //   try {
  //     UserCredential user =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     emit(LoginSuccess());
  //     return user;
      
  //   } on Exception catch (e) {
  //     print(e);
  //     emit(LoginFailuer());
  //   }
  // }
}

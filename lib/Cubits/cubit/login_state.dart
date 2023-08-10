part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


final class LoginSuccess extends LoginState {
}


final class LoginWeating extends LoginState {}


final class LoginFailuer extends LoginState {}


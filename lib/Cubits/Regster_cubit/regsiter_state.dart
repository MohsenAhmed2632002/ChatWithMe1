part of 'regsiter_cubit.dart';

@immutable
sealed class RegsiterState {}

final class RegsiterInitial extends RegsiterState {}

final class RegsiterSuccess extends RegsiterState {}

final class RegsiterWeating extends RegsiterState {}

final class RegsiterFailuer extends RegsiterState {
  String eM;
  RegsiterFailuer({required this.eM});
}

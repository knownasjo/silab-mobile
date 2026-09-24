part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final String? message;
  final LoginDataEntity? data;

  const AuthenticationState({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [message, data];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess({super.data});
}

final class AuthenticationFailed extends AuthenticationState {
  const AuthenticationFailed({super.message});
}

final class AuthenticationUnverified extends AuthenticationState {
  final String email;

  const AuthenticationUnverified({required this.email, super.message});

  @override
  List<Object?> get props => [email, message];
}

class SessionExpired extends AuthenticationState {}

final class UserLoggedOut extends AuthenticationState {}

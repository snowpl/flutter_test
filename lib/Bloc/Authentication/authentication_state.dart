part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable { 
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Unitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String displayName;

  const Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Authenticated { displayName: $displayName }';
}

class Unauthenticated extends AuthenticationState {}
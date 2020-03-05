part of 'login_bloc.dart';

abstract class LoginEvents extends Equatable{
  const LoginEvents();

  @override
  List<Object> get props => [];
}

class Submitted extends LoginEvents{
  final String email;
  final String password;

  const Submitted({
    @required this.email,
    @required this.password
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}

class LoginWithGooglePressed extends LoginEvents {}

class LoginWithCredentialsPressed extends LoginEvents {
  final String email;
  final String password;

  const LoginWithCredentialsPressed({
    @required this.email,
    @required this.password
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed{ email: $email, password: $password }';
  }
}

class EmailChanged extends LoginEvents {
  final String email;

  const EmailChanged({
    @required this.email
  });

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends LoginEvents {
  final String password;

  const PasswordChanged({
    @required this.password
  });

  @override
  List<Object> get props => [password];
  
  @override
  String toString() => 'PasswordChanged { password :$password }';
}
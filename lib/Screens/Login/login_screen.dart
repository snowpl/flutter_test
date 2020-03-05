import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/Bloc/Login/login_bloc.dart';
import 'package:my_app/Repositories/userRepository.dart';
import 'package:my_app/Screens/Login/login_form.dart';

class LoginScreen extends StatelessWidget{
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
    :assert(userRepository!= null),
    _userRepository = userRepository,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository)),
    );
  }
    
}
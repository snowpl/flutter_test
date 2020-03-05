import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/Authentication/authentication_bloc.dart';
import 'Bloc/bloc_delegate.dart';
import 'Repositories/userRepository.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/splash_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = BaseBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
      ..add(AppStarted()),
      child: MyApp(userRepository: userRepository))
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({Key key, UserRepository userRepository})
    : assert(userRepository!=null),
    _userRepository = userRepository,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is Unitialized){
            return SplashScreen();
          } else if(state is Authenticated){
            return HomeScreen(name: state.displayName);
          } else if(state is Unauthenticated){
            return LoginScreen(userRepository: _userRepository);
          }
          return Container();
        },
        )
    );
  }
}

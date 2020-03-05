import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/Bloc/Login/login_bloc.dart';

class GoogleLoginButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
      },
      icon: Icon(FontAwesomeIcons.google, color: Colors.white),
      label: Text('Sign in with Google', style: TextStyle(color: Colors.white)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      color: Colors.redAccent,
      );
  }
}

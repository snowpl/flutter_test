import 'package:flutter/material.dart';
import 'package:my_app/Repositories/userRepository.dart';
import 'package:my_app/Screens/Register/register_screen.dart';

class CreateAccountButton extends StatelessWidget{
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
    :assert(userRepository!= null),
      _userRepository = userRepository,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Create an account'),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}
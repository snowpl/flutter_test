import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:my_app/Repositories/userRepository.dart';
import 'package:my_app/Validators/login_validator.dart';

part 'login_state.dart';
part 'login_events.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  UserRepository _userRepository;
  
  LoginBloc({
    @required UserRepository userRepository,
  })
  : assert(userRepository != null),
    _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvents> events,
    Stream<LoginState> Function(LoginEvents event) next
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged && event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    if(event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
  }
  
  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }
  
  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try{
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    }catch(_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password
  }) async* {
    yield LoginState.loading();
    try{
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    }catch(_) {
      yield LoginState.failure();
    }
  }
}
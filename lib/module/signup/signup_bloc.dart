import 'dart:async';

import 'package:appbook/base/base_bloc.dart';
import 'package:appbook/base/base_event.dart';
import 'package:appbook/data/repo/user_repo.dart';
import 'package:appbook/event/signin_event.dart';
import 'package:appbook/event/signup_event.dart';
import 'package:appbook/event/signup_fail_event.dart';
import 'package:appbook/event/signup_success_event.dart';
import 'package:appbook/shared/widget/vadation.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BaseBloc{

  UserRepo? _userRepo;
  SignUpBloc({required UserRepo userRepo}){
    _userRepo = userRepo;
      validateForm();
  }

  // Validation
  var phoneValidation =
      StreamTransformer<String, String?>.fromHandlers(handleData: (phone, sink) {
        if(Validation.isPhoneValid(phone)){
          sink.add(null);
          return;
        }
        sink.add('Phone invalid');
      },);

  var passValidation =
      StreamTransformer<String, String?>.fromHandlers(handleData: (pass, sink) {
        if(Validation.isPassValid(pass)){
          sink.add(null);
          return;
        }
        sink.add('Password too short');
      },);

  var displayNameValidation =
      StreamTransformer<String, String?>.fromHandlers(handleData: (name, sink) {
        if(Validation.isDisplayNameValid(name)){
          sink.add(null);
          return;
        }
        sink.add('Name too short');
      },);

  final _phoneSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _nameSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  Stream<String?> get phoneStream => _phoneSubject.stream.transform(phoneValidation);
  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String?> get passStream => _passSubject.stream.transform(passValidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<String?> get nameStream => _nameSubject.stream.transform(displayNameValidation);
  Sink<String> get nameSink => _nameSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  validateForm(){
    Rx.combineLatest3(_phoneSubject, _passSubject, _nameSubject, (phone, pass, name){
      return Validation.isPhoneValid(phone) && Validation.isPassValid(pass) && Validation.isDisplayNameValid(name);
    }).listen((event) {
      btnSink.add(event);
    });
  }

  @override
  void dispatchEvnet(BaseEvent event) {
    switch(event.runtimeType){
      case SignUpEvent:
        handleSignUp(event);
        break;

      case SignInEvent:
        handleSignIn(event);
        break;
    }

  }

  handleSignIn(event){}
  handleSignUp(event){
      btnSink.add(false);
      loadingSink.add(true);

      Future.delayed(Duration(seconds: 6), (){
        SignUpEvent e = event as SignUpEvent;
        _userRepo?.signUp(e.displayName, e.phone, e.pass).then(
                (value) {
              processEventSink.add(SignupSuccessEvent(userData: value));
              print(value);
            },
            onError: (e){
              print(e);
              btnSink.add(true);
              loadingSink.add(false);
              processEventSink.add(SignupFailEvent(errMessage: e));
            }
        );
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneSubject.close();
    _passSubject.close();
    _nameSubject.close();
    _btnSubject.close();
  }
}

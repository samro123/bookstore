import 'dart:async';

import 'package:appbook/base/base_bloc.dart';
import 'package:appbook/base/base_event.dart';
import 'package:appbook/data/repo/user_repo.dart';
import 'package:appbook/event/signin_event.dart';
import 'package:appbook/event/signin_fail_event.dart';
import 'package:appbook/event/signin_success_event.dart';
import 'package:appbook/event/signup_event.dart';
import 'package:appbook/shared/model/user_data.dart';
import 'package:appbook/shared/widget/vadation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SignInBloC extends BaseBloc{
  UserRepo? _userRepo;
  SignInBloC({required UserRepo userRepo}) {
    _userRepo = userRepo;
    validateForm();
  }

  // Validation
   //transform
  var phoneValidation =
  StreamTransformer<String, String?>.fromHandlers(handleData: (phone, sink) {
    if (Validation.isPhoneValid(phone)) {
      sink.add(null);
      return;
    }
    sink.add('Phone invalid');
  });

  var passValidation =
  StreamTransformer<String, String?>.fromHandlers(
    // sau transform phone dung sink de day ra
    handleData: (pass, sink){
      if(Validation.isPassValid(pass)){
        sink.add(null);
        return;
      }
      sink.add('Password too short');
    } ,
  );

   final _phoneSubject = BehaviorSubject<String>();
   final _passSubject = BehaviorSubject<String>();
   final _btnSubject = BehaviorSubject<bool>();

   Stream<String?> get phoneStream => _phoneSubject.stream.transform(phoneValidation);
   Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String?> get passStream => _passSubject.stream.transform(passValidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  validateForm(){
    Rx.combineLatest2(_phoneSubject, _passSubject, (phone, pass){
      return Validation.isPhoneValid(phone) && Validation.isPassValid(pass);
    }).listen((event) {
      btnSink.add(event);
    });
  }


  @override
  void dispatchEvnet(BaseEvent event) {
        switch(event.runtimeType){
          case SignInEvent:
            handleSignIn(event);
            break;

          case SignUpEvent:
            handleSignUp(event);
            break;
        }
   }

   handleSignIn(event){
    btnSink.add(false); // khi bat dau call api thi disable nut sign in
    loadingSink.add(true);

    Future.delayed(Duration(seconds: 6), (){
      SignInEvent e = event as SignInEvent;
      _userRepo?.signIn(e.phone, e.pass).then(
              (value){
                processEventSink.add(SignInSucessEvent(userData: value));
            print(value);
          },
          onError: (e){
            print(e);
            btnSink.add(true);
            loadingSink.add(false);
            processEventSink.add(SignInFailEvent(errMessage: e));
          }
      );
    });

   }

  handleSignUp(event){

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneSubject.close();
    _passSubject.close();
    _btnSubject.close();
  }

}
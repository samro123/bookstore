import 'package:appbook/base/base_event.dart';

class SignUpEvent extends BaseEvent{
  String phone;
  String displayName;
  String pass;
  SignUpEvent({required this.phone, required this.displayName, required this.pass});

}
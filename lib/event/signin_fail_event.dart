import 'package:appbook/base/base_event.dart';

class SignInFailEvent extends BaseEvent{
  final String errMessage;
  SignInFailEvent({required this.errMessage});

}
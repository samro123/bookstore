import 'package:appbook/base/base_event.dart';
import 'package:appbook/shared/model/user_data.dart';

class SignInSucessEvent extends BaseEvent{
  final UserData userData;
  SignInSucessEvent({required this.userData});
}
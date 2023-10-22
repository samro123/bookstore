import 'package:appbook/base/base_event.dart';
import 'package:appbook/shared/model/user_data.dart';
import 'package:flutter/material.dart';

class SignupSuccessEvent extends BaseEvent{
  final UserData userData;
  SignupSuccessEvent({required this.userData});
}
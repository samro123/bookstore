import 'package:appbook/base/base_event.dart';
import 'package:flutter/material.dart';

class SignupFailEvent extends BaseEvent{
  final String errMessage;
  SignupFailEvent({required this.errMessage});
}
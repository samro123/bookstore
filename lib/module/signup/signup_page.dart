import 'package:appbook/base/base_event.dart';
import 'package:appbook/base/base_widget.dart';
import 'package:appbook/data/remote/user_service.dart';
import 'package:appbook/data/repo/user_repo.dart';
import 'package:appbook/event/signup_event.dart';
import 'package:appbook/event/signup_fail_event.dart';
import 'package:appbook/event/signup_success_event.dart';
import 'package:appbook/module/signup/signup_bloc.dart';
import 'package:appbook/shared/widget/bloc_listener.dart';
import 'package:appbook/shared/widget/loading_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/widget/app_color.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'SignIn',
      di: [
        Provider.value(value: UserService()),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) => UserRepo(userService: userService),
        )
      ],
      bloc: [],
      child: SignUpFormWidget(),
    );
  }
}

class SignUpFormWidget extends StatefulWidget {
  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final TextEditingController _txtPhoneController = TextEditingController();

  final TextEditingController _txtPassController = TextEditingController();

  final TextEditingController _txtNameController = TextEditingController();

  handleEvent(BaseEvent event){
    if(event is SignupSuccessEvent){

    }
    if(event is SignupFailEvent){
      final snackBar = SnackBar(
          content: Text(event.errMessage),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SignUpBloc>.value(
        value: SignUpBloc(userRepo: Provider.of(context)),
      child: Consumer<SignUpBloc>(
        builder: (context, bloc, child) {
          return BlocListener<SignUpBloc>(
            listener: handleEvent,
            child: LoadingTask(
              bloc: bloc,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNameField(bloc),
                    _buildPhoneField(bloc),
                    _buildPassField(bloc),
                    _buildButton(bloc)

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhoneField(SignUpBloc bloc){
      return StreamProvider<String?>.value(
          value: bloc.phoneStream,
          initialData: null,
          child: Consumer<String?>(
          builder: (context, mgs, child) => TextField(
            controller: _txtPhoneController,
            onChanged: (text) {
              bloc.phoneSink.add(text);
              print(mgs);
            },
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: AppColor.blue,),
              hintText: '012345678',
              labelText: 'Phone',
              labelStyle: TextStyle(color: Colors.blue),
              errorText: mgs,
            ),
          ),
      ),
      );
  }

  Widget _buildNameField(SignUpBloc bloc){
    return StreamProvider<String?>.value(
        value: bloc.nameStream,
        initialData: null,
        child: Consumer<String?>(
          builder: (context, mgs, child) => TextField(
            controller: _txtNameController,
            onChanged: (text) {
              bloc.nameSink.add(text);
              print(mgs);
            },
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: AppColor.blue,),
              hintText: 'Entern Name',
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.blue),
              errorText: mgs,

            ),
          ),
        ),
    );
  }

  Widget _buildPassField(SignUpBloc bloc){
    return StreamProvider<String?>.value(
        value: bloc.passStream,
        initialData: null,
        child: Consumer<String?>(
          builder: (context, msg, child) => TextField(
            controller: _txtPassController,
            onChanged: (text) {
              bloc.passSink.add(text);
              print(msg);
            },
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: AppColor.blue,),
              hintText: 'Password',
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.blue),
              errorText: msg,
            ),
          ),
        ),
    );
  }

  Widget _buildButton(SignUpBloc bloc){
    return ElevatedButton(onPressed: (){
      bloc.event.add(SignUpEvent(
          phone: _txtPhoneController.text,
          displayName: _txtNameController.text,
          pass: _txtPassController.text));
    }
      //day event

    , child: Text('Sign Up'));
  }
}



import 'package:appbook/base/base_event.dart';
import 'package:appbook/base/base_widget.dart';
import 'package:appbook/data/remote/user_service.dart';
import 'package:appbook/data/repo/user_repo.dart';
import 'package:appbook/event/signin_event.dart';
import 'package:appbook/event/signin_fail_event.dart';
import 'package:appbook/event/signin_success_event.dart';
import 'package:appbook/module/signin/signin_bloc.dart';
import 'package:appbook/module/signup/signup_page.dart';
import 'package:appbook/shared/widget/app_color.dart';
import 'package:appbook/shared/widget/bloc_listener.dart';
import 'package:appbook/shared/widget/loading_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: 'Sign In',
        di: [
          Provider.value(value: UserService()),
          ProxyProvider<UserService, UserRepo>(
              update: (context, userService, previous) => UserRepo(userService: userService),
          )
        ],
        bloc: [],
        child: SignInFormWidget()
    );
  }
}

class SignInFormWidget extends StatefulWidget {
  @override
  State<SignInFormWidget> createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  final TextEditingController _txtPhoneController = TextEditingController();

  final TextEditingController _txtPassController = TextEditingController();

  handleEvent(BaseEvent event){
    if(event is SignInSucessEvent){
      Navigator.pushReplacementNamed(context, '/home');
    }
    if(event is SignInFailEvent){
      final snackBar = SnackBar(
          content: Text(event.errMessage),
          backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);// thanh error o duoi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SignInBloC>.value(
      value: SignInBloC(userRepo: Provider.of(context)),
      child: Consumer<SignInBloC>(
        builder: (context, bloc, child) {
          return BlocListener<SignInBloC>(
            listener: handleEvent,
            child: LoadingTask(
              bloc: bloc,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPhoneField(bloc),
                    _buildPassField(bloc),
                    _buildButton(bloc),
                    _builFooter(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton(SignInBloC bloC){
    return ElevatedButton(onPressed: (){
      //day event
      bloC.event.add(SignInEvent(
          phone: _txtPhoneController.text,
          pass: _txtPassController.text
      ));
    }, child: Text('Login'));
  }

  Widget _buildPhoneField(SignInBloC bloC){
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloC.phoneStream,
      child: Consumer<String?>(
        builder: (context, mgs, child) => TextField(
          controller: _txtPhoneController,
          onChanged: (text) {
            bloC.phoneSink.add(text);
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

  Widget _buildPassField(SignInBloC bloC){
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloC.passStream,
      child: Consumer<String?>(
        builder: (context, smg, child) => TextField(
          controller: _txtPassController,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            bloC.passSink.add(value);
          },
          cursorColor: Colors.black,
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.phone, color: AppColor.blue,),
              hintText: 'Password',
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.blue),
              errorText: smg
          ),
        ),
      ),
    );
  }

  Widget _builFooter(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/sign-up');
      },
      child: Container(
          padding: EdgeInsets.all(20),
          child: Text('Reigister Account')),
    );
  }
}


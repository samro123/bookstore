import 'dart:async';

import 'package:appbook/data/remote/user_service.dart';
import 'package:appbook/data/spref/Spref.dart';
import 'package:appbook/shared/model/user_data.dart';
import 'package:appbook/shared/widget/contant.dart';
import 'package:dio/dio.dart';

class UserRepo{
    UserService _userService;

    UserRepo({ required UserService userService}) : _userService = userService;

    //tra ra doi tuong user data // signin
    Future<UserData> signIn(String phone, String pass) async {
        var c = Completer<UserData>();

        try{
            var respone = await _userService.signIn(phone, pass);
            var userData = UserData.fromJson(respone.data['data']);
            if(userData != null){
                SPref.instance.set(SPerfCache.KEY_TOKEN, userData.token);
                c.complete(userData);
            }
        } on DioError catch(e){
            print(e.response?.data);// error backend tra ve
            c.completeError('Dang Nhap that bai');
        } catch(e){
            c.completeError(e);
        }


        return c.future;
    }
    
    //sign up
    Future<UserData> signUp(String displayName, String phone, String pass) async {
        var c = Completer<UserData>();
        try{
            var respone = await _userService.signUp(displayName, phone, pass);
             var userData = UserData.fromJson(respone.data['data']);
             if(userData != null){
                 SPref.instance.set(SPerfCache.KEY_TOKEN, userData.token);
                 c.complete(userData);
             }
        } on DioError catch(e){
            print(e.response?.data);
            c.completeError('Dang ky that bai');
        } catch(e){
            c.completeError(e);
        }

        return c.future;
    }


}
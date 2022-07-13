import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  late LoginModel loginModel;//ba5od object fady mn LoginModel w b save feh t7t line 37

  void userLogin({
  required String email,
  required String password,
})
  {

    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        },

    ).then((value)
    {

      //print(value.data);
      loginModel= LoginModel.fromJson(value.data);
      // print('status :${loginModel.status}');
      // print('message :${loginModel.message}');
      // print('token :${loginModel.data?.token}');
      emit(LoginSuccessState(loginModel));// b3t al login model m3 el state de
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }




  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix = isPassword?Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
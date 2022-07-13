import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/register_model.dart';
import '../../../shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit():super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  late RegisterModel registerModel;

  void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
})
  {

    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },

    ).then((value)
    {

      //print(value.data);
      registerModel= RegisterModel.fromJson(value.data);
      // print('status :${loginModel.status}');
      // print('message :${loginModel.message}');
      // print('token :${loginModel.data?.token}');
      emit(RegisterSuccessState(registerModel));// b3t al login model m3 el state de
    }).catchError((error)
    {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }




  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix = isPassword?Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
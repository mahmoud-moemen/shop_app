import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/component/components.dart';


import '../../shared/component/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen ({Key? key}) : super(key: key);

  var FormKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state)
        {
          if(state is LoginSuccessState)
            {
              if(state.loginModel.status)
              {
                print(state.loginModel.message);
                print(state.loginModel.data?.token);

                showToast(
                  text:state.loginModel.message ,
                  state: toastStates.SUCCESS
                );
                CacheHelper.saveData(key: 'token', value:state.loginModel.data?.token )
                    .then((value)
                {
                  token = state.loginModel.data?.token;
                  navigateAndFinish(context, ShopLayout());
                });
              }else
              {
                print(state.loginModel.message);

                showToast(text:state.loginModel.message ,
                    state: toastStates.ERROR);
              }
            }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children:
                      [
                        Text(
                          'LOGIN',
                          style:Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Login Now To Browse Our Hot Offers',
                          style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your email address';
                              }
                              return null;

                            },
                            label: 'Email Address',
                            prefix:Icons.email_outlined),
                        SizedBox(height: 20.0,),
                        defaultFormField(
                            controller: passwordController,
                            onSubmitted: (value)
                            {
                              if (FormKey.currentState != null && FormKey.currentState!.validate())
                              {

                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password:passwordController.text );
                              }
                            },
                            type: TextInputType.visiblePassword,
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your password';
                              }
                              return null;


                            },
                            label: 'Password',
                            prefix:Icons.lock_clock_outlined,
                            isPassword:LoginCubit.get(context).isPassword,
                            suffix:LoginCubit.get(context).suffix ,
                            suffixPressed: ()
                            {
                              LoginCubit.get(context).changePasswordVisibility();
                            }),
                        SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition:state is! LoginLoadingState ,
                          builder:(context)=>defaultButton(
                            callback: ()
                            {
                              if (FormKey.currentState != null && FormKey.currentState!.validate())
                              {

                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password:passwordController.text );
                              }

                            },
                            text:'login'  ) ,
                          fallback:(context)=> Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Don\'t have an account',
                            ),
                            defaultTextButton(callback:
                                ()
                            {
                              navigateTo(context, RegisterScreen());
                            }
                                , text: 'register'),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

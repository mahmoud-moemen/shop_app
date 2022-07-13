import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';

import '../../layout/shop_layout/shop_layout.dart';
import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';
import '../../shared/network/local/cache_helper.dart';



class RegisterScreen extends StatelessWidget {



  var FormKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state)
        {
          if(state is RegisterSuccessState)
          {
            if(state.registerModel.status)
            {
              print(state.registerModel.message);
              print(state.registerModel.data?.token);

              showToast(
                  text:state.registerModel.message ,
                  state: toastStates.SUCCESS
              );
              CacheHelper.saveData(key: 'token', value:state.registerModel.data?.token )
                  .then((value)
              {
                token = state.registerModel.data?.token;
                navigateAndFinish(context, ShopLayout());
              });
            }else
            {
              print(state.registerModel.message);

              showToast(text:state.registerModel.message ,
                  state: toastStates.ERROR);
            }
          }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(
              title: Text('Register screen'),
            ),
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
                          'REGISTER',
                          style:Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Register Now To Browse Our Hot Offers',
                          style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your name';
                              }
                              return null;

                            },
                            label: 'User Name',
                            prefix:Icons.person),
                        SizedBox(height: 20.0,),
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
                            isPassword:RegisterCubit.get(context).isPassword,
                            suffix:RegisterCubit.get(context).suffix ,
                            suffixPressed: ()
                            {
                              RegisterCubit.get(context).changePasswordVisibility();
                            }),
                        SizedBox(height: 30.0),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your phone number';
                              }
                              return null;

                            },
                            label: 'Phone Number',
                            prefix:Icons.phone_android),
                        SizedBox(height: 20.0,),
                        ConditionalBuilder(
                          condition:state is! RegisterLoadingState ,
                          builder:(context)=>defaultButton(
                              callback: ()
                              {
                                if (FormKey.currentState != null && FormKey.currentState!.validate())
                                {

                                  RegisterCubit.get(context).userRegister
                                    (
                                      name:nameController.text ,
                                      email: emailController.text,
                                      password:passwordController.text,
                                      phone: phoneController.text
                                  );
                                }

                              },
                              text:'register'  ) ,
                          fallback:(context)=> Center(child: CircularProgressIndicator()),

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

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/layout_cubit/layout_states.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constants.dart';

class SettingsScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        var model= LayoutCubit.get(context).userModel;
        nameController.text=model.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;

        return ConditionalBuilder(
          condition:LayoutCubit.get(context).userModel !=null ,
          builder:(context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(

                children:
                [
                  if(state is LayoutUpdateUserDataLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 20.0,),
                  defaultFormField
                    (
                      controller: nameController,
                      type: TextInputType.name,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'name must not be empty ';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix:Icons.person
                  ),
                  SizedBox(height: 20.0,),
                  defaultFormField
                    (
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'email must not be empty ';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix:Icons.email_outlined
                  ),
                  SizedBox(height: 20.0,),
                  defaultFormField
                    (
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'phone must not be empty ';
                        }
                        return null;
                      },
                      label: 'Phone Number',
                      prefix:Icons.mobile_friendly
                  ),
                  SizedBox(height: 20.0,),
                  defaultButton
                    (
                      callback:()
                      {
                        if(formKey.currentState!.validate())
                        {
                          LayoutCubit.get(context).updateUserData
                            (
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }

                      },
                      text: 'Update'
                  ),
                  SizedBox(height: 20.0,),
                  defaultButton
                    (
                      callback:()
                      {
                        signOut(context);
                      },
                      text: 'Logout'
                    ),
                ],
              ),
            ),
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,

        );
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'layout/shop_layout/layout_cubit/layout_cubit.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() {
//بيتأكد ان كل حاجه في الميثود خلصت وبعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () async {
          DioHelper.inti();
          await CacheHelper.init();
          Widget widget;

          bool onBoarding=CacheHelper.getData(key:'onBoarding');

           token=CacheHelper.getData(key:'token');
           print('my token :${token}');
          if(onBoarding !=null)
            {
              if(token!=null) widget=ShopLayout();

              else widget=LoginScreen();

            }else
            {
              widget=OnBoardingScreen();
            }

          //print(onBoarding);
          runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget
{
  //const MyApp({Key? key}) : super(key: key);

  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LayoutCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,

        //onBoarding?LoginScreen(): OnBoardingScreen()
        home:startWidget,
      ),
    );
  }
}


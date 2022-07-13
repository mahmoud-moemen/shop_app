import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/layout_cubit/layout_states.dart';
import 'package:shop_app/modules/home_layout_screens/search/search_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/component/components.dart';


class ShopLayout extends StatelessWidget {
  ShopLayout ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit = LayoutCubit.get(context);

        return  Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions:
            [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body: cubit.bottomScreeens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index: index);
            },
            currentIndex: cubit.currentIndex,
            items:
            [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
              label: 'favorites',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
              label: 'settings',
            ),
            ]
            ,),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/layout_cubit/layout_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/update_user_model.dart';
import 'package:shop_app/modules/home_layout_screens/categories_screen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/change_favorites_model.dart';
import '../../../models/login_model.dart';
import '../../../models/profile_model.dart';
import '../../../modules/home_layout_screens/favorites_screen.dart';
import '../../../modules/home_layout_screens/products_screen.dart';
import '../../../modules/home_layout_screens/search/search_screen.dart';
import '../../../modules/home_layout_screens/settings_screen.dart';
import '../../../shared/network/end_points.dart';

class LayoutCubit extends Cubit<LayoutStates>
{
  LayoutCubit(): super(LayoutInitialState());

  static LayoutCubit get(context)=>BlocProvider.of(context);
/////////////////////////////////////////////////////
  int currentIndex=0;

  List<Widget> bottomScreeens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];


  void changeBottom({
   required int index
  })
  {
    currentIndex=index;
    emit(LayoutChangeBottomNavState());
  }
/////////////////////////////////////////////////////////////

   HomeModel? homeModel;
   late Map<int,bool> favorites={};

void getHomeData()
{
  emit(LayoutLoadingHomeDataState());

  DioHelper.getData(
    url: HOME,
    token:token,
  ).then((value) {

    homeModel=HomeModel.FromJson(value.data);
    //print(homeModel?.data.banners[0]['id']);
    //print(homeModel?.status);
    homeModel!.data.products.forEach((element) {
      favorites.addAll({
        element['id']:element['in_favorites']
      });
    });

   // print(favorites.toString());

    emit(LayoutSuccessHomeDataState());

  }).catchError((error){
    //print(error.toString());
    emit(LayoutErrorHomeDataState());
  });
}



  CategoriesModel? categoriesModel;
  void getCategories()
  {
    //emit(LayoutLoadingHomeDataState());

    DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value) {

      categoriesModel=CategoriesModel.fromJson(value.data);

      emit(LayoutSuccessCategoriesDataState());

    }).catchError((error){
      //print(error.toString());
      emit(LayoutErrorCategoriesDataState());
    });
  }



  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId]= !(favorites[productId]!);
    emit(LayoutChangeFavoritesDataState());
    DioHelper.postData(
        url: FAVORITES,
        data:
        {
          'product_id':productId,
        },
      token: token
    )
        .then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
     // print(value.data);

      if(!changeFavoritesModel.status)
        {
          favorites[productId]= !(favorites[productId]!);
        }else
        {
          getFavorites();
        }
      emit(LayoutSuccessChangeFavoritesDataState(changeFavoritesModel));
    })
        .catchError((error)
    {
      favorites[productId]= !(favorites[productId]!);
      emit(LayoutErrorChangeFavoritesDataState());
    });
  }


  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(LayoutLoadingGetFavoritesDataState());
    DioHelper.getData(
      url: FAVORITES,
      token:token,
    ).then((value) {

      favoritesModel=FavoritesModel.fromJson(value.data);
      //printFullText('favorites model:${value.data.toString()}');
      print('product id :${favoritesModel!.data!.data[0].id}');

      emit(LayoutSuccessGetFavoritesDataState());

    }).catchError((error){
     // print(error.toString());
      emit(LayoutErrorGetFavoritesDataState());
    });
  }
  ////////////////////////////////////////////////////////////

  late ProfileModel userModel;
  void getUserData()
  {
    emit(LayoutLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {

      userModel=ProfileModel.fromJson(value.data);
      //print(userModel.data!.name);

      emit(LayoutSuccessUserDataState());

    }).catchError((error){
      //print('my error :${error.toString()}');
      emit(LayoutErrorUserDataState());
    });
  }

////////////////////////////////////////////////////////////////
  late UpdateUserModel updateUserModel;
  void updateUserData({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(LayoutUpdateUserDataLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token:token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {

      updateUserModel=UpdateUserModel.fromJson(value.data);
      print(updateUserModel.data!.name);
      getUserData();
      emit(LayoutUpdateUserDataSuccessState(updateUserModel));

    }).catchError((error){
      print('my error :${error.toString()}');
      emit(LayoutUpdateUserDataErrorState());
    });
  }



}


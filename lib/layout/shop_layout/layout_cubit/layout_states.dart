
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/profile_model.dart';

import '../../../models/update_user_model.dart';

abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates{}

class LayoutChangeBottomNavState extends LayoutStates{}


class LayoutLoadingHomeDataState extends LayoutStates{}
class LayoutSuccessHomeDataState extends LayoutStates{}
class LayoutErrorHomeDataState extends LayoutStates {}

class LayoutSuccessCategoriesDataState extends LayoutStates{}
class LayoutErrorCategoriesDataState extends LayoutStates {}

class LayoutChangeFavoritesDataState extends LayoutStates{}
class LayoutSuccessChangeFavoritesDataState extends LayoutStates
{
  final ChangeFavoritesModel model;

  LayoutSuccessChangeFavoritesDataState(this.model);
}
class LayoutErrorChangeFavoritesDataState extends LayoutStates {}

class LayoutLoadingGetFavoritesDataState extends LayoutStates{}
class LayoutSuccessGetFavoritesDataState extends LayoutStates{}
class LayoutErrorGetFavoritesDataState extends LayoutStates {}

class LayoutSuccessUserDataState extends LayoutStates {}
class LayoutLoadingUserDataState extends LayoutStates{}
class LayoutErrorUserDataState extends LayoutStates {}

class LayoutUpdateUserDataLoadingState extends LayoutStates{}
class LayoutUpdateUserDataSuccessState extends LayoutStates
{
  final UpdateUserModel updateUserModel;

  LayoutUpdateUserDataSuccessState(this.updateUserModel);
}
class LayoutUpdateUserDataErrorState extends LayoutStates {}



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/home_layout_screens/search/search_cubit/search_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../../models/search_model.dart';
import '../../../../shared/component/constants.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

 late SearchModel model;

 void search(String text)
 {
   emit(SearchLoadingState());
   DioHelper.postData(
       url: SEARCH,
       token: token,
       data:
   {
     'text':text,
   }).then((value) {

     model=SearchModel.fromJson(value.data);
     print(model.status);
     emit(SearchSuccessState());


   }).catchError((error){
     print(error);
     emit(SearchErrorState());
   });
 }

}
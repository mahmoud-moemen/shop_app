import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/home_layout_screens/search/search_cubit/search_cubit.dart';
import 'package:shop_app/modules/home_layout_screens/search/search_cubit/search_states.dart';
import 'package:shop_app/shared/component/components.dart';

import '../../../layout/shop_layout/layout_cubit/layout_cubit.dart';
import '../../../models/search_model.dart';
import '../../../models/search_model.dart';
import '../../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context)
  {
    var formKey=GlobalKey<FormState>();
    var searchController=TextEditingController();

    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key:formKey ,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'enter text to search ';
                          }
                          return null;
                        },
                        onSubmitted:(text)
                        {
                          SearchCubit.get(context).search(text);
                        } ,
                        label: 'Search',
                        prefix:Icons.search ),
                    SizedBox(height: 10.0,),
                    if (state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10.0),
                    if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index)=>buildSearchProduct
                            (SearchCubit.get(context).model!.data!.data![index],context),
                          separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1.0,color: Colors.grey[300],),
                          itemCount:SearchCubit.get(context).model!.data!.data!.length ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchProduct(Product model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(

        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 120.0,
                height: 120.0,


              ),


            ],
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: defaultColor,

                      ),
                    ),
                    SizedBox(width: 5.0),

                    Spacer(),
                    IconButton(
                        onPressed: ()
                        {

                          // print(LayoutCubit.get(context).favorites[ProductModel['id']]);
                          LayoutCubit.get(context).changeFavorites(model!.id);

                          // print(ProductModel['id']);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:(LayoutCubit.get(context)!.favorites![model!.id]!)? defaultColor :Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

}

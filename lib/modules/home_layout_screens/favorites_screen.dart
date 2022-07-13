import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';

import '../../layout/shop_layout/layout_cubit/layout_cubit.dart';
import '../../layout/shop_layout/layout_cubit/layout_states.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! LayoutLoadingGetFavoritesDataState,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=>buildFavoritesItem
                (LayoutCubit.get(context).favoritesModel!.data!.data![index],context),
              separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1.0,color: Colors.grey[300],),
              itemCount:LayoutCubit.get(context).favoritesModel!.data!.data.length ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


  Widget buildFavoritesItem(FavoritesData model,context)=>Padding(

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
                image: NetworkImage(model!.product!.image),
                width: 120.0,
                height: 120.0,


              ),
              if(model!.product!.discount !=0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),

            ],
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model!.product!.name,
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
                      model!.product!.price.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: defaultColor,

                      ),
                    ),
                    SizedBox(width: 5.0),
                    if(model!.product!.discount !=0)Text(
                      model!.product!.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,

                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: ()
                        {

                          // print(LayoutCubit.get(context).favorites[ProductModel['id']]);
                          LayoutCubit.get(context).changeFavorites(model!.product!.id);
                          // print(ProductModel['id']);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:(LayoutCubit.get(context).favorites[model.product!.id]!)? defaultColor :Colors.grey,
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




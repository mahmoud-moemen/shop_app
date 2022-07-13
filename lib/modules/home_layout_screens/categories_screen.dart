import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/layout_cubit/layout_states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(LayoutCubit.get(context).categoriesModel!.data.data![index]),
            separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1.0,color: Colors.grey[300],),
            itemCount: LayoutCubit.get(context).categoriesModel!.data.data!.length);
      },
    );
  }

  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image:NetworkImage(model.image!),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.0,),
        Text(
          model.name!,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}

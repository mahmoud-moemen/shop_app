class HomeModel
{
  late bool status;
  late HomeDataModel data;


  HomeModel.FromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}



class HomeDataModel
{

   // List<BannerModel> banners=[]; // not working
   // List<ProductModel> products=[];// not working
   late List<Map<dynamic,dynamic>> banners=[];
   late List<Map<dynamic,dynamic>> products=[];

  HomeDataModel.fromJson(Map<String,dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(element);
    });

    json['products'].forEach((element)
    {
      products.add(element);
    });
  }
}



class BannerModel
{
   late int id;
   late String image;

  BannerModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    image=json['image'];
  }
}


class ProductModel
{
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String image;
  late String name;
  late bool in_favorites;
  late bool in_cart;

  ProductModel.fromJson(Map<String,dynamic> json)
  {
    id=json['price'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites!=json['in_favorites'];
    in_cart=json['in_cart'];
  }
}
import 'package:dio/dio.dart';

class DioHelper
{

  static late Dio dio;

  static inti()
  {

    dio=Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/' ,
        receiveDataWhenStatusError: true,
        // headers:
        // {
        //   'Content-Type':'application/json',
        //   //'lang':'en',    3mlt overide t7t fl postData
        // }


      ),
    );
  }



  static Future<Response> getData({
    required String url,
     Map<String,dynamic>?  query,
    String lang ='en',   //lang 'ar' as a default value
    String? token ,
  })async
  {
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',
    };


    return await dio.get(url,queryParameters:query );
  }


  static Future<Response> postData({
    required String url,
    Map<String,dynamic>?  query,
    required Map<String,dynamic>  data,
    String lang ='en',   //lang 'ar' as a default value
    String? token ,
})async
  {
    // b overide 3l BaseOptions aly fo2
    dio.options.headers= {
      'Content-Type':'application/json',
      'lang':lang,
          'Authorization':token??null,
        };

    return await dio.post(url , data: data);
  }


  static Future<Response> putData({
    required String url,
    Map<String,dynamic>?  query,
    required Map<String,dynamic>  data,
    String lang ='en',   //lang 'ar' as a default value
    String? token ,
  })async
  {
    // b overide 3l BaseOptions aly fo2
    dio.options.headers= {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??null,
    };

    return await dio.put(url , data: data);
  }


}
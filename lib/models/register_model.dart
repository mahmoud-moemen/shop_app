class RegisterModel {
  late bool status;
  late String message;
  Data? data;



  RegisterModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  late String name;
  late String phone;
  late String email;
  int? id;
  String? image;
  String? token;



  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }


}
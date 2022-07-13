
class ProfileModel {
  late bool status;
  Data? data;



  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =  Data.fromJson(json['data']) ;
  }


}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;



  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }


}
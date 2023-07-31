class UsersRegistry {
  String? id;
  String? email;
  String? username;
  String? password;
  String? name;
  String? favoritefandom;

  UsersRegistry(this.email, this.username, this.password, this.name, this.favoritefandom);

  UsersRegistry.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    email = json['email'].toString();
    username = json['username'].toString();
    password = json['password'].toString();
    name = json['name'].toString();
    favoritefandom = json['favoritefandom'].toString();
  }
}
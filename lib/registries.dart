class Registries {

  String? _id;
  String? _title;
  String? _link;
  String? _description;

  Registries(this._id, this._title, this._link, this._description);

  Registries.fromJson(Map<String, dynamic> json){
    _id = json['id'].toString();
    _title = json['title'].toString();
    _link = json['link'].toString();
    _description = json['description'].toString();
  }

}
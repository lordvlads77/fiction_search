class Registro {

  String? id;
  String? title;
  String? link;
  String? description;

  Registro(this.id, this.title, this.link, this.description);

  Registro.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    title = json['title'].toString();
    link = json['link'].toString();
    description = json['description'].toString();
  }

}
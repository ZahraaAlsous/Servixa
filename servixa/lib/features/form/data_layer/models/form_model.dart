class FormModel {
  int id;
  String title;
  String type; //question or dropdown or checkbox
  List<String>? listDrobdown;
  

  FormModel({
    required this.id,
    required this.title,
    required this.type,
    this.listDrobdown,
  });
}

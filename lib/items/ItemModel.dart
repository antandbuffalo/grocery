class ItemModel {
  String title;
  int count;
  int id;
  bool visible;

  ItemModel(
      {required this.title,
      this.count = 0,
      required this.id,
      this.visible = true});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    int _count = json["count"] ?? 0;

    return ItemModel(title: json["title"], count: _count, id: json["id"]);
  }

  Map toJson() => {'title': title, 'count': count, "id": id};
}

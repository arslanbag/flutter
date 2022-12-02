class Category {
  int? id;
  String? categoryName;
  String? seoUrl;

  Category(id, categorName, seoUrl);

  Category.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["categoryName"];
    seoUrl = json["seoUrl"];
  }

  Map toJson() {
    return {"id": id, "categoryName": categoryName, "seoUrl": seoUrl};
  }
}

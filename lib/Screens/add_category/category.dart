class Category {
  final String name;
  final String description;
  final image;
  final id;

  Category({
    this.name,
    this.description,
    this.image,
    this.id,
  });
  Category.fromFirestore(
    Map<String, dynamic> category,
  )   : name = category["name"],
        description = category["description"],
        image = category["image"],
        id = category["id"];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "image": image,
      "id": id,
    };
  }
}

class Product {
  final String name;
  final String specification;
  final dateOfPurchase;

  final sellingDate;
  final String companyName;
  final String modelNumber;
  final image;
  final category;
  final id;

  Product({
    this.specification,
    this.dateOfPurchase,
    this.sellingDate,
    this.companyName,
    this.modelNumber,
    this.name,
    this.image,
    this.category,
    this.id,
  });
  Product.fromFirestore(
    Map<String, dynamic> category,
  )   : name = category["name"],
        specification = category["specification"],
        image = category["image"],
        dateOfPurchase = category["dateOfPurchase"],
        sellingDate = category["sellingDate"],
        companyName = category["companyName"],
        modelNumber = category["modelNumber"],
        category = category["category"],
        id = category["id"];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "specification": specification,
      "image": image,
      "dateOfPurchase": dateOfPurchase,
      "sellingDate": sellingDate,
      "companyName": companyName,
      "modelNumber": modelNumber,
      "category": category,
      "id": id,
    };
  }
}

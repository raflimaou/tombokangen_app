// ignore_for_file: non_constant_identifier_names

class RekomendasiModel {
  final String head_menu;
  final String detail_menu;
  final String nameProduct;
  final String imageProduct;
  final String price;
  final String description;

  RekomendasiModel({
    this.head_menu,
    this.detail_menu,
    this.nameProduct,
    this.imageProduct,
    this.price,
    this.description,
  });

  factory RekomendasiModel.fromJson(Map<String, dynamic> data) {
    return RekomendasiModel(
      head_menu: data['head_menu'],
      detail_menu: data['detail_menu'],
      nameProduct: data['name'],
      imageProduct: data['image'],
      price: data['price'],
      description: data['description'],
    );
  }
}

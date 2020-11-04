class Product {
  int pk;
  String name;
  int price;
  String description;
  ProductImage image;
  Category category;

  Product(
      {this.pk,
      this.name,
      this.price,
      this.description,
      this.image,
      this.category});

  Product.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image =
        json['image'] != null ? new ProductImage.fromJson(json['image']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class ProductImage {
  int id;
  String name;
  String timestamp;
  String description;
  String thumb;
  String original;
  String wide;
  String lg;
  String md;
  String sm;
  String xs;
  List<String> tags;
  String photographer;
  String preset;
  String presetDisplay;

  ProductImage(
      {this.id,
      this.name,
      this.timestamp,
      this.description,
      this.thumb,
      this.original,
      this.wide,
      this.lg,
      this.md,
      this.sm,
      this.xs,
      this.tags,
      this.photographer,
      this.preset,
      this.presetDisplay});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    timestamp = json['timestamp'];
    description = json['description'];
    thumb = json['thumb'];
    original = json['original'];
    wide = json['wide'];
    lg = json['lg'];
    md = json['md'];
    sm = json['sm'];
    xs = json['xs'];
    tags = json['tags'].cast<String>();
    photographer = json['photographer'];
    preset = json['preset'];
    presetDisplay = json['preset_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['timestamp'] = this.timestamp;
    data['description'] = this.description;
    data['thumb'] = this.thumb;
    data['original'] = this.original;
    data['wide'] = this.wide;
    data['lg'] = this.lg;
    data['md'] = this.md;
    data['sm'] = this.sm;
    data['xs'] = this.xs;
    data['tags'] = this.tags;
    data['photographer'] = this.photographer;
    data['preset'] = this.preset;
    data['preset_display'] = this.presetDisplay;
    return data;
  }
}

class Category {
  int pk;
  String name;

  Category({this.pk, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['name'] = this.name;
    return data;
  }
}

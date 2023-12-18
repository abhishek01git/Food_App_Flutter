class FoodModel {
  final String foodName;
  final String foodImg;
  final String foodCategory;
  final String foodLocation;

  FoodModel({
    required this.foodName,
    required this.foodImg,
    required this.foodCategory,
    required this.foodLocation,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodName: json['strMeal'],
      foodImg: json['strMealThumb'],
      foodCategory: json['strCategory'],
      foodLocation: json['strArea'],
    );
  }
}

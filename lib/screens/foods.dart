import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_api/models/food_model/food_model.dart';
// import 'package:food_api/models/gridviw_model.dart';
import 'package:http/http.dart' as http;

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({super.key});

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

List<FoodModel> foodDetails = [];

class _FoodsScreenState extends State<FoodsScreen> {
  Future<List<FoodModel>> getFoods(String letterBy) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.themealdb.com/api/json/v1/1/search.php?f=$letterBy'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List mealList = data['meals'];
        foodDetails = mealList.map((meal) => FoodModel.fromJson(meal)).toList();
        return foodDetails;
      } else {
        return foodDetails;
      }
    } catch (error) {
      throw Exception('[ERROR FOUND] : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFoods("b"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitThreeBounce(
            color: Colors.deepPurple,
          );
        } else if (snapshot.hasError) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
              );
            },
          );
        } else {
          snapshot.data as List<FoodModel>;
          return GridView.builder(
            itemCount: foodDetails.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final FoodModel food = foodDetails[index];
              return Card(
                color: Colors.deepPurple.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.network(
                        food.foodImg,
                        height: 120,
                        fit: BoxFit.cover,
                        // width: 200,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        food.foodName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

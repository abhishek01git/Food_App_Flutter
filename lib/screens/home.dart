import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_api/models/food_model/food_model.dart';
import 'package:food_api/models/user_model/users_models.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:food_api/models/user_model/user_picture.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<FoodModel>> getFoods(String letterBy) async {
    List<FoodModel> completeFoods = [];
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.themealdb.com/api/json/v1/1/search.php?f=$letterBy'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List mealList = data['meals'];
        completeFoods =
            mealList.map((meal) => FoodModel.fromJson(meal)).toList();
        return completeFoods;
      } else {
        return completeFoods;
      }
    } catch (error) {
      throw Exception('[ERROR FOUND] : $error');
    }
  }

  Future<List<UserModel>> getUserDatas() async {
    List<UserModel> users = [];
    const url = 'https://randomuser.me/api/?results=5';
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Fetch success');
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List userResult = data['results'];
      users = userResult.map((user) => UserModel.fromJson(user)).toList();
      print('stc : $users');
      return users;
    } else {
      print('Fetch failed');
      return users;
    }
    print('users : $users');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          FutureBuilder(
            future: getFoods('b'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 250,
                    autoPlay: true,
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade300,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const SpinKitThreeBounce(
                            color: Colors.deepPurple,
                            size: 50,
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 250,
                    autoPlay: true,
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade300,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            'text $i',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              } else {
                final List<FoodModel> displayList =
                    snapshot.data as List<FoodModel>;
                return CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 250,
                    autoPlay: true,
                  ),
                  items: displayList.map(
                    (item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(item.foodImg),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.deepPurple.shade300,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding:
                                const EdgeInsets.only(left: 25, bottom: 20),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                item.foodName,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                );
              }
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}














//  Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "POPULAR USERS",
//                   style: TextStyle(
//                       color: Colors.deepPurple.shade400,
//                       fontSize: 25,
//                       fontWeight: FontWeight.w300),
//                 ),
//                 SizedBox(
//                   height: 300,
//                   child: ListView.builder(
//                     itemCount: 5,
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Colors.deepPurple),
//                           child: const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 30,
//                                   backgroundColor: Colors.purple,
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "UserName",
//                                       style: TextStyle(fontSize: 20),
//                                     ),
//                                     Text("email",
//                                         style: TextStyle(fontSize: 15)),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_api/models/food_model/food_model.dart';
import 'package:food_api/models/user_model/user_name.dart';
import 'package:food_api/models/user_model/user_picture.dart';
import 'package:food_api/models/user_model/users_models.dart';
import 'package:food_api/name.dart';
import 'package:http/http.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
    return FutureBuilder(
      future: getUserDatas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: SpinKitThreeBounce(
            color: Colors.deepPurple,
          ));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
                snapshot.data == null ? 'No data found' : '${snapshot.error}'),
          );
        } else {
          final List<UserModel> data = snapshot.data as List<UserModel>;

          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              final user = data[index];
              final username =
                  '${user.name.title}.${user.name.firstName} ${user.name.lastName}';

              return ListTile(
                title: Text(username),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.picture.thumbNail),
                ),
                subtitle: Text(user.email),
                trailing: Text(user.nat),
              );
            },
          );
        }
      },
    );
  }
}

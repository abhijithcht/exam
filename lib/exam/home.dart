import 'dart:convert';

import 'package:exam/exam/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<ItemModel>> getItems() async {
    String url = "http://$ipAddress/exam/exam_view_item.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    List<ItemModel> crafts = [];
    for (var singleUser in responseData) {
      ItemModel craft = ItemModel(
        id: singleUser["id"].toString(),
        name: singleUser["name"].toString(),
        price: singleUser["price"].toString(),
        image: singleUser["image"].toString(),
      );
      crafts.add(craft);
    }
    return crafts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FutureBuilder(
              future: getItems(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red[900],
                      strokeWidth: 5,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (ctx, index) {
                      // print(snapshot.data![index].image);
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data![index].image),
                          ),
                          title: Text(
                            "Name: ${snapshot.data![index].name}",
                          ),
                          subtitle: Text(
                            "Price: ${snapshot.data![index].price}",
                          ),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              String url2 =
                                  'http://$ipAddress/exam/exam_add_cart.php';
                              final response = await http.post(
                                Uri.parse(url2),
                                body: {
                                  'name': snapshot.data![index].name,
                                  'price': snapshot.data![index].price,
                                  'image': snapshot.data![index].image,
                                },
                              );
                            },
                            child: Text("Add to cart"),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCart(),
                ),
              );
            },
            child: Text("View cart"),
          ),
        ],
      ),
    );
  }
}

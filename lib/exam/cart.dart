import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'model.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Future<List<CartModel>> getCartDetails() async {
    String url = "http://$ipAddress/exam/exam_view_cart.php";
    final response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);

    List<CartModel> items = [];
    for (var singleUser in responseData) {
      CartModel item = CartModel(
        name: singleUser["name"].toString(),
        price: singleUser["price"].toString(),
        image: singleUser["image"].toString(),
      );
      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getCartDetails(),
          builder: (ctx, AsyncSnapshot<List<CartModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red[900],
                  strokeWidth: 5,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No items added to cart.'),
              );
            } else {
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (ctx, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: ListTile(
                        title: Text(snapshot.data![index].name),
                        leading: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            snapshot.data![index].image,
                          ),
                        ),
                        subtitle: Text('Price: ${snapshot.data![index].price}'),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

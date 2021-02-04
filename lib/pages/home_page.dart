import 'package:flutter/material.dart';
import 'package:flutter_http/controllers/product_controller.dart';
import 'package:flutter_http/pages/product_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get controller when list changes
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Get.snackbar('Get X', 'Welcome to my API',
              duration: Duration(milliseconds: 15),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.amberAccent);
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Shop X',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.view_list_rounded),
                  onPressed: () {},
                ),
                IconButton(icon: Icon(Icons.add), onPressed: () {})
              ],
            ),
          ),
          // ignore: missing_return
          Expanded(
              // Obx in staggeredGridView
              child: Obx(() {
            if (productController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              );
            } else
              return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: productController.productList.length,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return ProductTile(productController.productList[index]);
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1));
          }))
        ],
      ),
    );
  }
}

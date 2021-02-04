import 'package:flutter_http/api_services/remote_api.dart';
import 'package:flutter_http/models/product.dart';
import 'package:get/state_manager.dart';

class ProductController extends GetxController {
  var productList = List<Product>().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    isLoading(true);
    try {
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}

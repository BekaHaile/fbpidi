import 'package:fbpidi/models/company.dart';
import 'package:fbpidi/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompanyAndProductAPI {
  String baseUrl = "http://192.168.0.26:8000";

  //Get list of companies
  /// company_type = manufacturer or supplier
  /// product_category = all or Beverage or Food or Pharmaceuticals
  Future<List<Company>> getCompanies(type, productCategory) async {
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/company/comp-by-main-category/?company_type=$type&product_category=$productCategory"), //uri of api
        headers: {"Accept": "application/json"},
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      List<Company> companies = [];
      try {
        data["companies"].forEach((com) {
          companies.add(Company.fromMap(com));
        });
      } catch (e) {
        print(e.toString());
        throw Exception('Unable to convert data from map to model.');
      }
      return companies;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get detail of a company based on an id
  Future<Company> getCompany(id) async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/company/company-detail/?id=$id"), //uri of api
          headers: {"Accept": "application/json"});

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      Company company = Company.fromMap(data);
      return company;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get list of products based on main category
  Future<List<Product>> getProductsByMainCategory(category) async {
    // category: Beverage or Food or Pharmaceutical  or all
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/product/product-by-main-category/?category=$category"), //uri of api
        headers: {"Accept": "application/json"},
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      List<Product> products = [];
      data["products"].forEach((prod) {
        products.add(Product.fromMap(prod));
      });
      return products;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get list of products based on category
  Future<List<Product>> getProductsByCategory(categoryId) async {
    // category_id   =  1
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/product/product-by-category/?category_id=$categoryId"), //uri of api
        headers: {"Accept": "application/json"},
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      List<Product> products = [];
      data["products"].forEach((prod) {
        products.add(Product.fromMap(prod));
      });
      return products;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get detail of a Product based on an id
  Future<Product> getProduct(id) async {
    // id = 1
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/product/product-detail/?id=$id"), //uri of api
          headers: {"Accept": "application/json"});

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      Product product = Product.fromMap(data);
      return product;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }
}

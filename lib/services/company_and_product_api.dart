import 'package:fbpidi/models/company.dart';
import 'package:fbpidi/models/paginator.dart';
import 'package:fbpidi/models/product.dart';
import 'package:fbpidi/strings/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompanyAndProductAPI {
  String baseUrl = Strings().baseUrl;
  //Get list of companies
  /// company_type = manufacturer or supplier
  /// product_category = all or Beverage or Food or Pharmaceuticals
  Future<Map<String, dynamic>> getCompanies(productCategory, page) async {
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/company/comp-by-main-category/?main_category=$productCategory&page=$page"), //uri of api
        headers: {"Accept": "application/json"},
      );
      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      // print(data); //Response from the api
      List<Company> companies = [];
      try {
        data["companies"].forEach((com) {
          companies.add(Company.fromMap(com));
        });
      } catch (e) {
        print(e.toString());
        throw Exception('Unable to convert data from map to model.');
      }

      Paginator paginator = Paginator.fromMap(data["paginator"]);
      Map<String, dynamic> data2 = {
        "companies": companies,
        "paginator": paginator
      };

      return data2;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  Future<Map<String, dynamic>> searchCompany(id) async {
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/company/search_company/?by_subsector =$id"), //uri of api
        headers: {"Accept": "application/json"},
      );
      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      // print(data); //Response from the api
      List<Company> companies = [];
      try {
        data["companies"].forEach((com) {
          companies.add(Company.fromMap(com));
        });
      } catch (e) {
        print(e.toString());
        throw Exception('Unable to convert data from map to model.');
      }

      Paginator paginator = Paginator.fromMap(data["paginator"]);
      Map<String, dynamic> data2 = {
        "companies": companies,
        "paginator": paginator
      };

      return data2;
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

      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      // print(data); //Response from the api
      Company company = Company.fromMap(data);
      return company;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get list of products based on main category
  Future<Map<String, dynamic>> getProductsByMainCategory(category, page) async {
    // category: Beverage or Food or Pharmaceutical  or all
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/product/product-by-main-category/?category=$category&page=$page"), //uri of api
        headers: {"Accept": "application/json"},
      );

      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      // print(data); //Response from the api
      List<Product> products = [];
      data["products"].forEach((prod) {
        products.add(Product.fromMap(prod));
      });

      Paginator paginator = Paginator.fromMap(data["paginator"]);
      List<dynamic> categories = data['categories'];

      Map<String, dynamic> data2 = {
        "products": products,
        "paginator": paginator,
        "categories": categories
      };

      return data2;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get list of products based on category
  Future<Map<String, dynamic>> getProductsByCategory(categoryId, page) async {
    // category_id   =  1
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/product/product-by-category/?category_id=$categoryId&page=$page"), //uri of api
        headers: {"Accept": "application/json"},
      );

      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      print(data); //Response from the api
      List<Product> products = [];
      data["products"].forEach((prod) {
        products.add(Product.fromMap(prod));
      });

      Paginator paginator = Paginator.fromMap(data["paginator"]);
      Map<String, dynamic> data2 = {
        "products": products,
        "paginator": paginator
      };

      return data2;
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

      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      print(data); //Response from the api
      Product product = Product.fromMap(data["product"]);
      return product;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get total view dataa
  Future<Map<String, dynamic>> getTotalViews() async {
    try {
      var response = await http
          .get(Uri.encodeFull("$baseUrl/api/total_viewers/"), //uri of api
              headers: {"Accept": "application/json"});

      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      // print(data); //Response from the api
      return data;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }
}

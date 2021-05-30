import 'package:fbpidi/models/company.dart';
import 'package:fbpidi/models/paginator.dart';
import 'package:fbpidi/models/product.dart';
import 'package:fbpidi/services/collaborations_api.dart';
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
      List<dynamic> categories = data['sub_sectors'];

      Map<String, dynamic> data2 = {
        "companies": companies,
        "paginator": paginator,
        "categories": categories
      };

      return data2;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  Future<Map<String, dynamic>> searchCompany(title, page) async {
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/company/search_company/?by_title=$title&page=$page"), //uri of api
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

  Future<Map<String, dynamic>> searchCompanyBySubsector(id, page, title) async {
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/company/search_company/?by_subsector=$id&page=$page&by_title=$title"), //uri of api
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
  Future<Map<String, dynamic>> getProductsByMainCategory(
      category, page, title) async {
    // category: Beverage or Food or Pharmaceutical  or all
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/product/product-by-main-category/?category=$category&page=$page&by_title=$title"), //uri of api
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
  Future<Map<String, dynamic>> getProductsByCategory(
      categoryId, page, title) async {
    // category_id   =  1
    try {
      var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/product/product-by-category/?category_id=$categoryId&page=$page&by_title=$title"), //uri of api
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

  //like or dislike a product
  Future<dynamic> likeProduct(id, type) async {
    try {
      var response;
      String token = await CollaborationsApi().getToken();
      if (type == "like")
        response = await http.get(
            Uri.encodeFull(
                "$baseUrl/api/product/like_product/?p_id=${int.parse(id)}"), //uri of api
            headers: {"Authorization": "Token $token"});
      else
        response = await http.get(
            Uri.encodeFull(
                "$baseUrl/api/product/dislike_product/?p_id=$id"), //uri of api
            headers: {"Authorization": "Token " + token});

      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      // print(data); //Response from the api
      return data;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get list of liked Products
  Future<Map<String, dynamic>> getLikedProduct() async {
    try {
      String token = await CollaborationsApi().getToken();
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/product/user_liked_products/"), //uri of api
          headers: {
            "Accept": "application/json",
            "Authorization": "Token " + token
          });

      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      print(data); //Response from the api
      return data;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //like or dislike a product
  Future<dynamic> likeCompany(id, type) async {
    try {
      var response;
      String token = await CollaborationsApi().getToken();
      if (type == "like")
        response = await http.get(
            Uri.encodeFull(
                "$baseUrl/api/company/like_company/?c_id=$id"), //uri of api
            headers: {"Authorization": "Token " + token});
      else
        response = await http.get(
            Uri.encodeFull(
                "$baseUrl/api/company/dislike_company/?c_id=$id"), //uri of api
            headers: {"Authorization": "Token " + token});

      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      // print(data); //Response from the api
      return data;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

//Get list of liked Products
  Future<Map<String, dynamic>> getLikedCompanies() async {
    try {
      String token = await CollaborationsApi().getToken();
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/company/user_liked_companies/"), //uri of api
          headers: {
            "Accept": "application/json",
            "Authorization": "Token " + token
          });

      String body = utf8.decode(response.bodyBytes);

      Map<String, dynamic> data = jsonDecode(body);
      print(data); //Response from the api
      return data;
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

  //Contact a specific manufacturer
  Future<Map<String, dynamic>> contactUs(data) async {
    String token = await CollaborationsApi().getToken();

    var response;
    try {
      response = await http.post(
        Uri.encodeFull("$baseUrl/api/company/contact_company/"), //uri of api
        headers: {
          "Authorization": "Token " + token,
          "Content-Type": "application/json"
        },
        body: jsonEncode(data),
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("Error:" + e.toString());
    }

    Map<String, dynamic> data2 = jsonDecode(response.body);
    // print(data2); //Response from the api

    return data2;
  }

  Future<Map<String, dynamic>> sendInquiry(
      Map<String, dynamic> data, String type) async {
    var response;
    try {
      var uri;
      if (type == "product")
        uri = Uri.parse("$baseUrl/api/product/product_inquiry/");
      else
        uri = Uri.parse("$baseUrl/api/product/inquiry_by_category/");

      var request = http.MultipartRequest('POST', uri);

      if (data["attachment"] != null)
        request.files.add(await http.MultipartFile.fromPath(
            'attachement', data["attachment"]));
      request.fields['sender_email'] = data["sender_email"];
      request.fields['subject'] = data["subject"];
      request.fields['quantity'] = data["quantity"];
      request.fields['content'] = data["content"];
      if (type == "product")
        request.fields['prod_id_list'] = data["prod_id_list"] + ',';
      else
        request.fields['category'] = data["category_id"];
      String token = await CollaborationsApi().getToken();
      request.headers['Authorization'] = "Token " + token;

      response = await request.send();

      final respStr = await response.stream.bytesToString();

      return jsonDecode(respStr);
    } catch (e) {
      print(e.toString() + 'has occured ****');
      return {"error": true};
    }
  }
}

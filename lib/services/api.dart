import 'package:fbpidi/models/company.dart';
import 'package:fbpidi/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  //Get list of companies
  Future<List<Company>> getCompanies(type, productCategory) async {
    //type can be manufacturer or supplier
    var response = await http.get(
      Uri.encodeFull(
          "http://127.0.0.1:8000/client/comp-by-main-category/?company_type=$type&product_category=$productCategory"), //uri of api
      headers: {"Accept": "application/json"},
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    List<Company> companies = List<Company>();
    data["companies"].forEach((com) {
      companies.add(Company.fromMap(com));
    });
    return companies;
  }

  //Get detail of a company based on an id
  Future<Company> getCompany(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://127.0.0.1:8000/client/company-detail/?id=$id"), //uri of api
        headers: {"Accept": "application/json"});

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    Company company = Company.fromMap(data);
    return company;
  }

  //Get list of products based on main category
  Future<List<Product>> getProductsByMainCategory(category) async {
    var response = await http.get(
      Uri.encodeFull(
          "http://127.0.0.1:8000/client/product-by-main-category/?category=$category"), //uri of api
      headers: {"Accept": "application/json"},
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    List<Product> products = List<Product>();
    data["products"].forEach((prod) {
      products.add(Product.fromMap(prod));
    });
    return products;
  }

  //Get list of products based on category
  Future<List<Product>> getProductsByCategory(categoryId) async {
    var response = await http.get(
      Uri.encodeFull(
          "http://127.0.0.1:8000/client/product-by-category/?category_id=$categoryId"), //uri of api
      headers: {"Accept": "application/json"},
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    List<Product> products = List<Product>();
    data["products"].forEach((prod) {
      products.add(Product.fromMap(prod));
    });
    return products;
  }

  //Get detail of a Product based on an id
  Future<Product> getProduct(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://127.0.0.1:8000/client/product-detail/?id=$id"), //uri of api
        headers: {"Accept": "application/json"});

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    Product product = Product.fromMap(data);
    return product;
  }

  postData(dynamic data) async {
    var response;
    try {
      response = await http.post(
        Uri.encodeFull(
            "https://7eecb2e4ee4c.ngrok.io/webhooks/rest/webhook"), //uri of api
        headers: {
          "Accept": "application/json; charset=UTF-8",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e + 'has occured ****');
    }

    if (response.body.length > 2) {
      Map<String, dynamic> res = jsonDecode(response.body)[0];
      if (response.body[0] == "[") //Response from the api
        return res['text'];
      else
        return "Couldn't understand you, sorry";
    } else {
      return "Couldn't understand you, sorry";
    }
  }
}

import 'dart:async';
import 'dart:convert';
import '../RestManagers/RestManager.dart';
import '../models/AuthenticationData.dart';
import '../models/Product.dart';
import '../models/User.dart';
import '../supports/Constants.dart';
import '../supports/LoginResults.dart';

class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();
  late AuthenticationData _authenticationData;

  Future<LogInResult> logIn(String email, String password) async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["username"] = email;
      params["password"] = password;
      String result = await _restManager.makePostRequest(
          Constants.ADDRESS_AUTHENTICATION_SERVER,
          Constants.REQUEST_LOGIN,
          params,
          type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if (_authenticationData.hasError()) {
        if (_authenticationData.error == "Invalid user credentials") {
          return LogInResult.error_wrong_credentials;
        } else if (_authenticationData.error == "Account is not fully set up") {
          return LogInResult.error_not_fully_setupped;
        } else {
          return LogInResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData.accessToken;
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn - 50)),
          (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    } catch (e) {
      return LogInResult.error_unknown;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken;
      String result = await _restManager.makePostRequest(
          Constants.ADDRESS_AUTHENTICATION_SERVER,
          Constants.REQUEST_LOGIN,
          params,
          type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if (_authenticationData.hasError()) {
        return false;
      }
      _restManager.token = _authenticationData.accessToken;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      Map<String, String> params = Map();
      _restManager.token = "";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken;
      await _restManager.makePostRequest(
          Constants.ADDRESS_AUTHENTICATION_SERVER,
          Constants.REQUEST_LOGOUT,
          params,
          type: TypeHeader.urlencoded);
      return true;
    } catch (e) {
      return false;
    }
  }

//Products
//search a product
  Future<List<Product>?> searchProduct(String name) async {
    Map<String, String> params = Map();
    params["name"] = name;
    try {
      return List<Product>.from(json
          .decode(await _restManager.makeGetRequest(
              Constants.ADDRESS_STORE_SERVER,
              Constants.REQUEST_SEARCH_PRODUCTS,
              params))
          .map((i) => Product.fromJson(i))
          .toList());
    } catch (e) {
      return null;
    }
  }

//view list of products
  Future<List<Product>?> viewProducts() async {
    try {
      return List<Product>.from(json
          .decode(await _restManager.makeGetRequest(
            Constants.ADDRESS_STORE_SERVER,
            Constants.REQUEST_GETALL_PRODUCTS,
          ))
          .map((i) => Product.fromJson(i))
          .toList());
    } catch (e) {
      return null;
    }
  }

  //view user
  Future<User?> viewUser(String email) async {
    try {
      String rawResult = await _restManager.makePostRequest(
          Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_GET_USER, email);
      return User.fromJson(jsonDecode(rawResult));
    } catch (e) {
      return null; // not the best solution
    }
  }
}
import 'dart:async';
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

import '../RestManagers/RestManager.dart';
import '../models/AuthenticationData.dart';
import '../models/Orders.dart';
import '../models/Product.dart';
import '../models/User.dart';
import '../supports/Constants.dart';
import '../supports/LoginResults.dart';

class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();
  late AuthenticationData _authenticationData;

  Future<String?> logIn(String email, String password) async {
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
          return LogInResult.error_wrong_credentials.toString();
        } else if (_authenticationData.error == "Account is not fully set up") {
          return LogInResult.error_not_fully_setupped.toString();
        } else {
          return LogInResult.error_unknown.toString();
        }
      }
      _restManager.token = _authenticationData.accessToken;
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn - 50)),
          (Timer t) {
        _refreshToken();
      });
      return null;//LogInResult.logged.toString();
    } catch (e) {
      return LogInResult.error_unknown.toString();
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



//view list of products
  Future<List<Product>?> viewProducts() async {
    try {
      String rawResult = await _restManager.makeGetRequest(
        Constants.ADDRESS_STORE_SERVER,
        Constants.REQUEST_GETALL_PRODUCTS,
      );
      List<Product> res = List<Product>.from(json
          .decode(rawResult)
          .map((i) => Product.fromJson(i))
          .toList());

      return res;
    } catch (e) {
      return null;
    }
  }
  //search a product
  Future<Product?> searchProductByName(String name) async {
    Map<String, String> params = Map();
    params["name"] = name;
    try {
      String rawResult = await _restManager.makeGetRequest(
          Constants.ADDRESS_STORE_SERVER,
          Constants.SEARCH_PRODUCTBYNAME,
          params);
      Product res = Product.fromJson(jsonDecode(rawResult));
      print(res.toString());

      return res;
    }catch(e){
      print(e);
      return null;
    }
  }

  //view user
  Future<User?> viewUser(String email) async {

    Map<String, String> queryParam = {"email":email};
    try {
      String rawResult = await _restManager.makeGetRequest(
          Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_GET_USER, queryParam);
      User u = User.fromJson(jsonDecode(rawResult));
      return u;
    } catch (e) {
      return null; // not the best solution
    }
  }
//registerUser
  void registerUser(User u, String password) async{
    Map<String, dynamic> params = Map();
    params["user"] = u.toJson();
    params["password"] = password;
    try {
       await _restManager.makePostRequest(
          Constants.ADDRESS_STORE_SERVER, Constants.CREATE_USER, params,
          type: TypeHeader.json);
    }catch(e){
      print(e);
    }
  }
//getClientFromToken
  String getClientFromToken(){
    Map<String, dynamic>? decodedToken = Jwt.parseJwt(_restManager.token!);
    return decodedToken['email'];
  }

  //modify User
  Future<void> modifyUser(String? email, String value,  String type) async {
    Map<String, String> params = Map();
    params["email"] = email.toString();
    params["value"] = value;
    params["type"] = type;
    try {
      await _restManager.makePutRequest(
          Constants.ADDRESS_STORE_SERVER, Constants.MODIFY_USER, params);
    }catch(e){
      print(e);
    }
  }
//Orders
//createOrder
  Future<String> createOrder(Orders o) async{
    Map<String, dynamic> params = o.toJson();
    print(o.toJson());
    try {
      await _restManager.makePostRequest(
          Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_CREATE_ORDER, params,
          type: TypeHeader.json);
      return "ok";
    }catch(e){
      return e.toString();
    }
  }



//view orders
  Stream<List<Orders>> viewOrders(String client) async* {
    try {
      Map<String, String> queryParam = {"email": client};
      String rawResult = await _restManager.makeGetRequest(
        Constants.ADDRESS_STORE_SERVER,
        Constants.REQUEST_GET_ORDERS,
        queryParam,
      );

      List<Orders> ordersList = List<Orders>.from(json
          .decode(rawResult)
          .map((i) => Orders.fromJson(i))
          .toList());


      yield ordersList; // Emetti la lista degli ordini come evento nello stream.
    } catch (e) {
      // Gestisci gli errori qui, ad esempio emettendo un errore nello stream.
      yield* Stream.error(e);
    }
  }

}




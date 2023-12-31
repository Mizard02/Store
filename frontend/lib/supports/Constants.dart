class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "Store";

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:8081";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";

  // authentication
  static final String REALM = "Store";
  static final String CLIENT_ID = "StoreClient";
  static final String CLIENT_SECRET = "RcxpLbOVBR73i8IFMgwE7C4uh9RTxcPV";
  static final String REQUEST_LOGIN =
      "/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT =
      "/realms/" + REALM + "/protocol/openid-connect/logout";

  // requests --da aggiornare
  //orders
  static final String REQUEST_GETALL_ORDERS = "/order/byEmail";
  //products
  static final String REQUEST_SEARCH_PRODUCTS = "/products/search/by_name";
  static final String REQUEST_GETALL_PRODUCTS= "/products/getAll";
  static final String SEARCH_PRODUCTBYNAME="/products/search/by_name";
  //users
  static final String REQUEST_GET_USER = "/users/getUser";
  static final String REQUEST_GET_ALL_USER = "/users/getAllUsers";
  static final String CREATE_USER = "/users/create";
  static final String MODIFY_USER = "/users/modify";

  //order
  static final String REQUEST_CREATE_ORDER="/order/create";
  static final String REQUEST_GET_ORDERS="/order/getOrders";
  // states
  static final String STATE_CLUB = "user";

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS =
      "ERROR_MAIL_USER_ALREADY_EXISTS";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";
}

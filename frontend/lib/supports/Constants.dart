class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "Store";

  // addresses
  static final String ADDRESS_STORE_SERVER = "http://localhost:8080";
  static final String ADDRESS_AUTHENTICATION_SERVER = "http://localhost:8081";

  // authentication
  static final String REALM = "Store";
  static final String CLIENT_ID = "StoreClient";
  static final String CLIENT_SECRET = "***";
  static final String REQUEST_LOGIN =
      "/auth/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT =
      "/auth/realms/" + REALM + "/protocol/openid-connect/logout";

  // requests --da aggiornare
  //products
  static final String REQUEST_SEARCH_PRODUCTS = "/products/search/by_name";
  static final String REQUEST_GETALL_PRODUCTS= "/products/getAll";
  //users
  static final String REQUEST_GET_USER = "/users/getUser";

  //order
  static final String REQUEST_CREATE_ORDER="/order/create";
  static final String REQUEST_GET_ORDER_BYIDUSER="/order/{user}";
  // states
  static final String STATE_CLUB = "user";

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS =
      "ERROR_MAIL_USER_ALREADY_EXISTS";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";
}

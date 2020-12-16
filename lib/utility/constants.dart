library constants;

import 'dart:convert';

// // secure storage keys
// const String CHECK_LOGIN_STATUS = "loginstatus";
// const String SESSION_ID = "session_id";
// const String SESSION_TOKEN = "session_token";
// const String LOGGED_IN_USER = "user";

// http client constants
var headers = <String, String>{
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  //'app_key': 'vvv'
};

// var sessionDetails = jsonEncode(<String, String>{
//   'session_id': "101",
//   'session_token': "Sportixe_c962f2fbe7e7c1c5e5a51438db9b06c9"
// });

const String BASE_URL = "https://placeholderltd.com/food-delivery/php/api/";

const String MAKE_ORDER = BASE_URL + "orders/create.php";
const String SINGLE_ORDER = BASE_URL + "orders/single.php";
const String VERIFY_ORDER = BASE_URL + "orders/verify.php";

const String FOOD_DETAIL = BASE_URL + "inventory/single.php";
const String FOOD_LIST = BASE_URL + "inventory/all.php";

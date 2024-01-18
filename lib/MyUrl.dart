class MyUrl {
  static String url(String endPoint) {
    if (endPoint.substring(0, 1) == "/") endPoint = endPoint.substring(1);
    return "http://10.0.2.2:8001/$endPoint";
  }
}

class HttpResponse {
  int code;
  String msg;
  var data;
  bool isSuccess;

  HttpResponse(this.data, this.msg, this.code, {this.isSuccess = false});
}

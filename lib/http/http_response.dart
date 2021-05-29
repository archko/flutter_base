class HttpResponse<T> {
  int code;
  String msg;
  T? data;
  bool isSuccess;

  HttpResponse(this.data, this.msg, this.code, {this.isSuccess = false});
}

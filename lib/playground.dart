class Response<T> {
  T data;
}

void main() async {
  Response<String> resp = Response();
  resp.data = 'new';
  print(resp.data);
}

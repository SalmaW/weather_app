import 'package:dio/dio.dart';

class ApiRepo {
  final Dio _dio = Dio();

  final String? url;
  final Map<String, dynamic>? payload;

  ApiRepo({this.url, this.payload});

  void getData({
    Function()? beforeSend,
    Function(Map<String, dynamic> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    _dio.get(url!, queryParameters: payload).then((response) {
      if (onSuccess != null) {
        onSuccess(response.data);
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}

import 'package:http_client_handler/http_client_handler.dart';
import 'package:uptop/uptop.dart';

class RemoteUptopDatasource implements IUptopDatasource {
  RemoteUptopDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;
}

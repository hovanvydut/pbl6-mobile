import 'package:media/media.dart';

class MediaRepository {
  MediaRepository({required IMediaDatasource mediaDatasource})
      : _mediaDatasource = mediaDatasource;
  final IMediaDatasource _mediaDatasource;

  Future<String> uploadImage(String fileName) =>
      _mediaDatasource.uploadImage(fileName);
}

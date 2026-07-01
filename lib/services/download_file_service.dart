import 'dart:io';
import 'package:overcloud/network/api_client_factory.dart';
import 'package:path_provider/path_provider.dart';


class DownloadService {
  DownloadService._();

  static Future<File> downloadFile({
    required String uid,
    required String folderId,
    required String fileId,
    required String fileName,
    void Function(int received, int total)? onProgress,
  }) async {
    final dio = ApiClientFactory.create();

    final directory = await getDownloadsDirectory();

    final savePath = "${directory!.path}/$fileName";

    await dio.download(
      "/download",
      savePath,
      queryParameters: {
        "uid": uid,
        "folderId": folderId,
        "fileId": fileId,
      },
      onReceiveProgress: onProgress,
    );

    return File(savePath);
  }
}
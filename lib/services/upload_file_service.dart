import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:overcloud/services/api_constants.dart';
import 'package:overcloud/services/transfer_service.dart';
import 'package:path/path.dart' as p;

class UploadService {
  UploadService._();

  static StreamSubscription? _updatesSubscription;

  static final Map<String, void Function(double)> _progressCallbacks = {};
  static final Map<String, void Function(TaskStatus)> _statusCallbacks = {};


  static Future<Task> uploadFile({
    required String uid,
    required String folderId,
    required String fileId,
    required String filePath,

    Future<void> Function()? onCompleted,
    void Function(double progress)? onProgress,
    void Function(TaskStatus status)? onStatus,
  }) async {
    final task = UploadTask(
      url: "${ApiConstants.baseUrl}/upload",
      filename: p.basename(filePath),
      directory: p.dirname(filePath),
      baseDirectory: BaseDirectory.root,
      fileField: "file",
      fields: {
        "uid": uid,
        "folderId": folderId,
        "fileId": fileId,
      },
      updates: Updates.statusAndProgress,
    );

    if (onProgress != null) {
      _progressCallbacks[task.taskId] = onProgress;
    }

    if (onStatus != null) {
      _statusCallbacks[task.taskId] = onStatus;
    }

    TransferService.registerTask(
    taskId: task.taskId,
    onProgress: onProgress,
    onStatus: onStatus,
    onCompleted: onCompleted,
    );

    await FileDownloader().enqueue(task);

    return task;
  }

  static Future<void> cancel(UploadTask task) async {
    await FileDownloader().cancelTaskWithId(task.taskId);
  }

  static Future<void> dispose() async {
    await _updatesSubscription?.cancel();
    _updatesSubscription = null;
  }
}

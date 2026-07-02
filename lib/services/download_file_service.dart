import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:overcloud/services/api_constants.dart';

class DownloadService {
  DownloadService._();

  static StreamSubscription? _updatesSubscription;

  static final Map<String, void Function(double)> _progressCallbacks = {};

  static final Map<String, void Function(TaskStatus)> _statusCallbacks = {};

  /// Call this once in main()
  static void initialize() {
    if (_updatesSubscription != null) return;

    _updatesSubscription = FileDownloader().updates.listen((update) {
      if (update is TaskProgressUpdate) {
        final progress = update.progress;

        print(
          "Task: ${update.task.taskId} | "
          "Progress: ${(progress * 100).toStringAsFixed(2)}%",
        );

        _progressCallbacks[update.task.taskId]?.call(progress);
      }

      if (update is TaskStatusUpdate) {
        print(
          "Task: ${update.task.taskId} | "
          "Status: ${update.status}",
        );

        _statusCallbacks[update.task.taskId]?.call(update.status);

        if (update.status == TaskStatus.complete ||
            update.status == TaskStatus.failed ||
            update.status == TaskStatus.canceled ||
            update.status == TaskStatus.notFound) {
          _progressCallbacks.remove(update.task.taskId);
          _statusCallbacks.remove(update.task.taskId);
        }
      }
    });
  }

  static Future<Task> downloadFile({
    required String uid,
    required String folderId,
    required String fileId,
    required String fileName,
    void Function(double progress)? onProgress,
    void Function(TaskStatus status)? onStatus,
  }) async {
    final task = DownloadTask(
      url:
          "${ApiConstants.baseUrl}/download"
          "?uid=$uid"
          "&folderId=$folderId"
          "&fileId=$fileId",
      filename: fileName,
      directory: "mediastore://downloads/OverCloud",
      updates: Updates.statusAndProgress,
      allowPause: true,
    );

    if (onProgress != null) {
      _progressCallbacks[task.taskId] = onProgress;
    }

    if (onStatus != null) {
      _statusCallbacks[task.taskId] = onStatus;
    }

    await FileDownloader().enqueue(task);

    return task;
  }

  static Future<void> pause(DownloadTask task) async {
    await FileDownloader().pause(task);
  }

  static Future<void> resume(DownloadTask task) async {
    await FileDownloader().resume(task);
  }

  static Future<void> cancel(DownloadTask task) async {
    await FileDownloader().cancelTaskWithId(task.taskId);
  }

  static Future<void> dispose() async {
    await _updatesSubscription?.cancel();
    _updatesSubscription = null;
  }
}
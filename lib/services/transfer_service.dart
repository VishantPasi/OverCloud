import 'dart:async';
import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/cupertino.dart';

class TransferService {
  static StreamSubscription? _updatesSubscription;

  static final Map<String, void Function(double)> _progressCallbacks = {};
  static final Map<String, void Function(TaskStatus)> _statusCallbacks = {};
  static final Map<String, Future<void> Function()> _completionCallbacks = {};

  static void initialize() {
    if (_updatesSubscription != null) return;

    _updatesSubscription = FileDownloader().updates.listen((update) async {
      if (update is TaskProgressUpdate) {
        final progress = update.progress;

        debugPrint(
          "Task: ${update.task.taskId} | "
          "Progress: ${(progress * 100).toStringAsFixed(2)}%",
        );

        _progressCallbacks[update.task.taskId]?.call(progress);
      }

      if (update is TaskStatusUpdate) {
        debugPrint(
          "Task: ${update.task.taskId} | "
          "Status: ${update.status}",
        );

        _statusCallbacks[update.task.taskId]?.call(update.status);

        if (update.status == TaskStatus.complete) {
          final callback =
              _completionCallbacks.remove(update.task.taskId);

          if (callback != null) {
            await callback();
          }
        }

        if (update.status == TaskStatus.complete ||
            update.status == TaskStatus.failed ||
            update.status == TaskStatus.canceled ||
            update.status == TaskStatus.notFound) {
          _progressCallbacks.remove(update.task.taskId);
          _statusCallbacks.remove(update.task.taskId);
          _completionCallbacks.remove(update.task.taskId);
        }
      }
    });
  }

  static void registerTask({
    required String taskId,
    void Function(double)? onProgress,
    void Function(TaskStatus)? onStatus,
    Future<void> Function()? onCompleted,
  }) {
    if (onProgress != null) {
      _progressCallbacks[taskId] = onProgress;
    }

    if (onStatus != null) {
      _statusCallbacks[taskId] = onStatus;
    }

    if (onCompleted != null) {
      _completionCallbacks[taskId] = onCompleted;
    }
  }

  static Future<void> dispose() async {
    await _updatesSubscription?.cancel();
    _updatesSubscription = null;
  }
}
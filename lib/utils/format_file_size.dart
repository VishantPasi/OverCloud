class FormatFileSize {
  String fileSize(int bytes) {
    if (bytes >= 1000 * 1000 * 1000) {
      return "${(bytes / (1000 * 1000 * 1000)).toStringAsFixed(2)} GB";
    }

    if (bytes >= 1000 * 1000) {
      return "${(bytes / (1000 * 1000)).toStringAsFixed(2)} MB";
    }

    if (bytes >= 1000) {
      return "${(bytes / 1000).toStringAsFixed(2)} KB";
    }

    return "$bytes Byte";
  }
}

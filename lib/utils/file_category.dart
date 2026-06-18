class FileCategory {
  String getFileCategory(String fileType) {
    final type = fileType.toLowerCase();

    // Photos
    if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'svg'].contains(type)) {
      return 'photos';
    }

    // Videos
    if (['mp4', 'avi', 'mkv', 'mov', 'wmv', 'flv', 'webm'].contains(type)) {
      return 'videos';
    }

    // Music
    if (['mp3', 'wav', 'aac', 'ogg', 'flac', 'm4a'].contains(type)) {
      return 'music';
    }

    if ([
      // Documents
      'pdf',
      'doc',
      'docx',
      'odt',
      'rtf',
      'txt',

      // Spreadsheets
      'xls',
      'xlsx',
      'xlsm',
      'ods',
      'csv',

      // Presentations
      'ppt',
      'pptx',
      'odp',

      // Archives
      'zip',
      'rar',
      '7z',
      'tar',
      'gz',
      'tgz',
      'bz2',
      'xz',

      // E-books
      'epub',
      'mobi',
      'azw',
      'azw3',

      // Code / Config files
      'json',
      'xml',
      'yaml',
      'yml',
      'sql',
      'dart',
      'java',
      'kt',
      'js',
      'ts',
      'html',
      'css',
      'py',
      'cpp',
      'c',
      'h',

      // Misc
      'md',
      'log',
    ].contains(type)) {
      return 'documents';
    }

    return 'others';
  }
}

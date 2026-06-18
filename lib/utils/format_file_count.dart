class FormatFileCount {
  String fileCount(int fileCount){
    if(fileCount >= 1000){
     
      return "${(fileCount /1000).toStringAsFixed(1)}K";
    }
    return fileCount.toString();
  }
}
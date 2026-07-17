class DeleteFolderRequestModel {
  String? uid;
  String? folderName;
  String? folderPath;

  DeleteFolderRequestModel({this.uid, this.folderName, this.folderPath});

  DeleteFolderRequestModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    folderName = json['folderName'];
    folderPath = json['folderPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['folderName'] = folderName;
    data['folderPath'] = folderPath;
    return data;
  }
}

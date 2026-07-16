class DeleteFolderRequestModel {
  String? uid;
  String? folderName;

  DeleteFolderRequestModel({this.uid, this.folderName});

  DeleteFolderRequestModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    folderName = json['folderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['folderName'] = folderName;
    return data;
  }
}

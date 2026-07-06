class CreateFolderRequestModel {
  String? uid;
  String? folderName;

  CreateFolderRequestModel({this.uid, this.folderName});

  CreateFolderRequestModel.fromJson(Map<String, dynamic> json) {
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

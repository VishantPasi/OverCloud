class CreateFolderRequestModel {
  String? uid;
  String? folderName;

  CreateFolderRequestModel({this.uid, this.folderName});

  CreateFolderRequestModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    folderName = json['folderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['folderName'] = this.folderName;
    return data;
  }
}

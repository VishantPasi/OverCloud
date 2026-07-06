class DeleteFolderRequestModel {
  String? uid;
  String? folderId;

  DeleteFolderRequestModel({this.uid, this.folderId});

  DeleteFolderRequestModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    folderId = json['folderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['folderId'] = folderId;
    return data;
  }
}

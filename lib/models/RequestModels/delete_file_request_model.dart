class DeleteFileRequestModel {
  String? uid;
  String? folderId;
  String? fileId;

  DeleteFileRequestModel({this.uid, this.folderId, this.fileId});

  DeleteFileRequestModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    folderId = json['folderId'];
    fileId = json['fileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['folderId'] = folderId;
    data['fileId'] = fileId;
    return data;
  }
}

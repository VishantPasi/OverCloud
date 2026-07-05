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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['folderId'] = this.folderId;
    data['fileId'] = this.fileId;
    return data;
  }
}

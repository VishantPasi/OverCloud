class DeleteFolderResponseModel {
  bool? success;
  String? message;
  String? folderId;

  DeleteFolderResponseModel({this.success, this.message, this.folderId});

  DeleteFolderResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    folderId = json['folderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['folderId'] = folderId;
    return data;
  }
}

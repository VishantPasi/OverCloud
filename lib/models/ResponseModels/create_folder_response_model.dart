class CreateFolderResponseModel {
  bool? success;
  String? message;
  String? path;

  CreateFolderResponseModel({this.success, this.message, this.path});

  CreateFolderResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['path'] = path;
    return data;
  }
}

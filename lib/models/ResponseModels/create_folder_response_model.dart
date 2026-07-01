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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['path'] = this.path;
    return data;
  }
}

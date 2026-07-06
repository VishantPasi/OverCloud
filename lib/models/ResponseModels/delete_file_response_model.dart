class DeleteFileResponseModel {
  bool? success;
  String? message;
  String? fileId;

  DeleteFileResponseModel({this.success, this.message, this.fileId});

  DeleteFileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    fileId = json['fileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['fileId'] = fileId;
    return data;
  }
}

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['fileId'] = this.fileId;
    return data;
  }
}

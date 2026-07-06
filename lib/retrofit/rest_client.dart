import 'package:dio/dio.dart';
import 'package:overcloud/models/RequestModels/create_folder_request_model.dart';
import 'package:overcloud/models/RequestModels/delete_file_request_model.dart';
import 'package:overcloud/models/RequestModels/delete_folder_request_model.dart';
import 'package:overcloud/models/ResponseModels/create_folder_response_model.dart';
import 'package:overcloud/models/ResponseModels/delete_file_response_model.dart';
import 'package:overcloud/models/ResponseModels/delete_folder_response_model.dart';
import 'package:overcloud/services/api_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';


@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

   @POST(ApiConstants.createFolder)
   Future<CreateFolderResponseModel> createFolder(
    @Body() CreateFolderRequestModel request
  );

  @POST(ApiConstants.uploadFile)
  @MultiPart()
  Future<void> uploadFile(
    @Part(name: "uid") String uid,
    @Part(name: "folderId") String folderId,
    @Part(name: "file") MultipartFile file,
  );
  
  @DELETE(ApiConstants.deleteFolder)
  Future<DeleteFolderResponseModel> deleteFolder(
    @Body() DeleteFolderRequestModel request
  );

  @DELETE(ApiConstants.delete)
  Future<DeleteFileResponseModel> delete(
    @Body() DeleteFileRequestModel request
  );

}


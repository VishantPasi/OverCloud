import 'package:dio/dio.dart';
import 'package:overcloud/models/RequestModels/create_folder_request_model.dart';
import 'package:overcloud/models/ResponseModels/create_folder_response_model.dart';
import 'package:overcloud/services/api_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';


@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(ApiConstants.uploadFile)
  @MultiPart()
  Future<void> uploadFile(
    @Part(name: "uid") String uid,
    @Part(name: "file") MultipartFile file,
  );

  // @POST(ApiConstants.createFolder)
  //  Future<Map<String, dynamic>> createFolder(
  //   @Query("uid") String uid,
  //   @Query("folder_name") String folderName,
  // );

  @POST(ApiConstants.createFolder)
   Future<CreateFolderResponseModel> createFolder(
    @Body() CreateFolderRequestModel request
  );

}


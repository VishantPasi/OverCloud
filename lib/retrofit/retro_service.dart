import 'package:overcloud/network/api_client_factory.dart';
import 'package:overcloud/retrofit/rest_client.dart';

class RetrofitService {
  RetrofitService._();

  static RestClient getClient({String? token}) {
    return RestClient(
      ApiClientFactory.create(token: token),
    );
  }
}
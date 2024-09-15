abstract class BaseApiServices{
  Future<dynamic> getApi();
  Future<dynamic> putApi(url,data);
  Future<dynamic> patchApi(url,data);
  Future<dynamic> deleteApi(url);
}
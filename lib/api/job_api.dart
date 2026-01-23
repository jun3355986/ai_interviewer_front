import 'package:dio/dio.dart';
import 'api_client.dart';

class JobApi {
  final ApiClient _apiClient;

  JobApi(this._apiClient);

  Future<Response> getJobs() {
    return _apiClient.getServiceDio(ApiClient.jobBaseUrl).get('/api/v1/jobs');
  }

  Future<Response> searchJobs(String keyword) {
    return _apiClient
        .getServiceDio(ApiClient.jobBaseUrl)
        .get('/api/v1/jobs/search', queryParameters: {'arg0': keyword});
  }

  Future<Response> createJob(Map<String, dynamic> data) {
    return _apiClient
        .getServiceDio(ApiClient.jobBaseUrl)
        .post('/api/v1/jobs', data: data);
  }

  Future<Response> getJobById(String id) {
    return _apiClient
        .getServiceDio(ApiClient.jobBaseUrl)
        .get('/api/v1/jobs/$id');
  }

  Future<Response> updateJob(String id, Map<String, dynamic> data) {
    return _apiClient
        .getServiceDio(ApiClient.jobBaseUrl)
        .put('/api/v1/jobs/$id', data: data);
  }

  Future<Response> deleteJob(String id) {
    return _apiClient
        .getServiceDio(ApiClient.jobBaseUrl)
        .delete('/api/v1/jobs/$id');
  }

  Future<Response> closeJob(String id) {
    return _apiClient
        .getServiceDio(ApiClient.jobBaseUrl)
        .put('/api/v1/jobs/$id/close');
  }

  Future<Response> matchJob(
    String jobId,
    String resumeId,
    String resumeContent,
  ) {
    return _apiClient
        .getServiceDio(ApiClient.jobBaseUrl)
        .post(
          '/api/v1/jobs/$jobId/match',
          data: {'resumeId': resumeId, 'resumeContent': resumeContent},
        );
  }

  Future<Response> getMyJobs() {
    return _apiClient
        .getServiceDio(ApiClient.jobBaseUrl)
        .get('/api/v1/jobs/my');
  }
}

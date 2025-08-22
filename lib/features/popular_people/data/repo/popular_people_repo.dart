import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/core/error_handler/error_handler.dart';
import 'package:movies_app/core/helpers/network_connectivity_helper.dart';
import 'package:movies_app/core/local_secure_storage/local_secure_storage.dart';
import 'package:movies_app/core/networking/data_result.dart';
import 'package:movies_app/features/popular_people/data/apis/popular_people_api_service.dart';
import 'package:movies_app/features/popular_people/data/datasources/popular_people_local_data_source.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';

class PopularPeopleRepo {
  final PopularPeopleApiService _apiService;
  final PopularPeopleLocalDataSource _localDataSource;

  PopularPeopleRepo(this._apiService, this._localDataSource);

  Future<DataResult<PopularPeopleResponseModel>> getPopularPeople({
    int page = 1,
    String? language,
    bool forceRefresh = false,
  }) async {
    try {
      // Check network connectivity
      final hasNetwork = await NetworkConnectivityHelper.canReachTmdbApi();

      if (!hasNetwork && !forceRefresh) {
        // Try to get data from local storage
        debugPrint('No network connection, attempting to load from cache');
        return await _getFromLocal(page);
      }

      if (hasNetwork) {
        // Try to get data from API
        final result = await _getFromApi(page: page, language: language);

        if (result is Success<PopularPeopleResponseModel>) {
          // Save to local storage for offline access
          await _localDataSource.savePopularPeople(
            people: result.data.results,
            page: page,
          );
          debugPrint('Data saved to local storage for page $page');
        }

        return result;
      } else {
        // Fallback to local data
        return await _getFromLocal(page);
      }
    } catch (e) {
      debugPrint('Error in getPopularPeople: $e');
      // Fallback to local data on any error
      return await _getFromLocal(page);
    }
  }

  Future<DataResult<PopularPeopleResponseModel>> _getFromApi({
    required int page,
    String? language,
  }) async {
    try {
      final apiKey = await LocalSecureStorage.tmdbApiKey;
      final result = await _apiService.getPopularPeople(
        page: page,
        language: language,
        apiKey: apiKey,
      );
      return DataResult.success(result);
    } on DioException catch (e) {
      return DataResult.error(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return DataResult.error(DioErrorHandler.handleGeneralError(e));
    }
  }

  Future<DataResult<PopularPeopleResponseModel>> _getFromLocal(int page) async {
    try {
      final cachedPeople = await _localDataSource.getPopularPeople(page: page);

      if (cachedPeople.isEmpty) {
        return DataResult.error('No cached data available for page $page');
      }

      // Create a response model from cached data
      final maxPage = await _localDataSource.getMaxCachedPage();
      final responseModel = PopularPeopleResponseModel(
        page: page,
        results: cachedPeople,
        totalPages: maxPage,
        totalResults: cachedPeople.length * maxPage, // Approximation
      );

      debugPrint(
        'Loaded ${cachedPeople.length} people from cache for page $page',
      );
      return DataResult.success(responseModel);
    } catch (e) {
      return DataResult.error('Failed to load cached data: ${e.toString()}');
    }
  }

  Future<bool> isCacheExpired() async {
    return await _localDataSource.isCacheExpired();
  }

  Future<void> clearCache() async {
    await _localDataSource.clearAllData();
  }

  Future<bool> hasOfflineData() async {
    final cachedPeople = await _localDataSource.getAllCachedPeople();
    return cachedPeople.isNotEmpty;
  }
}

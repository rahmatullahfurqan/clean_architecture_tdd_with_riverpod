import "package:dio/dio.dart";
import "package:hive_flutter/adapters.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../config/env.dart";

class DioState {
  final CancelToken token;
  final Dio value;

  const DioState({
    required this.value,
    required this.token,
  });
}

final dioProvider = Provider<DioState>((_) {
  final CancelToken token = CancelToken();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: EnvironmentConfig.BASE_URL,
      contentType: "application/json",
    ),
  );
  dio.interceptors.clear();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (_, __) async {
        final userBox = (await Hive.openBox("user"));
        _.headers["Authorization"] = "Bearer ${userBox.get("token")}";
        __.next(_);
      },
      onError: (_, __) async {
        if (_.response != null) {
          if (_.response!.statusCode == 401) {
            final userBox = await Hive.openBox("user");
            Dio otherDio = Dio(
              BaseOptions(
                baseUrl: EnvironmentConfig.BASE_URL,
                contentType: "application/json",
              ),
            );
            otherDio.options.headers["Authorization"] =
                "Bearer ${userBox.get("refreshToken")}";
            otherDio.interceptors.clear();
            try {
              final response = await otherDio.put("/customers/refresh-token");
              userBox.putAll({
                "token": response.data["token"],
                "refreshToken": response.data["refreshToken"],
              });
              _.requestOptions.headers["Authorization"] =
                  "Bearer ${response.data["token"]}";
              return __.resolve(
                await dio.request(
                  _.requestOptions.path,
                  data: _.requestOptions.data,
                  queryParameters: _.requestOptions.queryParameters,
                  options: Options(
                    method: _.requestOptions.method,
                    headers: _.requestOptions.headers,
                  ),
                ),
              );
            } on DioError catch (_) {
              if (_.response!.statusCode == 502) {
                _.requestOptions.extra["error"] = "Bad Gateway";
              }
              if (_.response!.statusCode == 401) {
                userBox.deleteAll([
                  "token",
                  "refreshToken",
                ]);
              }
              __.next(_);
            }
          } else {
            return __.next(_);
          }
        } else {
          __.next(_);
        }
      },
    ),
  );

  return DioState(value: dio, token: token);
});

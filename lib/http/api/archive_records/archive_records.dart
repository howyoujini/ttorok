/*
 * "ttorok" created by @howyoujini on 2/11/24  4:51 PM
 * Copyright (c) . All rights reserved.
 */

import 'package:ttorok/http/api/ttorok_api_client.dart';

class ArchiveRecordsApi {
  static const String _uriPrefix = "community/archive_messages";
  final TtorokApiHttpClient _httpClient;

  const ArchiveRecordsApi(this._httpClient);

  /// 회원가입
  Future<String> fetchRecord(final String request) {
    return _httpClient.get("$_uriPrefix").then((it) {
      print(it.toString());
      return it.toString();
    });
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:global_template/global_template.dart';
import 'package:http/http.dart' as http;
import 'package:network/network.dart';

class AbsensiApi {
  Future checkAbsenMasukDanPulang({
    @required String idUser,
    @required DateTime tanggalAbsenMasuk,
  }) async {
    var result;
    try {
      result = await reusableRequestServer.requestServer(() async {
        final response = await http.get(
            "${appConfig.baseApiUrl}/${appConfig.absensiController}/checkAbsenMasukDanPulang?id_user=$idUser&tanggal_absen_masuk=$tanggalAbsenMasuk");
        final Map<String, dynamic> responseJson = json.decode(response.body);
        if (response.statusCode == 200) {
          return responseJson['data'];
        } else {
          throw responseJson['message'];
        }
      });
    } catch (e) {
      throw e;
    }
    return result;
  }

  Future<String> absensiMasuk({
    @required String idUser,
    @required DateTime tanggalAbsen,
    @required DateTime tanggalAbsenMasuk,
    @required String jamAbsenMasuk,
    @required DateTime createdDate,
  }) async {
    var result;
    try {
      result = await reusableRequestServer.requestServer(() async {
        final response = await http.post(
          "${appConfig.baseApiUrl}/${appConfig.absensiController}/absensiMasuk",
          headers: appConfig.headersApi,
          body: {
            "id_user": idUser,
            "tanggal_absen": "$tanggalAbsen",
            "tanggal_absen_masuk": "$tanggalAbsenMasuk",
            "jam_absen_masuk": "$jamAbsenMasuk",
            "created_date": "$createdDate"
          },
        );
        final Map<String, dynamic> responseJson = json.decode(response.body);
        final String message = responseJson['message'];
        if (response.statusCode == 200) {
          return message;
        } else {
          throw message;
        }
      });
    } catch (e) {
      throw e;
    }
    return result;
  }

  Future<String> absensiPulang({
    @required String idUser,
    @required DateTime tanggalAbsenPulang,
    @required String jamAbsenPulang,
    @required DateTime updateDate,
  }) async {
    var result = await reusableRequestServer.requestServer(() async {
      final response = await http.post(
        "${appConfig.baseApiUrl}/${appConfig.absensiController}/absensiPulang",
        headers: appConfig.headersApi,
        body: {
          "id_user": idUser,
          "tanggal_absen_pulang": "$tanggalAbsenPulang",
          "jam_absen_pulang": "$jamAbsenPulang",
          "update_date": "$updateDate"
        },
      );
      final Map<String, dynamic> responseJson = json.decode(response.body);
      final String message = responseJson['message'];
      print(response.body);
      print("Absensi Pulang $responseJson");

      print(response.statusCode);
      if (response.statusCode == 200) {
        return message;
      } else {
        throw message;
      }
    });

    return result;
  }

  Future<List<PerformanceModel>> getPerformanceBulanan({
    @required String idUser,
    @required DateTime dateTime,
    @required int totalDayOfMonth,
    @required int totalWeekDayOfMonth,
  }) async {
    final result = await reusableRequestServer.requestServer(() async {
      final response = await http.get(
        "${appConfig.baseApiUrl}/${appConfig.absensiController}/getPerformanceMonthly?id_user=$idUser&tanggal_absen=$dateTime&total_day_of_month=$totalDayOfMonth&total_week_day_of_month=$totalWeekDayOfMonth",
      );
      final Map<String, dynamic> responseJson = json.decode(response.body);
      final String message = responseJson['message'];
      final List data = responseJson['data'];
      print(data);
      if (response.statusCode == 200) {
        List<PerformanceModel> result = data.map((e) => PerformanceModel.fromJson(e)).toList();
        return result;
      } else {
        throw message;
      }
    });
    return result;
  }
}

final absensiAPI = AbsensiApi();
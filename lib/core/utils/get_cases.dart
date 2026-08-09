import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:http/http.dart" as http;

import "../../constants.dart";
import "../helpers/hive_helper.dart";
import "../models/data_typs.dart";

Future<void> getStories() async {
  try {
    final String localDataString = await rootBundle.loadString(
      kRoleplayStoriesPath,
    );
    final List<dynamic> localStoriesRaw = jsonDecode(localDataString);

    final List<Map<String, dynamic>> allStoriesMap = localStoriesRaw
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();

    try {
      final response = await http.get(Uri.parse(kApi));

      if (response.statusCode == 200) {
        final List<dynamic> remoteStories = json.decode(response.body);

        for (var story in remoteStories) {
          if (story == null || story is! Map) {
            debugPrint("القصة غير موجودة أو بتنسيق غير صحيح!");
            continue;
          }

          final storyId = story["id"];
          if (storyId == null) {
            debugPrint("القصة مفقود فيها ID!");
            continue;
          }

          final bool alreadyExists = allStoriesMap.any(
            (s) => s["id"].toString() == storyId.toString(),
          );

          if (!alreadyExists) {
            allStoriesMap.add(Map<String, dynamic>.from(story));
          }
        }
      } else {
        debugPrint(
          "فشل في تحميل البيانات من السيرفر! الكود: ${response.statusCode}",
        );
      }
    } catch (e) {
      debugPrint("حدث خطأ أثناء الاتصال بالسيرفر: $e");
    }

    final List<CaseModel> finalCaseModels = allStoriesMap
        .map((c) => CaseModel.fromMap(c))
        .toList();

    await HiveHelper.saveListData<CaseModel>(kBoxCases, finalCaseModels);

    debugPrint("تم حفظ ${finalCaseModels.length} قصة بنجاح في Hive!");
  } catch (e) {
    debugPrint("حدث خطأ رئيسي أثناء معالجة القصص: $e");
  }
}

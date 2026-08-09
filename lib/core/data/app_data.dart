import "../helpers/hive_helper.dart";
import "../models/data_typs.dart";
import "../utils/get_cases.dart";

class AppData {
  static List<CaseModel> cases = [];
  static List<int> doneCasesIds = [];
  static List<int> get availableCasesIds => List.from(
    cases.map((m) => m.id).where((id) => !doneCasesIds.contains(id)),
  );

  static Future<void> init() async {
    await getStories();
    cases = HiveHelper.getListData<CaseModel>(kBoxCases);
    if (cases.isNotEmpty) doneCasesIds = HiveHelper.getListData(kBoxDoneCases);
  }
}

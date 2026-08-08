import "../helpers/hive_helper.dart";
import "../models/data_typs.dart";

class AppData {
  static List<CaseModel> cases = [];
  static List<int> doneCasesIds = [];
  static List<int> get availableCasesIds => List.from(
    cases.map((m) => m.id).where((id) => !doneCasesIds.contains(id)),
  );

  static void init() {
    cases = HiveHelper.getListData<CaseModel>(kBoxCases);
    if (cases.isNotEmpty) doneCasesIds = HiveHelper.getListData(kBoxDoneCases);
  }
}

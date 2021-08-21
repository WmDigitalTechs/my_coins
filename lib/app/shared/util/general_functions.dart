import '../interface/general_functions_interface.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

class GeneralFunctions implements IGeneralFunctions {
  @override
  String? formatNtpHour(DateTime? date) {
    var formatedHour;
    if (date != null) {
      var format = DateFormat('yyyy-MM-dd HH:mm');
      formatedHour = format.format(date);
    }
    return formatedHour;
  }

  @override
  Future<String?>? getBuildAndVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    var buildNumber = packageInfo.buildNumber;
    //await _sharedPrefsController.saveVersion("version", '$version+$buildNumber');
    return '$version+$buildNumber';
  }

  @override
  String? toBrazilTime(String? date) {
    var formatedHour;
    if (date != null) {
      var format = DateFormat('dd/MM/yyyy HH:mm:ss');
      formatedHour = format.format(DateTime.parse(date));
    }
    return formatedHour;
  }

  @override
  String? formatNumber(String num) {
    var numDoub = double.parse(num).toStringAsFixed(2);
    return numDoub.toString();
  }
}

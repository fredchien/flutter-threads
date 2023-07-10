import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 10-07-2023 13:46:06
 * @modify date 10-07-2023 13:46:06
 * @desc [description]
 */

String formatData(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  String day = dateTime.day.toString();
  String month = dateTime.month.toString();
  String year = dateTime.year.toString();

  String formattedData = '$day/$month/$year';

  return formattedData;
}

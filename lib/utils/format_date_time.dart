 import 'package:intl/intl.dart';
 
 String formatDateTime(String dateTime){
    final dt = DateTime.parse(dateTime);

    return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
  }
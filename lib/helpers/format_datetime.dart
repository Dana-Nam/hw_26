String formatDateTime(DateTime dateTime) {
  final day = _zeroPad(dateTime.day);

  final month = _zeroPad(dateTime.month);

  final year = dateTime.year;

  final hour = _zeroPad(dateTime.hour);

  final minute = _zeroPad(dateTime.minute);

  return '$day.$month.$year $hour:$minute';
}

String _zeroPad(int dateTimeValue) {
  if (dateTimeValue < 10) {
    return '0$dateTimeValue';
  }

  return dateTimeValue.toString();
}

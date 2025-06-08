bool comparaDatas(DateTime data1, DateTime data2) {
  return data1.year == data2.year &&
      data1.month == data2.month &&
      data1.day == data2.day &&
      data1.hour == data2.hour &&
      data1.minute == data2.minute;
}

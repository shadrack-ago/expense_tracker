extension DaysOfWeek on DateTime {
  /// First day of today's week
  DateTime get thisWeekFirstDay {
    return this.subtract(Duration(days: this.weekday - 1));
  }

  DateTime get thisWeekLastDay {
    return this.add(Duration(days: DateTime.daysPerWeek - this.weekday));
  }

  DateTime get thisMonthLastDay {
    return DateTime(this.year, this.month + 1, 0);
  }

  DateTime get thisMonthFirstDay {
    return DateTime(this.year, this.month, 1);
  }

  DateTime get thisYearLastDay {
    return DateTime(this.year, 12, 31);
  }

  DateTime get thisYearFirstDay {
    return DateTime(this.year, 1, 1);
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  DateTime findLastDateOfTheMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month + 1, 0);
  }

  DateTime findFirstDateOfTheMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, 1);
  }

  DateTime findLastDateOfTheYear(DateTime dateTime) {
    return DateTime(dateTime.year, 12, 31);
  }

  DateTime findFirstDateOfTheYear(DateTime dateTime) {
    return DateTime(dateTime.year, 1, 1);
  }

  int get weekOfMonth {
    var date = this;
    int sum = date.thisMonthFirstDay.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}

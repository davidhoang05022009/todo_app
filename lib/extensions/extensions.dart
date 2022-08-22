extension ApproximateDuration on Duration {
  String toApproxDurationString() {
    String result = '';
    int days = 0, hours = 0, minutes = 0;

    if (inDays > 0) {
      days = inDays;
    }

    if (inHours > 0) {
      if (inHours >= 24) {
        hours = inHours - 24 * inDays;
      } else {
        hours = inHours;
      }
    }

    if (inMinutes > 0) {
      if (inMinutes >= 60) {
        minutes = inMinutes - 60 * inHours;
      } else {
        minutes = inMinutes;
      }
    }

    if (days > 0) {
      result += days == 1 ? '$days day' : '$days days';
    }

    if (hours > 0) {
      if (days > 0) {
        result += ', ${hours}h';
      }
    }
    if (minutes > 0) {
      if (days > 0 && hours == 0) {
        result += ', ${minutes}m';
      } else {
        result += '${minutes}m';
      }
    }

    return result;

    /*
  * Example return values:
  * '1 day, 1h10m'
  * '1 day, 1h'
  * '1 day, 10m'
  * '1 day'
  * '2 days'
  */
  }
}

extension ApproximateDateTime on DateTime {
  String toApproxDateTime() {
    String result = '';
    Duration taskDueDuration = difference(
      DateTime.now(),
    );
    if (taskDueDuration.inDays <= 0) {
      if (taskDueDuration.inHours <= 0) {
        if (taskDueDuration.inMinutes >= 0) {
          result = '${taskDueDuration.inMinutes}m';
        }
      } else {
        result = '${taskDueDuration.inHours}h';
      }
    } else {
      result = taskDueDuration.inDays == 1
          ? '${taskDueDuration.inDays} day'
          : '${taskDueDuration.inDays} days';
    }

    return result == '' ? 'Overdue' : 'In $result';

    /*
  * Example return values:
  * 'In 1 day'
  * 'In 1h'
  * 'In 10m'
  * 'Overdue' if days, minutes and hours are 0
  */
  }
}

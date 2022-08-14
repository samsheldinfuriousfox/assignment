class DateTimeRestructure {
  int remainingTime(int finishTimeInSeconds) {
    Duration timeLeft = Duration(seconds: finishTimeInSeconds);
    final days = (timeLeft.inDays);
    // Step 7
    final hours = timeLeft.inHours.remainder(24).toInt();
    final minutes = timeLeft.inMinutes.remainder(60).toInt();
    final seconds = timeLeft.inSeconds.remainder(60).toInt();
    if (timeLeft.isNegative) {
      return 0;
    }
    return seconds;
  }


}

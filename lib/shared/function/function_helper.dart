String getInitialName(String name) {
  try {
    List<String> dataRaw = name.split(' ');

    if (dataRaw.length <= 1) {
      if (dataRaw[0].length < 2) {
        return dataRaw[0].substring(0, 1).toUpperCase();
      } else {
        return dataRaw[0].substring(0, 2).toUpperCase();
      }
    } else {
      return '${dataRaw[0][0].toUpperCase()}${dataRaw[1][0].toUpperCase()}';
    }
  } catch (e) {
    return '-';
  }
}

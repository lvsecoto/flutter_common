/// 用于Freezed，把数据强制转成字符串，不会包空错误
dynamic readAsString(Map<dynamic, dynamic> json, String key) {
  return json[key].toString();
}

/// 用于json转换，把数据强制转成字符串，不会包空错误
dynamic readAsString(Map<dynamic, dynamic> json, String key) {
  return json[key].toString();
}

/// 用于json转换，把json自身返回
dynamic readSelf(Map<dynamic, dynamic> json, String key) {
  return json;
}

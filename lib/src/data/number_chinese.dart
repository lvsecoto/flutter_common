extension NumberToChineseEx on int {
  /// 数字转中文字
  String get chinese =>
      switch(this) {
        0 => '零',
        1 => '一',
        2 => '二',
        3 => '三',
        4 => '四',
        5 => '五',
        6 => '六',
        7 => '七',
        8 => '八',
        9 => '九',
        10 => '十',
        _ => toString(),
      };
}
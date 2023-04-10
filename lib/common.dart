/// # 公共库
///
/// 这些公共库代码是和业务，品牌无关的，更多是一些工具类。
/// 是对flutter和第三方的库的补充。
///
/// 和Provider相关的组件不会放在这个库里面，而是先转成river_pod放在这里
/// 比如[ChangeNotifier] -> [StateNotifier]
library common;

export 'src/app/app.dart';
export 'src/ui/ui.dart';
export 'src/data/data.dart';
export 'src/hook/hook.dart';
export 'src/native/native.dart';

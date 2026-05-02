/// Spacing scale tokens for SCAVIUM layouts.
///
/// The scale intentionally stays compact in 9.3.1 so existing screens can adopt
/// it incrementally without creating component-specific spacing constants.
abstract final class ScavoSpacing {
  static const none = 0.0;
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 40.0;

  static const compact = xs;
  static const standard = md;
  static const comfortable = lg;
  static const spacious = xl;
  static const section = xxl;
}

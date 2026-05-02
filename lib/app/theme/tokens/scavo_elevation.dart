/// Elevation tokens for SCAVIUM surfaces.
///
/// The current product identity is mostly flat, so explicit zero-elevation
/// tokens document that choice instead of scattering magic values.
abstract final class ScavoElevation {
  static const none = 0.0;
  static const raised = 2.0;
  static const overlay = 6.0;

  static const surface = none;
  static const interactive = none;
  static const floating = raised;
  static const modal = overlay;
}

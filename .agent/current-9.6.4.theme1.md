PROYECTO: SCAVIUM Wallet

FASE/AJUSTE:
9.6.theme-adjust — SCAVIUM Design Token System v1

OBJETIVO:
Alinear el theme visual de la app con la identidad SCAVIUM real:
- primary naranja SCAVIUM
- dark-first
- azul solo como soporte
- verde solo para success/confirmed
- cards, chips, botones y navegación consistentes en light/dark

REGLAS:
- Code-only
- NO modificar documentación
- NO generar .agent
- NO ejecutar comandos
- NO hacer git
- Leer archivos necesarios
- Proponer plan antes de editar
- Esperar aprobación
- Reportar diff final

ARCHIVOS A LEER:
- lib/app/theme/**
- lib/app/app.dart
- lib/features/settings/presentation/**
- lib/features/assets/presentation/**
- lib/features/activity/presentation/**
- lib/features/wallet/presentation/**
- lib/features/home/presentation/**
- lib/app/router/**
- test/** relacionados si existen

OBJETIVO VISUAL:
- Primary: Color(0xFFF97316)
- Dark background: Color(0xFF0B1220)
- Dark surface: Color(0xFF0F1A2E)
- Dark surface alt: Color(0xFF13213A)
- Dark border: Color(0xFF1F2A44)
- Light background: Color(0xFFF8FAFC)
- Light surface: Color(0xFFFFFFFF)
- Light surface alt: Color(0xFFF1F5F9)
- Light border: Color(0xFFE2E8F0)
- Success: Color(0xFF22C55E)
- Warning: Color(0xFFF59E0B)
- Error: Color(0xFFEF4444)

AJUSTES ESPERADOS:
1. Centralizar tokens si no están centralizados.
2. Actualizar AppTheme light/dark usando ColorScheme coherente.
3. Cambiar primary azul por naranja.
4. Eliminar verde como color de selección general.
5. Mantener verde solo para success/confirmed.
6. Unificar chips y segmented buttons:
   - selected: primary naranja
   - unselected: outline/surface
7. Unificar cards:
   - surface consistente
   - border consistente
   - contraste suficiente en light/dark
8. Revisar Settings Appearance selector.
9. Revisar History filters.
10. Revisar Home/Assets/Transaction detail/Unlock visual consistency.
11. No cambiar comportamiento funcional.

VALIDACIÓN ESPERADA:
- La app debe seguir compilando.
- Light/dark/system deben seguir funcionando.
- No debe romper navegación.
- No debe modificar documentación.
PROYECTO: SCAVIUM Wallet

AJUSTE:
9.6.theme-polish.1 — Light contrast and icon system polish

OBJETIVO:
Corregir inconsistencias visuales detectadas luego de implementar SCAVIUM Design Token System v1, manteniendo dark-first y primary naranja.

ALCANCE:
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
- lib/features/settings/presentation/**
- lib/features/assets/presentation/**
- lib/features/activity/presentation/**
- lib/features/wallet/presentation/**
- lib/features/home/presentation/**
- lib/shared/**
- lib/app/app.dart

PROBLEMAS A CORREGIR:
1. Light mode:
   - textos con bajo contraste sobre fondo claro
   - inputs/dropdowns con texto casi invisible
   - cards demasiado planas o sin separación suficiente

2. Icons:
   - definir y aplicar color consistente para:
     - active
     - inactive
     - muted/subtle
     - onPrimary
   - sidebar active/inactive debe ser claro en light y dark
   - action icons top-right deben tener contraste correcto
   - settings section icons deben usar primary/semantic coherentemente

3. Inputs/dropdowns:
   - border visible siempre
   - focused border primary naranja
   - fill diferenciado por theme
   - dropdown selected/menu text legible

4. Chips/filters:
   - selected: primary naranja
   - unselected: outline + textSecondary legible
   - evitar apariencia disabled

5. Secondary buttons:
   - no deben parecer disabled
   - usar primary text + outline visible

REGLAS VISUALES:
- Mantener primary: Color(0xFFFF6B14) o el naranja ya definido en tokens.
- Mantener dark-first.
- No volver a usar azul como primary.
- Verde solo para success/confirmed.
- No hardcodear colores nuevos si pueden salir del token system.
- Preferir centralizar ajustes en theme/tokens y widgets comunes.

VALIDACIÓN ESPERADA:
- Dark debe mantenerse igual o mejor.
- Light debe tener contraste suficiente.
- Settings Appearance selector debe verse bien en light/dark.
- Home/Assets/History/Unlock deben verse coherentes.
- No cambiar comportamiento funcional.
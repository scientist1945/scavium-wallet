PROYECTO: SCAVIUM Wallet

AJUSTE:
9.6.theme-polish.2 — Minimal contrast, asset avatar and icon token polish

OBJETIVO:
Aplicar ajustes visuales mínimos sobre la implementación actual del SCAVIUM Design Token System y Lucide icons.

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
- lib/features/wallet/presentation/**
- lib/features/assets/presentation/**
- lib/features/home/presentation/**
- lib/features/activity/presentation/**
- lib/features/settings/presentation/**
- lib/shared/**

AJUSTES EXACTOS:
1. Unlock screen light:
   - asegurar que el título "Unlock wallet" use textPrimary/onSurface con contraste suficiente.
   - asegurar que el subtítulo use textSecondary/onSurfaceVariant legible.
   - no alterar layout ni comportamiento.

2. Assets token/account avatars:
   - eliminar violeta como color visual principal.
   - usar naranja SCAVIUM o un surface-accent naranja suave.
   - mantener contraste correcto para la letra "S".
   - aplicar de forma consistente en light/dark.

3. Icon color tokens:
   - revisar icon inactive/strong/action.
   - sidebar inactive debe verse liviano pero legible.
   - top-right action icons deben quedar fuertes y legibles.
   - no cambiar tamaños salvo que ya estén fuera de tokens.

REGLAS VISUALES:
- Mantener primary naranja SCAVIUM.
- Mantener dark-first.
- No volver a introducir azul como primary.
- Verde solo para success/confirmed.
- No hacer rework de cards, buttons ni navigation.
- No cambiar textos.
- No cambiar funcionalidad.

VALIDACIÓN ESPERADA:
- Dark debe quedar igual o mejor.
- Light unlock debe ser legible.
- Assets avatars deben sentirse SCAVIUM, no violeta genérico.
- Icon system debe seguir fino y premium.
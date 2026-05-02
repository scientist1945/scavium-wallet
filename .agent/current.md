PROYECTO: SCAVIUM Wallet

AJUSTE:
9.6.icon-polish.1 — Replace dense icons with Lucide thin-stroke icon system

OBJETIVO:
Reemplazar los íconos visualmente pesados por un sistema consistente basado en Lucide, alineado con el theme dark-first y primary naranja SCAVIUM.

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

DEPENDENCIA:
Agregar `lucide_icons` al pubspec.yaml solo si no existe.

ARCHIVOS A LEER:
- pubspec.yaml
- lib/app/theme/**
- lib/app/router/**
- lib/features/home/presentation/**
- lib/features/assets/presentation/**
- lib/features/activity/presentation/**
- lib/features/settings/presentation/**
- lib/features/wallet/presentation/**
- lib/shared/**

REGLAS:
1. Usar Lucide de forma consistente.
2. No mezclar Material icons salvo que no haya reemplazo razonable.
3. No cambiar comportamiento funcional.
4. No cambiar textos.
5. Mantener primary naranja.
6. Mantener verde solo para success/confirmed.
7. Mantener dark theme intacto visualmente salvo mejora de íconos.
8. Centralizar tamaños/colores si ya existe helper/token para iconografía.
9. Si no existe helper, crear uno mínimo en theme/shared, sin sobrediseñar.

MAPEO DE ÍCONOS:
- Home: LucideIcons.home
- Assets: LucideIcons.walletCards o LucideIcons.wallet
- Activity/History: LucideIcons.receiptText
- Settings: LucideIcons.settings
- Refresh: LucideIcons.refreshCw
- Add: LucideIcons.plus
- Back: LucideIcons.arrowLeft
- Download/Export: LucideIcons.download
- Sign message: LucideIcons.signature
- Diagnostics/RPC: LucideIcons.activity
- Danger zone: LucideIcons.triangleAlert
- Security: LucideIcons.shield
- Appearance: LucideIcons.palette
- System theme: LucideIcons.monitorCog
- Light theme: LucideIcons.sun
- Dark theme: LucideIcons.moon
- Confirmed: LucideIcons.circleCheck
- Explorer/external link: LucideIcons.externalLink
- Copy: LucideIcons.copy
- Receive: LucideIcons.arrowDown
- Send: LucideIcons.arrowUp
- Accounts: LucideIcons.usersRound

TAMAÑOS OBJETIVO:
- Sidebar icons: 20
- Section/card icons: 18
- Top action icons: 20
- Inline icons/chips: 16

VALIDACIÓN VISUAL ESPERADA:
- Sidebar debe verse más liviana y premium.
- Settings icons deben dejar de sentirse densos.
- Top-right refresh/settings deben mantener contraste.
- Confirmed/status icons deben seguir siendo claros.
- Light y dark deben mantener coherencia.
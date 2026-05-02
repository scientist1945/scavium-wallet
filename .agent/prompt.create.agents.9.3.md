PROYECTO: SCAVIUM Wallet

Te adjunto el ZIP actualizado del proyecto.

OBJETIVO

Generar los archivos `.agent` necesarios para ejecutar una fase mediante VSCode/Codex en modo code-only, usando templates.

FASE A PROCESAR

9.3 — Theme Token Normalization

DOCUMENTACIÓN FUENTE

Fase:
docs/phase9_scavium_wallet.md

General:
docs/**

REGLAS

1. Leer el ZIP real
2. Leer el archivo de documentación indicado
3. Detectar fase y subfases reales
4. NO inventar subfases
5. NO modificar código ni documentación existente
6. Generar archivos `.agent` usando templates

TEMPLATES A USAR

- .agent/rules.tpl.md
- .agent/commands.tpl.md
- .agent/current.tpl.md

GENERAR

1. .agent/rules.md
   - reemplazar variables del template
   - usar branch correcto de la fase

2. .agent/commands.md
   - detectar comandos reales del proyecto
   - adaptar analyze/test/format

3. .agent/current.md
   - apuntar a la primera subfase ejecutable

4. .agent/current-9.3.md
   - resumen mínimo de fase

5. .agent/current-X.md
   - un archivo por subfase
   - generado desde current.tpl.md
   - optimizado para bajo consumo

CRITERIOS PARA CODEX

Debe:

- leer archivos necesarios
- proponer plan
- esperar aprobación
- modificar código permitido
- reportar diff

NO debe:

- ejecutar comandos
- modificar documentación
- correr tests
- correr analyze
- hacer git
- escanear todo el repo

SALIDA

1. Listar subfases detectadas
2. Indicar si falta alguna definición
3. Generar todos los archivos `.agent`
4. Entregar listos para copiar

IMPORTANTE

- No duplicar documentación completa
- No usar narrativa larga en current*.md
- Optimizar para bajo consumo en VSCode
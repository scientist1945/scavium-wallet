PROYECTO: SCAVIUM Wallet

OBJETIVO DEL PROMPT

Este prompt tiene como objetivo documentar de forma controlada cualquier fase del proyecto SCAVIUM Wallet a partir del estado REAL del código (ZIP adjunto), garantizando:

- Coherencia total con el estado actual del proyecto
- Respeto absoluto de la documentación existente (docs/*.md)
- Evolución incremental sin regresiones
- Generación de subfases cuando corresponda
- Identificación precisa de archivos a intervenir
- Documentación completa para posterior ejecución por otros prompts

---

## ALCANCE DE ESTE PROMPT (CRÍTICO)

Este prompt NO ejecuta la fase.

Este prompt NO implementa código.

Este prompt NO genera archivos operativos `.agent`.

Este prompt tiene un único objetivo:

- Analizar la fase indicada
- Detectar o generar sus subfases
- Documentar formalmente esas subfases en la documentación de la fase
- Documentar por cada subfase:
  - objetivo
  - alcance
  - archivos existentes tentativos a intervenir
  - archivos nuevos tentativos a crear
  - justificación técnica

---

### PROHIBICIONES EXPLÍCITAS

Queda estrictamente prohibido:

- Generar archivos `.agent/*`
- Generar `.agent/current*.md`
- Generar `.agent/rules.md`
- Generar `.agent/commands.md`
- Preparar ejecución operativa
- Implementar código funcional

Este prompt SOLO genera documentación.

---

## INPUT ESPERADO

1) ZIP del proyecto actualizado (FUENTE DE VERDAD PRINCIPAL)

2) Fase a ejecutar, definida de UNA de las siguientes formas:

- Número de fase (ej: "Phase 8.3")
- Archivo de documentación (ej: docs/phase8_scavium_wallet.md)

---

## FUENTES DE VERDAD (ORDEN ESTRICTO)

1. ZIP adjunto (OBLIGATORIO)
2. Todos los archivos `.md` del proyecto (documentos troncales)
   - README.md
   - docs/*.md
   - docs/handoff/*.md (si existen)
3. Código fuente real dentro del ZIP
4. Este prompt

NO se permite usar memoria externa ni asumir estados previos.

---

## REGLAS CRÍTICAS

- ❌ NO simular lectura del ZIP
- ❌ NO asumir estructura del proyecto
- ❌ NO inventar archivos inexistentes
- ❌ NO modificar documentación sin justificación real
- ❌ NO resumir documentación existente
- ❌ NO reescribir documentos troncales

- ✅ TODO debe basarse en el contenido REAL del ZIP
- ✅ TODA propuesta debe ser coherente con el código actual
- ✅ TODA intervención debe ser incremental
- ✅ SIEMPRE preservar arquitectura existente

---

## PROCESO OBLIGATORIO

### 1) ANÁLISIS DEL ZIP

- Leer completamente:
  - Estructura del proyecto
  - Código fuente relevante
  - Todos los `.md`

- Identificar:
  - Estado real de la fase solicitada
  - Si ya está parcialmente implementada
  - Si está completa o incompleta

---

### 2) DETERMINACIÓN DE SUBFASES

SI la fase:

- Ya está subdividida → respetar subfases existentes
- NO está subdividida → generar subfases necesarias

#### REGLAS PARA SUBFASES

- Deben ser:
  - Atómicas
  - Ejecutables (desde el punto de vista conceptual)
  - Incrementales
  - Validables

- NO generar subfases innecesarias
- NO sobre-fragmentar

---

### 3) PLAN DE INTERVENCIÓN POR SUBFASE

Para CADA subfase:

#### 3.1 Archivos existentes a intervenir

- Listar archivos reales del proyecto que deben modificarse
- Indicar ruta exacta
- Justificar técnicamente por qué deben intervenirse

#### 3.2 Archivos nuevos a crear (si aplica)

- Proponer archivos nuevos SOLO si es necesario
- Indicar:
  - Ruta
  - Propósito
  - Justificación técnica
  - Relación con arquitectura existente

---

### 4) VALIDACIÓN DE COHERENCIA

Antes de documentar:

- Verificar que:
  - No se rompe arquitectura existente
  - No se duplica lógica innecesariamente
  - No se contradicen `.md`
  - Se mantiene compatibilidad con fases previas

---

### 5) DOCUMENTACIÓN DE SUBFASES (OBLIGATORIO)

Para cada subfase, se debe documentar dentro del archivo de la fase correspondiente (ej: docs/phaseX_*.md).

#### Estructura mínima por subfase:

- Nombre de la subfase
- Objetivo
- Alcance
- Estado (nueva / existente / parcial)
- Archivos existentes a intervenir
  - lista real
  - justificación técnica
- Archivos nuevos a crear (si aplica)
  - ruta
  - propósito
  - justificación
- Validaciones esperadas

---

### 6) INTEGRACIÓN DOCUMENTAL

- Insertar las subfases en el archivo de fase correspondiente
- Mantener estilo existente
- NO eliminar contenido previo
- NO resumir
- NO reescribir completamente el documento

Si corresponde:

- actualizar docs/roadmap.md
- actualizar docs/index.md

---

### 7) ENTREGA FINAL

#### 7.1 ZIP OBLIGATORIO

El ZIP debe contener SOLO archivos documentales modificados o nuevos.

Ejemplos:

- docs/phase*.md
- docs/roadmap.md (si aplica)
- docs/index.md (si aplica)
- README.md (si aplica)

---

Queda prohibido incluir:

- Archivos `.agent/*`
- Código fuente
- Archivos operativos

---

#### 7.2 REPORTE FINAL (OBLIGATORIO)

Debe incluir:

### ✔ Fase procesada
- Nombre completo

### ✔ Subfases
- Lista completa generada o utilizada

### ✔ Archivos documentales intervenidos
- Lista EXACTA
- Debe coincidir con el ZIP

### ✔ Validaciones realizadas
- Arquitectura
- Compatibilidad
- Documentación

---

## FORMATO DE RESPUESTA

1) Análisis del estado actual  
2) Definición de subfases  
3) Plan de intervención por subfase  
4) Documentación generada (detalle de cambios en .md)  
5) Reporte final  
6) ZIP descargable  

---

## IMPORTANTE

Este prompt es:

- Reutilizable para TODAS las fases
- Independiente del estado previo
- Basado SIEMPRE en el ZIP real
- Orientado exclusivamente a documentación

---

## EJEMPLOS DE USO

FASE: docs/phase8_scavium_wallet.md

---

FIN DEL PROMPT
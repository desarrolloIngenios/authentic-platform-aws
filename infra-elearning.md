# PROYECTO: INCORPORACIÓN DE E-LEARNING AL REPOSITORIO DE INFRAESTRUCTURA EXISTENTE

Actúa como arquitecto DevOps y arquitecto de soluciones especializado en AWS, DigitalOcean, Kubernetes, Docker, Terraform, Moodle, IOMAD y plataformas SaaS Multi-Tenant.

## 1. Contexto

Estamos trabajando sobre el repositorio existente:

authenticfarma-plantform-infraesturtura

Este repositorio contiene actualmente la configuración y definición de infraestructura de los diferentes componentes tecnológicos del ecosistema AuthenticFarma.

No queremos crear un repositorio independiente ni reemplazar la infraestructura existente.

El objetivo es incorporar un nuevo componente denominado E-LEARNING, conservando la arquitectura, convenciones, herramientas y configuraciones actuales.

## 2. Objetivo

Agregar la infraestructura necesaria para desplegar y operar una plataforma E-learning Multi-Tenant.

La plataforma tendrá inicialmente tres organizaciones:

- AuthenticFarma Academy.
- Authentic Mentors Academy.
- YoSoy Academy.

La solución utilizará:

- Moodle Community.
- IOMAD para Multi-Tenancy.
- Edwiser RemUI como tema.
- PostgreSQL.
- Redis.
- Docker.
- AWS como infraestructura inicial.
- DigitalOcean como alternativa futura.
- Cloudflare para dominios y DNS.

Laravel podrá utilizarse como capa comercial para catálogo, checkout, pagos y matrículas, pero primero debes identificar si existe una aplicación Laravel en la infraestructura actual y cómo integrarla.

## 3. Primera tarea: auditoría obligatoria

Antes de crear o modificar archivos:

1. Analiza toda la estructura del repositorio.
2. Identifica los proveedores cloud utilizados.
3. Identifica si existe Kubernetes y cómo está configurado.
4. Identifica los namespaces existentes.
5. Identifica los servicios desplegados.
6. Analiza los módulos Terraform existentes.
7. Identifica las configuraciones Docker.
8. Identifica cómo se gestionan los secretos.
9. Identifica PostgreSQL, Redis y almacenamiento existentes.
10. Identifica Cloudflare, dominios y certificados.
11. Identifica los sistemas de monitoreo y backups.
12. Identifica las convenciones de nombres y estructura.

Entrega un informe que indique qué componentes pueden reutilizarse y cuáles deben crearse específicamente para E-learning.

No modifiques ningún archivo durante esta primera fase.

## 4. Diseño de integración

Incorpora E-learning como un módulo independiente dentro del repositorio.

La estructura debe respetar las convenciones existentes.

Como referencia conceptual:

elearning/
  README.md
  architecture/
  moodle/
  iomad/
  integrations/
  infrastructure/
  environments/
  monitoring/
  backup/
  migration/
  tests/

Adapta esta propuesta a la estructura real. No dupliques módulos que ya existan.

## 5. Arquitectura de E-learning

Diseña la infraestructura considerando:

- Servicio web Moodle/IOMAD.
- Servicio independiente para Moodle Cron.
- Base de datos PostgreSQL.
- Almacenamiento persistente y compartido para moodledata.
- Almacenamiento de objetos para respaldos.
- Redis para caché y sesiones cuando corresponda.
- Balanceador de carga.
- Certificados HTTPS.
- Gestión de secretos.
- Logs y monitoreo.

Evalúa si podemos reutilizar los recursos actuales o si conviene desplegar recursos independientes.

Documenta las ventajas, riesgos, costos y dependencias de cada decisión.

No asumas que un almacenamiento S3 sustituye directamente el filesystem compartido de Moodle.

## 6. Multi-Tenancy

Configura el diseño para tres organizaciones mediante IOMAD.

Cada organización debe mantener aislamiento de:

- Usuarios.
- Cursos.
- Matrículas.
- Reportes.
- Archivos.
- Roles y permisos.
- Configuración institucional.

Verifica la compatibilidad de IOMAD con Edwiser RemUI y las posibilidades de personalización visual por organización.

## 7. Infraestructura y portabilidad

AWS será el proveedor inicial.

DigitalOcean debe documentarse como proveedor alternativo para una futura migración.

La arquitectura debe evitar dependencias innecesarias de servicios exclusivos de AWS.

Documenta la equivalencia de:

- Cómputo.
- PostgreSQL.
- Redis.
- Almacenamiento.
- Red.
- Balanceo.
- Gestión de secretos.
- Backups.
- Monitoreo.

Si ya existe Kubernetes, evalúa si conviene reutilizarlo. Si no existe o no es conveniente, presenta una alternativa basada en ECS Fargate.

No implementes ambas alternativas sin aprobación.

## 8. Seguridad

- No subir secretos al repositorio.
- No compartir bases de datos entre aplicaciones sin aislamiento.
- Separar credenciales de E-learning.
- Proteger moodledata.
- Mantener backups independientes.
- Aplicar permisos mínimos.
- No incluir datos clínicos de YoSoy en Moodle.
- No ejecutar operaciones destructivas sobre recursos existentes.

## 9. Implementación por fases

FASE 1: Auditoría del repositorio actual.

FASE 2: Diseño de arquitectura E-learning e integración con la infraestructura existente.

FASE 3: Creación de estructura y documentación.

FASE 4: Docker y entorno local.

FASE 5: Despliegue de Moodle/IOMAD y PostgreSQL.

FASE 6: Configuración de los tres tenants.

FASE 7: Integraciones, monitoreo y backups.

FASE 8: Terraform y despliegue AWS.

FASE 9: Documentación de migración a DigitalOcean.

No avances de una fase a otra sin aprobación.

## 10. Restricciones

- No crear otro repositorio.
- No duplicar infraestructura existente.
- No modificar servicios productivos.
- No cambiar configuraciones actuales sin autorización.
- No ejecutar despliegues ni generar recursos facturables sin autorización.
- No eliminar archivos.
- No modificar el core de Moodle/IOMAD.
- No asumir compatibilidad de plugins sin verificar versiones y licencias.

## Primera instrucción

Comienza únicamente con la FASE 1.

Analiza el repositorio authenticfarma-planfor-infraesturtura y presenta:

1. Arquitectura actual.
2. Inventario de componentes.
3. Recursos reutilizables.
4. Recursos que requiere E-learning.
5. Riesgos de compartir infraestructura.
6. Estructura propuesta para incorporar E-learning.
7. Estimación preliminar de costos incrementales.

No realices cambios hasta recibir aprobación.
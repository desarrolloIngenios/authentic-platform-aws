# PROYECTO: AUTHENTICFARMA PLATFORM INFRASTRUCTURE
## PROMPT MAESTRO PARA COPILOT – CONSTRUCCIÓN DE INFRAESTRUCTURA AWS, KUBERNETES Y MIGRACIÓN DESDE DIGITALOCEAN

### 1. ROL Y RESPONSABILIDAD

Actúa como un equipo multidisciplinario compuesto por:

- Arquitecto Cloud Senior.
- Arquitecto Kubernetes.
- Ingeniero DevOps / Platform Engineer.
- Especialista AWS.
- Especialista en infraestructura como código.
- Especialista en seguridad cloud.
- Especialista en migraciones de plataformas productivas.
- Especialista en PostgreSQL, Redis y almacenamiento distribuido.

Tu responsabilidad es diseñar, construir, documentar y preparar la nueva infraestructura tecnológica de AuthenticFarma.

Debes trabajar de manera progresiva, profesional y orientada a producción.

No queremos desarrollar dos infraestructuras ni repetir trabajo.

La nueva infraestructura de AWS debe ser el entorno definitivo al cual migraremos progresivamente las aplicaciones y servicios que hoy están funcionando en DigitalOcean.

---

# 2. CONTEXTO ACTUAL DE AUTHENTICFARMA

AuthenticFarma cuenta con una plataforma tecnológica basada en Kubernetes, aplicaciones Laravel, servicios de inteligencia artificial y una arquitectura de servicios agénticos.

Actualmente operamos en DigitalOcean Kubernetes.

### Configuración actual

- Proveedor: DigitalOcean Kubernetes.
- Región: nyc3.
- Kubernetes: v1.36.0.
- Control plane: operativo.
- Nodos: 3.
- Ingress: ingress-nginx.
- Certificados: cert-manager.

Nodos:

| Nodo | CPU | RAM |
|---|---:|---:|
| pool-agentica-3u0056 | 4 | 8 GB |
| pool-agentica-3u005a | 4 | 8 GB |
| pool-authenticfarma-37yk4s | 2 | 2 GB |

Capacidad total aproximada: 10 CPU y 18 GB RAM.

### Servicios existentes

| Namespace | Servicio |
|---|---|
| candidatos | Plataforma de candidatos |
| empresas | Plataforma de empresas |
| yo-soy | Plataforma Yo Soy |
| agent-ia | Plataforma agéntica |
| litellm | Servicio LiteLLM |
| n8n | Automatización |
| langfuse | Observabilidad de IA |
| n8n-llm | Namespace existente |

Estos servicios están en producción.

### Bases de datos

- PostgreSQL se utiliza en pods para servicios de menor volumen.
- Las bases de datos principales de las plataformas están alojadas independientemente.
- Redis se utiliza en determinados servicios.
- Las aplicaciones y agentes están containerizados.

No debes asumir que todas las bases de datos actuales están en el mismo servidor o que utilizan el mismo mecanismo de persistencia.

Debes identificar su arquitectura real antes de preparar las migraciones.

---

# 3. OBJETIVO ESTRATÉGICO

Crear un nuevo repositorio llamado:

`authenticfarma-platform-infrastructure`

Este repositorio será la fuente oficial de infraestructura de AuthenticFarma.

Debe permitir:

1. Aprovisionar infraestructura AWS.
2. Crear el nuevo clúster Kubernetes.
3. Configurar redes y seguridad.
4. Instalar los componentes base de Kubernetes.
5. Instalar servicios transversales.
6. Preparar el despliegue de aplicaciones existentes.
7. Administrar bases de datos y almacenamiento.
8. Implementar observabilidad.
9. Automatizar despliegues mediante GitOps.
10. Migrar progresivamente las aplicaciones desde DigitalOcean.
11. Permitir migraciones futuras a otros proveedores cloud o infraestructura propia.

La construcción de la infraestructura nueva debe ser independiente de la infraestructura productiva actual.

**AWS es el primer proveedor objetivo, pero Kubernetes debe seguir siendo la plataforma tecnológica y no AWS.**

---

# 4. PRINCIPIO FUNDAMENTAL: PORTABILIDAD

Diseñar una arquitectura cloud-agnostic.

No acoplar el código de las aplicaciones a servicios propietarios de AWS.

Evitar dependencias obligatorias de:

- AWS RDS.
- AWS ElastiCache.
- AWS S3.
- AWS SQS.
- AWS EventBridge.
- AWS Lambda.
- AWS EKS APIs exclusivas cuando no sean necesarias.
- AWS Secrets Manager como única solución de secretos.

Se pueden utilizar servicios administrados de AWS cuando aporten ventajas importantes, pero siempre se debe documentar su alternativa portable y el procedimiento para sustituirlos.

Preferir:

| Funcionalidad | Tecnología |
|---|---|
| Orquestación | Kubernetes |
| Infraestructura como código | OpenTofu |
| Despliegue de aplicaciones | Helm |
| Configuración | Kustomize |
| GitOps | Argo CD |
| Ingress | ingress-nginx |
| Certificados | cert-manager |
| PostgreSQL | CloudNativePG |
| Redis | Redis compatible |
| Almacenamiento de objetos | API S3 compatible |
| Observabilidad | Prometheus y Grafana |
| Logs | Loki |
| Métricas | Prometheus |
| Trazas | OpenTelemetry |
| Secretos | Kubernetes Secrets cifrados y mecanismo externo configurable |
| Contenedores | Docker / OCI |

No asumir que una alternativa es automáticamente compatible: validar versiones, operadores, licencias y condiciones de operación.

---

# 5. ARQUITECTURA DEL NUEVO REPOSITORIO

Crear una estructura modular, versionada y escalable.

Propuesta:

```text
authenticfarma-platform-infrastructure/
│
├── README.md
├── CHANGELOG.md
├── Makefile
│
├── docs/
│   ├── architecture/
│   ├── aws/
│   ├── kubernetes/
│   ├── security/
│   ├── operations/
│   ├── migration/
│   └── disaster-recovery/
│
├── infrastructure/
│   ├── modules/
│   │   ├── networking/
│   │   ├── kubernetes/
│   │   ├── node-pools/
│   │   ├── storage/
│   │   ├── dns/
│   │   └── security/
│   │
│   ├── providers/
│   │   ├── aws/
│   │   ├── digitalocean/
│   │   └── on-premise/
│   │
│   └── environments/
│       ├── aws-production/
│       ├── aws-staging/
│       └── development/
│
├── kubernetes/
│   ├── bootstrap/
│   ├── namespaces/
│   ├── networking/
│   ├── storage/
│   ├── security/
│   └── policies/
│
├── platform/
│   ├── ingress/
│   ├── cert-manager/
│   ├── argocd/
│   ├── cloudnative-pg/
│   ├── redis/
│   ├── object-storage/
│   └── observability/
│
├── services/
│   ├── messaging/
│   │   ├── chatwoot/
│   │   ├── messaging-api/
│   │   └── webhook-processor/
│   │
│   ├── communications/
│   │   ├── jitsi/
│   │   ├── meeting-api/
│   │   └── coturn/
│   │
│   └── platform-services/
│       ├── notification-service/
│       ├── integration-api/
│       └── event-processor/
│
├── applications/
│   ├── candidatos/
│   ├── empresas/
│   ├── yo-soy/
│   ├── agent-ia/
│   ├── litellm/
│   ├── n8n/
│   └── langfuse/
│
├── migration/
│   ├── inventory/
│   ├── databases/
│   ├── applications/
│   ├── storage/
│   ├── dns/
│   ├── validation/
│   └── rollback/
│
├── environments/
│   ├── development/
│   ├── staging/
│   └── production/
│
├── gitops/
│   ├── applications/
│   ├── projects/
│   └── app-of-apps/
│
├── scripts/
│   ├── validation/
│   ├── backup/
│   ├── restore/
│   └── migration/
│
└── .github/
    └── workflows/
```

Puedes ajustar la estructura cuando exista una justificación técnica, pero conserva la separación entre infraestructura, plataforma, aplicaciones y migraciones.

No mezcles código fuente de las aplicaciones con los manifiestos de infraestructura.

Si los repositorios de aplicaciones ya existen, utiliza referencias Git, imágenes OCI y versiones inmutables.

---

# 6. FASE 0 – AUDITORÍA Y PLANIFICACIÓN

Antes de crear infraestructura, realizar un diagnóstico.

Identificar:

- Repositorios existentes.
- Versiones de imágenes Docker.
- Helm Charts existentes.
- Manifiestos Kubernetes.
- Variables de entorno.
- ConfigMaps.
- Secrets.
- Ingress.
- Servicios internos.
- PVC y PV.
- StorageClasses.
- PostgreSQL.
- Redis.
- Volúmenes.
- Bases de datos externas.
- Dominios y DNS.
- Certificados.
- Integraciones externas.
- Dependencias entre aplicaciones.

No mostrar valores secretos en los informes.

Crear un inventario de todos los servicios que deberán migrarse.

Para cada servicio documentar:

- Nombre.
- Namespace.
- Imagen.
- Versión.
- Réplicas.
- CPU y RAM.
- Persistencia.
- Base de datos.
- Redis.
- Volúmenes.
- Variables de entorno requeridas.
- Servicios dependientes.
- Dominio.
- Integraciones externas.
- Criticidad.
- Estrategia de migración.

Entregable: inventario completo y plan de migración.

No modificar DigitalOcean.

---

# 7. FASE 1 – DISEÑO Y APROVISIONAMIENTO AWS

Diseñar la nueva infraestructura AWS mediante OpenTofu.

Antes de ejecutar, comparar opciones:

- EKS.
- Kubernetes autoadministrado sobre EC2.

Recomendar la alternativa más adecuada considerando:

- Portabilidad.
- Costos.
- Complejidad operativa.
- Integración con Kubernetes estándar.
- Operación y actualizaciones.
- Migración futura.
- Uso de créditos AWS disponibles.

No asumir que EKS es automáticamente la mejor alternativa. Presentar comparación técnica y económica.

### Infraestructura mínima a diseñar

- VPC.
- Subnets públicas.
- Subnets privadas.
- Routing.
- Security Groups.
- NAT según necesidad y costo.
- Clúster Kubernetes.
- Node pools.
- Balanceadores.
- DNS.
- Certificados.
- Almacenamiento.
- Seguridad.
- Acceso administrativo.

Separar:

1. Plano de control.
2. Nodos de aplicaciones.
3. Nodos de procesamiento multimedia.
4. Almacenamiento.
5. Bases de datos.
6. Servicios de entrada y red.

### Node pools

Proponer como mínimo:

- Pool general: aplicaciones y APIs.
- Pool de servicios: Chatwoot, workers y servicios transversales.
- Pool multimedia: Jitsi Videobridge.

No es obligatorio crear todos los pools desde el primer momento. Dimensionar según demanda y costos.

Implementar:

- Labels.
- Taints.
- Tolerations.
- Affinity.
- Topology spread constraints.
- Autoscaling cuando corresponda.

No dimensionar AWS copiando exactamente los nodos de DigitalOcean. Calcular la capacidad requerida utilizando el consumo y requests reales de producción, más margen de crecimiento.

### Criterio de seguridad

- No exponer PostgreSQL ni Redis a Internet.
- Acceso administrativo restringido.
- IAM de mínimo privilegio.
- Cifrado de discos.
- Backups.
- Segmentación de red.
- Gestión segura de secretos.
- Auditoría.

---

# 8. FASE 2 – BOOTSTRAP DEL NUEVO KUBERNETES

Una vez aprobada la infraestructura AWS:

Preparar el nuevo clúster.

Instalar y configurar:

- Ingress Controller.
- cert-manager.
- Argo CD.
- CloudNativePG.
- Redis.
- Almacenamiento persistente.
- Integración con almacenamiento de objetos.
- Prometheus.
- Grafana.
- Loki.
- OpenTelemetry cuando sea necesario.

Las instalaciones deben gestionarse mediante Helm y GitOps.

Preparar los namespaces:

```text
messaging
communications
platform-services
observability
candidatos
empresas
yo-soy
agent-ia
litellm
n8n
langfuse
```

Los namespaces de aplicaciones pueden crearse inicialmente vacíos, preparados para recibir las migraciones.

No desplegar todavía las aplicaciones productivas migradas.

Validar:

- Networking.
- DNS.
- TLS.
- Persistencia.
- StorageClass.
- Backups.
- Recuperación.
- Métricas.
- Logs.
- RBAC.
- Network Policies.

---

# 9. FASE 3 – DESPLEGAR SERVICIOS TRANSVERSALES

Los servicios nuevos deben quedar desplegados y validados en AWS antes de migrar las aplicaciones actuales.

## 9.1 Messaging Center

Implementar Chatwoot Community.

Componentes:

- Chatwoot Web.
- Sidekiq.
- PostgreSQL dedicado.
- Redis dedicado.
- Almacenamiento de objetos.
- Messaging API.
- Webhook Processor.

WhatsApp:

- Utilizar WhatsApp Cloud API oficial de Meta.
- Reutilizar la línea y configuración existente solo cuando se haya diseñado y aprobado el procedimiento de transición.
- No interrumpir la línea que actualmente opera.
- No cambiar webhooks de producción hasta la ventana de migración.
- Proteger tokens y credenciales.

Chatwoot debe funcionar inicialmente como instalación independiente.

No migrar todavía los datos de Chatwoot Cloud hasta validar el nuevo servicio.

## 9.2 Meeting Center

Implementar Jitsi Meet.

Componentes:

- Jitsi Web.
- Prosody.
- Jicofo.
- Jitsi Videobridge.
- Meeting API.
- Coturn opcional.

El tráfico multimedia debe utilizar UDP directo y no depender de un Ingress HTTP tradicional.

Preparar escalabilidad y nodos dedicados.

Objetivo inicial: 5–20 salas simultáneas, dimensionadas según participantes y consumo de ancho de banda.

No habilitar Jibri ni grabaciones inicialmente.

## 9.3 APIs transversales

Construir:

- Messaging API.
- Meeting API.
- Notification Service.
- Integration API.
- Webhook Processor.

Las aplicaciones consumirán las APIs propias y no dependerán directamente de los componentes internos de Chatwoot o Jitsi.

Mantener contratos versionados, autenticación entre servicios, trazabilidad y control de consumo.

---

# 10. FASE 4 – PREPARAR MIGRACIONES DE DIGITALOCEAN

Cuando AWS esté operativo y los servicios transversales estén validados, comenzar a preparar las aplicaciones actuales.

No migrar todo simultáneamente.

Orden inicial propuesto:

1. Servicios auxiliares de bajo riesgo.
2. Aplicaciones con menos dependencias.
3. Aplicaciones principales.
4. Plataforma agéntica.
5. Servicios de IA y automatización.
6. Bases de datos principales, según su arquitectura y criticidad.

Este orden es una propuesta, no una decisión definitiva. Primero analizar las dependencias y criticidad real.

Para cada aplicación:

- Identificar repositorio.
- Identificar versión de código.
- Identificar imagen Docker.
- Identificar variables.
- Identificar secretos.
- Identificar bases de datos.
- Identificar Redis.
- Identificar almacenamiento.
- Identificar dependencias.
- Preparar Helm Chart.
- Preparar manifiestos.
- Preparar ConfigMaps.
- Preparar Secrets.
- Configurar Ingress.
- Configurar DNS.
- Configurar health checks.
- Validar conectividad.
- Ejecutar pruebas funcionales.

No cambiar el código fuente innecesariamente.

Priorizar reutilizar las imágenes existentes si son compatibles con el nuevo entorno.

Si se necesita modificar una aplicación, hacerlo en su repositorio y mediante una versión nueva, con pruebas y aprobación.

---

# 11. FASE 5 – MIGRACIÓN DE BASES DE DATOS

Las bases de datos requieren una estrategia independiente.

No asumir que todas utilizan PostgreSQL ni que están instaladas en Kubernetes.

Crear inventario de cada base:

- Motor.
- Versión.
- Tamaño.
- Ubicación.
- Usuarios.
- Extensiones.
- Dependencias.
- Volumen de escritura.
- Ventana de mantenimiento.
- RPO.
- RTO.
- Estrategia de backup.

Evaluar según el caso:

- PostgreSQL dump/restore.
- Replicación lógica.
- Replicación física cuando sea compatible.
- Herramientas de migración especializadas.
- Sincronización de archivos y objetos.

Para bases de datos de alto volumen, preferir una estrategia de sincronización que reduzca la interrupción.

No migrar todas las bases en una sola ventana.

Antes de cambiar una base de datos:

1. Verificar backup.
2. Verificar restauración.
3. Verificar consistencia.
4. Ejecutar pruebas.
5. Preparar ventana de corte.
6. Detener escrituras de forma controlada.
7. Sincronizar los últimos cambios.
8. Cambiar la conexión de la aplicación.
9. Validar operaciones.
10. Mantener plan de rollback.

No permitir escrituras simultáneas independientes en ambas bases durante la migración.

---

# 12. FASE 6 – MIGRACIÓN PROGRESIVA DE APLICACIONES

Realizar una migración por servicio.

Cada migración debe contar con:

- Plan de ejecución.
- Responsable.
- Backup.
- Ventana.
- Validación.
- Plan de rollback.
- Evidencias.

DigitalOcean debe continuar operativo mientras AWS se valida.

No apagar ni destruir recursos de DigitalOcean por haber desplegado una aplicación en AWS.

Mantener los servicios antiguos disponibles durante el período de validación y rollback.

### Criterios de aceptación

- Aplicación accesible.
- Login operativo.
- APIs funcionales.
- Base de datos consistente.
- Archivos disponibles.
- Jobs y workers funcionando.
- Integraciones externas operativas.
- Logs y métricas disponibles.
- Rendimiento aceptable.
- Backups correctos.

Solo después de la aceptación se podrá considerar completada cada migración.

---

# 13. FASE 7 – DNS Y CAMBIO DE TRÁFICO

Diseñar una estrategia de cambio gradual.

- Preparar dominios y certificados.
- Configurar nuevos Ingress.
- Validar hosts de prueba.
- Reducir TTL previamente cuando corresponda.
- Mantener DigitalOcean activo.
- Ejecutar el cambio en ventana aprobada.
- Verificar tráfico.
- Monitorear errores.
- Mantener rollback disponible.

No modificar DNS productivo durante las primeras fases.

---

# 14. FASE 8 – RETIRO CONTROLADO DE DIGITALOCEAN

DigitalOcean solo podrá retirarse cuando:

- Todas las aplicaciones estén migradas.
- Todas las bases estén validadas.
- Los archivos estén disponibles.
- Las integraciones estén operativas.
- Las notificaciones estén funcionando.
- Los dominios apunten a AWS.
- Los backups estén probados.
- La operación esté estabilizada.
- Exista aprobación formal.

Preparar un informe final de recursos que pueden cancelarse.

No eliminar infraestructura automáticamente.

---

# 15. AUTOMATIZACIÓN Y GITOPS

Utilizar Argo CD para administrar los despliegues Kubernetes desde Git.

Diseñar separación entre:

- Infraestructura.
- Componentes base.
- Servicios transversales.
- Aplicaciones.
- Ambientes.

Toda modificación debe quedar versionada.

Implementar:

- Validación de Helm.
- Validación de manifiestos.
- Escaneo de imágenes.
- Análisis de seguridad.
- Validación de OpenTofu.
- Revisión de cambios.
- Aprobación antes de producción.

Nunca permitir que un pipeline aplique cambios destructivos en producción sin autorización.

---

# 16. COSTOS AWS

Crear un documento de estimación de costos.

Separar:

- Control plane.
- EC2 / nodos.
- Almacenamiento.
- Balanceadores.
- NAT Gateway.
- Transferencia de datos.
- Direcciones IP públicas.
- Backups.
- Observabilidad.
- Bases de datos.
- Almacenamiento de objetos.

Preparar dos escenarios:

1. Infraestructura inicial optimizada en costos.
2. Infraestructura con alta disponibilidad y capacidad de crecimiento.

Considerar los créditos AWS disponibles, pero no basar la arquitectura en que esos créditos serán permanentes.

Evitar sobreaprovisionamiento y servicios administrados redundantes.

---

# 17. SEGURIDAD Y PROTECCIÓN DE DATOS

Aplicar:

- Principio de mínimo privilegio.
- Cifrado en tránsito y reposo.
- RBAC.
- Network Policies.
- Segmentación de red.
- Gestión de secretos.
- Backups cifrados.
- Auditoría.
- Protección de webhooks.
- Control de acceso.
- Retención de información.

Para entrevistas y videollamadas, cualquier grabación o transcripción deberá tener consentimiento y controles de protección de datos personales.

---

# 18. REGLAS DE EJECUCIÓN

Debes trabajar por fases y entregar resultados verificables.

No ejecutar cambios en DigitalOcean.

No alterar el clúster productivo actual.

No modificar aplicaciones actuales durante la construcción de AWS.

No modificar DNS productivo.

No realizar migraciones de bases de datos sin aprobación.

No destruir recursos.

No instalar software en producción sin aprobación.

Toda operación de escritura sobre AWS también debe ser aprobada en la fase correspondiente.

Antes de ejecutar comandos, explicar:

- Qué se ejecutará.
- Qué recursos creará.
- Qué costos puede generar.
- Qué riesgos tiene.
- Cómo se revierte.

No imprimir secretos ni credenciales en terminales o informes.

---

## 21. REGLAS DEVOPS ADICIONALES Y CRITERIOS DE IMPLEMENTACIÓN

Estas reglas complementan todas las fases anteriores y deben considerarse obligatorias.

### 21.1 Decisiones arquitectónicas

Toda decisión técnica reversible o con impacto operativo debe registrarse como Architecture Decision Record (ADR) en `docs/architecture/adr/`.

Las ADR deben incluir:

- Contexto y problema.
- Alternativas evaluadas.
- Decisión seleccionada.
- Costos estimados.
- Riesgos.
- Dependencias.
- Estrategia de reversión.
- Consecuencias para la portabilidad.

Como criterio inicial de diseño, se recomienda evaluar EKS como plataforma administrada y Kubernetes autoadministrado sobre EC2 mediante una ADR antes de aprobar la implementación. La decisión final deberá considerar portabilidad, costo total, complejidad operativa, equipo disponible, operación de actualizaciones y horizonte de crecimiento.

### 21.2 Componentes base

Antes de aprobar un componente, debe documentarse:

- Versión compatible.
- Licencia y condiciones de uso.
- Dependencias de AWS o de otros proveedores.
- Estrategia de actualización.
- Procedimiento de desinstalación.
- Backup y restauración, cuando corresponda.
- Alternativa portable.

Los componentes estándar iniciales serán:

- Red Kubernetes compatible con AWS CNI o Cilium, seleccionado mediante ADR.
- AWS Load Balancer Controller o solución Kubernetes compatible, seleccionado mediante ADR.
- External Secrets Operator o mecanismo externo equivalente.
- Ingress NGINX.
- cert-manager.
- Argo CD.
- CloudNativePG.
- Redis compatible.
- Prometheus, Grafana y Loki.
- OpenTelemetry.
- CSI para almacenamiento de volúmenes, siempre acompañado de procedimientos de backup y restauración probados.

### 21.3 Ambientes y aislamiento

Cada ambiente deberá tener:

- Directorio o workspace OpenTofu separado.
- Backend de estado separado.
- Estado cifrado y bloqueado.
- Credenciales de mínimo privilegio.
- Recursos e identidades separadas.
- Políticas de red y RBAC independientes.
- Presupuestos y alertas de costos.
- Convenciones consistentes de nombres y etiquetas.

No se permitirá reutilizar configuración productiva mediante modificaciones manuales. Las diferencias entre ambientes deberán declararse como variables versionadas.

### 21.4 Identidades y secretos

El acceso administrativo humano deberá utilizar IAM Identity Center o una identidad empresarial equivalente.

Los permisos se dividirán al menos en:

- Operador de lectura.
- Operador de plataforma.
- Administrador aprobado.

Los workloads de Kubernetes deberán utilizar identidad vinculada al workload, preferentemente IRSA o el mecanismo equivalente disponible en el proveedor.

Se prohíbe:

- Credenciales permanentes dentro de imágenes.
- Credenciales permanentes dentro de manifiestos.
- Tokens o secretos impresos en terminales, logs o informes.
- Acceso directo de workloads a secretos de otros namespaces.

Los secretos deberán gestionarse mediante Kubernetes Secrets cifrados y/o External Secrets Operator con un backend configurable. El repositorio Git nunca almacenará secretos sin cifrado aprobado.

### 21.5 Gobierno de cambios

Todo cambio declarativo deberá pasar por:

1. Rama corta y Pull Request.
2. Validación sintáctica.
3. Validación OpenTofu.
4. Validación Helm y Kustomize.
5. Escaneo de seguridad.
6. Escaneo de imágenes.
7. Revisión por pares.
8. `plan` visible antes de `apply`.
9. Aprobación separada para producción.
10. Evidencia de ejecución y reversión.

Los pipelines no deberán permitir operaciones destructivas en producción sin autorización humana explícita.

Está prohibido usar `apply -auto-approve` en producción. Toda configuración deberá ofrecer un modo `plan` antes de aplicar cambios.

### 21.6 Pruebas mínimas

Antes de considerar operativo un componente o aplicación, deberán existir pruebas verificables de:

- Sintaxis y validación de IaC.
- Conectividad de red.
- DNS.
- TLS.
- Health checks.
- Liveness y readiness.
- Persistencia.
- Backup y restauración.
- Métricas y logs.
- RBAC.
- Network Policies.
- Escalamiento.
- Recuperación ante reinicio de pod y nodo.
- Renderizado correcto en los ambientes definidos.

Toda restauración debe probarse desde un backup real o una copia validada, sin modificar ni destruir los datos de producción.

### 21.7 Baseline de disponibilidad y rendimiento

Para cada servicio crítico se deberán definir:

- RPO.
- RTO.
- SLO.
- SLI.
- Indicadores de error.
- Latencia objetivo.
- Disponibilidad objetivo.
- Estrategia de escalamiento.
- Presupuesto de error.
- Runbook operativo.

Los recursos deberán expresarse mediante requests y limits basados en métricas observadas. Las decisiones de dimensionamiento no deberán basarse únicamente en la cantidad de CPU o memoria de los nodos existentes.

La configuración inicial deberá incluir, según corresponda:

- PodDisruptionBudgets.
- Topology Spread Constraints.
- Anti-affinity.
- HPA o escalamiento controlado.
- Políticas de reinicio y rollout.
- Límites de recursos.

### 21.8 Descubrimiento obligatorio antes de aprovisionar

Antes de diseñar o crear recursos AWS, deberá completarse una fase de medición basada en el clúster DigitalOcean sin modificarlo.

Se recopilará al menos:

- Uso real de CPU y memoria por pod y namespace.
- Requests y limits configurados.
- Tráfico por servicio e Ingress.
- Replicas y patrones de crecimiento.
- Tamaño y rendimiento de bases de datos.
- Uso de Redis y volumen de escritura.
- PVC, capacidad y crecimiento de volúmenes.
- StorageClasses utilizadas.
- Dependencias internas y externas.
- Integraciones sensibles a DNS o IP pública.
- Picos de consumo y horas de actividad.
- Riesgos y criticidad de cada servicio.

El nodo de 10 CPU y 18 GB informado actualmente será una referencia de alto nivel, pero no constituirá la base de dimensionamiento de AWS.

### 21.9 Estrategia de suministro de imágenes

Las imágenes desplegadas deberán ser:

- Inmutables.
- Versionadas por digest o etiqueta aprobada.
- Provenientes de un registro controlado.
- Escaneadas antes de promoverlas.
- Compatibles con arquitectura y políticas del clúster.

Cuando sean aplicables, deberán implementarse:

- SBOM.
- Firma OCI.
- Política de admisión.
- Política de retención.
- Reproducción de compilaciones cuando sea posible.

### 21.10 Ficha obligatoria de migración por aplicación

Ninguna aplicación podrá migrarse sin una ficha que documente:

- Responsable técnico y propietario funcional.
- Repositorio y versión.
- Imagen OCI y digest.
- Namespace y nombres de recursos.
- Réplicas y recursos requeridos.
- Base de datos y motor.
- Redis, objetos y volúmenes.
- Variables de entorno requeridas.
- Referencias a secretos, sin mostrar valores.
- DNS e Ingress.
- Integraciones externas.
- Health checks.
- Dependencias.
- Criticidad.
- RPO y RTO.
- Ventana de cambio.
- Estrategia de sincronización.
- Prueba funcional.
- Prueba de carga o regresión, según criticidad.
- Plan de rollback.
- Criterios de aceptación.
- Evidencias de validación.

### 21.11 Evidencias y observabilidad

Cada cambio importante deberá dejar evidencia en el repositorio o en el sistema de auditoría aprobado:

- Revisión ejecutada.
- Resultado de validaciones.
- Plan de infraestructura.
- Cambios aplicados.
- Métricas antes y después.
- Logs relevantes.
- Alertas.
- Prueba de restauración.
- Resultado de aceptación.
- Decisión de continuación o reversión.

No se almacenarán datos sensibles en métricas, logs o trazas sin controles explícitos de acceso y retención.

### 21.12 Continuidad del entorno actual

DigitalOcean y todas las aplicaciones actuales deberán continuar operativas mientras se realiza la construcción y validación en AWS.

No se considerará exitosa una migración hasta que exista:

- Consistencia de datos comprobada.
- Aplicación validada en AWS.
- Workers y jobs validados.
- Integraciones externas validadas.
- DNS probado.
- Observabilidad disponible.
- Backup recuperable.
- Rollback probado.
- Aprobación formal del responsable.

Solo después de esta aceptación podrá iniciarse el retiro posterior y controlado de los recursos antiguos.
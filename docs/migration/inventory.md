# Inventario inicial de servicios

Este inventario contiene únicamente servicios conocidos. Los detalles reales deben completarse mediante auditoría sin modificar producción.

| Nombre | Namespace | Persistencia conocida | Base de datos | Crítica | Estado |
|---|---|---|---|---|---|
| Plataforma candidatos | candidatos | Por auditar | Por auditar | Alta | Pendiente |
| Plataforma empresas | empresas | Por auditar | Por auditar | Alta | Pendiente |
| Yo Soy | yo-soy | Por auditar | Por auditar | Alta | Pendiente |
| Plataforma agéntica | agent-ia | Por auditar | Por auditar | Alta | Pendiente |
| LiteLLM | litellm | Por auditar | Por auditar | Alta | Pendiente |
| n8n | n8n | Por auditar | Por auditar | Alta | Pendiente |
| Langfuse | langfuse | Por auditar | PostgreSQL/Redis por auditar | Alta | Pendiente |
| n8n-llm | n8n-llm | Por auditar | Por auditar | Media | Pendiente |
| Chatwoot | messaging | Nuevo servicio | PostgreSQL/Redis dedicados | Alta | Por diseñar |
| Jitsi | communications | Sin persistencia inicialmente | Ninguna obligatoria | Alta | Por diseñar |

## Auditoría requerida

Para cada servicio documentar: imagen, digest, réplicas, requests, limits, ConfigMaps, Secrets referenciados, PVC, StorageClass, Ingress, dominio, dependencias, Redis, bases de datos, integraciones externas, RPO, RTO y estrategia de migración.

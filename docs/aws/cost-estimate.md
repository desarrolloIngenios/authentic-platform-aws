# Estimación de costos AWS

## Escenario inicial optimizado

Costos variables a calcular después de definir región, tamaño y créditos:

- Plano de control EKS.
- EC2 de nodos generales y multimedia.
- EBS para volúmenes y datos locales.
- NAT Gateway y transferencia de datos.
- Balanceadores de carga.
- IP públicas.
- S3 y transferencias.
- Backups y snapshots.
- Logs y métricas.
- Registro de imágenes.
- Servicios administrados opcionales.

## Escenario de alta disponibilidad

Incluye capacidad adicional para tolerancia de fallos, réplicas y recuperación.

## Reglas

- No depender de créditos permanentes.
- Evitar recursos o gestión redundante innecesaria.
- Revisar precios y descuentos antes de aprovisionar.
- Activar presupuesto, alertas y etiquetas.
- Validar costos trimestrales y después de cada escalamiento.

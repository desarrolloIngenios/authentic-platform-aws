# Ambiente AWS shared services

Root independiente para una VPC de servicios compartidos, usando el módulo `infrastructure/modules/networking` y el prefijo `authenticfarma360-shared-services`.

El CIDR predeterminado es `10.40.0.0/16`. Usa estado remoto con clave S3 propia, tres AZ (`us-east-1a/b/c`) y NAT deshabilitado. Define `aws_account_id` en un archivo `*.tfvars` local excluido de Git. Confirmar que la cuenta elegida es la dueña de la red hub y que el CIDR no se superpone con desarrollo (`10.10.0.0/16`), staging (`10.20.0.0/16`), producción (`10.30.0.0/16`) ni redes conectadas.

No se configura backend remoto en este root hasta confirmar la cuenta y la estrategia de estado compartido. No ejecutar `apply` sin revisar el plan y aprobar conectividad, NAT/endpoints, costos y límites de aislamiento entre ambientes.
# Ambiente AWS staging

Este root crea una VPC con subredes públicas y privadas en las zonas configuradas. Usa el módulo común `infrastructure/modules/networking` y el prefijo `authenticfarma360-staging`.

## Inputs obligatorios

- `aws_account_id`: cuenta staging aprobada; el provider rechaza otra cuenta.
- `availability_zones`: al menos dos zonas válidas de la región.
- `nat_gateway_mode`: `none`, `single` o `per_az`; revisar costo y disponibilidad.

El CIDR predeterminado es `10.20.0.0/16`. Usa estado remoto con clave S3 propia, tres AZ (`us-east-1a/b/c`) y NAT deshabilitado. Las subredes privadas no tendrán salida a Internet.

El perfil predeterminado es `authenticfarma-devops`, autenticado mediante IAM Identity Center, y la región predeterminada es `us-east-1`. Inicie sesión con `aws sso login --profile authenticfarma-devops`. El perfil actualmente resuelve a la cuenta `889629667448`; confirme que esa sea la cuenta aprobada para staging. Puede sobrescribir `aws_profile` y `aws_region` localmente cuando corresponda.

`project_name` usa `AuthenticFarma360`; `environment` está fijado a `staging`. Los archivos `*.tfvars` locales están excluidos de Git. Use identidad AWS de mínimo privilegio y no guarde credenciales en el repositorio.

## Validar

```sh
tofu -chdir=infrastructure/environments/aws-staging init -backend=false
tofu -chdir=infrastructure/environments/aws-staging validate
tofu fmt -check -recursive infrastructure
```

Esta configuración aún no tiene backend remoto. No usar para un despliegue compartido hasta configurar estado cifrado con bloqueo. No ejecute `apply`; primero revise un `plan` y obtenga aprobación explícita. EKS, Kubernetes, endpoints privados y Security Groups de cargas se decidirán en etapas posteriores.
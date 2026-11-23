# Ambiente AWS development

Este root crea una VPC independiente con subredes públicas y privadas en las zonas configuradas. Usa el módulo común `infrastructure/modules/networking` y el prefijo `authenticfarma360-development`.

El perfil predeterminado es `authenticfarma-devops`, autenticado mediante IAM Identity Center, y la región predeterminada es `us-east-1`. Inicie sesión con `aws sso login --profile authenticfarma-devops`. El perfil actualmente resuelve a la cuenta `889629667448`; confirme que sea la cuenta aprobada para desarrollo.

Defina `aws_account_id`, `vpc_cidr`, `availability_zones` y `nat_gateway_mode` en un archivo `*.tfvars` local. Puede sobrescribir `aws_profile` y `aws_region` si el ambiente usa otra cuenta o región. El CIDR debe estar aprobado y no superponerse con otros ambientes ni redes actuales/futuras. `nat_gateway_mode` acepta `none`, `single` o `per_az`; cada opción tiene consecuencias distintas de conectividad, disponibilidad y costo, descritas en el README del módulo.

`project_name` usa `AuthenticFarma360` y `environment` está fijado a `development`. No se ha configurado backend remoto ni se debe ejecutar `apply`. Antes de desplegar, configurar estado cifrado con bloqueo, validar identidad de mínimo privilegio y revisar el `plan` con aprobación explícita.
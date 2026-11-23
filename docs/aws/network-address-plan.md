# Plan de direccionamiento AWS

Los siguientes bloques se reservan para evitar superposición entre VPCs. Deben revisarse contra redes conectadas (DigitalOcean, on-premises, VPN, Transit Gateway u otras cuentas) antes de establecer peering o conectividad híbrida.

| Dominio | CIDR reservado | Root OpenTofu | Estado |
|---|---|---|---|
| AWS Development | `10.10.0.0/16` | `infrastructure/environments/aws-development` | Desplegado |
| AWS Staging | `10.20.0.0/16` | `infrastructure/environments/aws-staging` | Desplegado en `vpc-0fa61ced7fcdbced7` |
| AWS Production | `10.30.0.0/16` | `infrastructure/environments/aws-production` | Desplegado en `vpc-01f03dbae30abb93e` |
| Servicios compartidos | `10.40.0.0/16` | `infrastructure/environments/aws-shared-services` | Desplegado en `vpc-0813fbf0876bd488f` |

Cada root divide su bloque en subredes públicas y privadas por Availability Zone. El rango real de cada subred se determina por `subnet_newbits`.
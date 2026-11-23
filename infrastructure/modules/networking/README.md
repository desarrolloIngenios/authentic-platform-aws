# Módulo networking AWS

Este módulo define una VPC IPv4 con DNS habilitado, un Internet Gateway, subredes públicas y privadas por Availability Zone y sus tablas de rutas. No crea Security Groups genéricos; cada componente deberá declarar reglas específicas de mínimo privilegio.

## Subredes y salida

Por cada Availability Zone se crean una subred pública y una privada. El módulo divide el CIDR de la VPC en bloques iguales; `subnet_newbits` añade cuatro bits por defecto. Por ejemplo, una VPC `/16` produce subredes `/20`.

`nat_gateway_mode` debe elegirse explícitamente:

- `none`: no crea NAT y las subredes privadas no tienen ruta de salida a Internet.
- `single`: un NAT compartido para todas las subredes privadas; menor costo, sin alta disponibilidad de salida entre zonas y puede generar transferencia inter-AZ.
- `per_az`: un NAT por zona; mayor disponibilidad y mayor costo.

No se crean VPC endpoints en esta base; se deben evaluar por servicio, necesidad y costo.

## Antes de aplicar

- Aprobar CIDR no superpuestos entre ambientes y redes existentes o futuras.
- Confirmar región y al menos dos Availability Zones válidas para esa región.
- Decidir el modo NAT con una estimación de costos.
- Configurar backend remoto cifrado y con bloqueo de estado por ambiente.
- Revisar `tofu plan`; `apply` requiere aprobación separada.

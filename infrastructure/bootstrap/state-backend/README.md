# Bootstrap del backend remoto

Este root crea el bucket S3 dedicado al estado de OpenTofu en la cuenta `889629667448`, región `us-east-1`. El bootstrap conserva su propio estado local; después de crearlo, los roots de cada ambiente usarán el bucket con claves separadas y bloqueo nativo de S3.

El bucket tiene versionado, cifrado SSE-S3, bloqueo de acceso público, propiedad `BucketOwnerEnforced`, denegación de transporte sin TLS y `force_destroy = false`. El acceso debe seguir limitado por IAM al equipo de infraestructura.

El almacenamiento, las solicitudes y las versiones anteriores de objetos pueden generar cargos según uso. Este bootstrap no configura bucket de logs de acceso ni eventos de datos de CloudTrail; deben evaluarse antes de guardar estado de producción.

Inicialice con backend local, revise el plan y aplique solo después de aprobarlo:

```sh
tofu -chdir=infrastructure/bootstrap/state-backend init -backend=false
tofu -chdir=infrastructure/bootstrap/state-backend plan
```

No elimine el estado local de bootstrap. No aplique hasta revisar el plan y confirmar que solo contiene el bucket y sus controles de seguridad.
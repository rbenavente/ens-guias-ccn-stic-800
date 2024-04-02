resource "prismacloud_policy" "op_exp1_r1" {
   name = "AWS Config Recording está deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
AWS Config es un servicio web que realiza la gestión de la configuración de los recursos de AWS compatibles dentro de su cuenta y le entrega archivos de registro. AWS config utiliza el registrador de configuración para detectar cambios en las configuraciones de sus recursos y capturar estos cambios como elementos de configuración. Supervisa y registra continuamente sus configuraciones de recursos de AWS y le permite automatizar la evaluación de las configuraciones registradas con respecto a las configuraciones deseadas. Esta política genera alertas cuando la grabadora de AWS Config no está habilitada.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Config Recording está deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-configservice-describe-configuration-recorders' AND json.rule = 'status.recording is true and status.lastStatus equals SUCCESS and recordingGroup.allSupported is true' as X; count(X) less than 1"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la Consola de administración de AWS
2. Seleccione la región específica de arriba hacia abajo para la cual se genera la alerta.
3. Navegue hasta el servicio 'Configuración' en el menú desplegable 'Servicios'.
Si existe la configuración de AWS Config,
a. Ir a la configuración
b. Haga clic en el botón "Activar" en la sección "La grabación está desactivada".
C. proporcione la información requerida para el depósito y el rol con el permiso adecuado
Si la configuración de AWS Config no existe
a. Haga clic en 'Comenzar'
b. Para el Paso 1, marque la casilla de verificación "Registrar todos los recursos admitidos en esta región" en la sección "Tipos de recursos para registrar".
C. En la sección 'Depósito de Amazon S3', seleccione el depósito con permiso para configurar servicios.
d. En la sección 'Rol de AWS Config', seleccione un rol con permiso para configurar servicios
mi. Haga clic en 'Siguiente'
F. Para el Paso 2, seleccione la regla requerida y haga clic en 'Siguiente'; de lo contrario, haga clic en 'Omitir'
gramo. Para el paso 3, revise la 'Configuración' creada y haga clic en 'Confirmar'

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp1.csrs_id # op.exp1 Compliance Section UUID

   }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp3.csrs_id # op.exp3 Compliance Section UUID

   }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id# op.mon3 Compliance Section UUID

   }

}




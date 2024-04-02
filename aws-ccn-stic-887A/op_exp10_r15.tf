
resource "prismacloud_policy" "op_exp10_r15" {
   name = "Política de claves de AWS KMS es demasiado permisiva" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica CMK que tienen una política de claves demasiado permisiva. Las políticas de claves son la forma principal de controlar el acceso a las claves maestras de clientes (CMK) en AWS KMS. Se recomienda seguir el principio de privilegio mínimo asegurando que la política de claves KMS no tenga todos los permisos para poder completar una acción maliciosa.

Para más detalles:
https://docs.aws.amazon.com/kms/latest/developerguide/control-access-overview.html#overview-policy-elements
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de claves de AWS KMS es demasiado permisiva"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-kms-get-key-rotation-status' AND json.rule = keyMetadata.keyState equals Enabled and policies.default.Statement[?any(Principal.AWS equals * and Condition does not exist)] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue hasta el Servicio de administración de claves (KMS)
4. Haga clic en 'Claves administradas por el cliente' (Panel izquierdo)
5. Seleccione la clave administrada por el cliente de KMS informada
6. Haga clic en la pestaña 'Política de claves'.
7. Haga clic en 'Editar',
Reemplace el beneficiario "Todos" (es decir, "*") del valor del elemento principal con un ID de cuenta de AWS o un ARN de cuenta de AWS.
O
Agregue una cláusula de condición a la declaración de política existente para que la CMK esté restringida.
8. Haga clic en 'Guardar cambios'

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}




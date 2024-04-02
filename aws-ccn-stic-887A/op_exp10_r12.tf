
resource "prismacloud_policy" "op_exp10_r12" {
   name = "Instancia AWS SageMaker Notebook no configurada con cifrado de datos en reposo mediante la clave KMS" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica las instancias de notebook de SageMaker que no están configuradas con cifrado de datos en reposo mediante la clave KMS administrada por AWS. Se recomienda implementar cifrado en reposo para proteger los datos de entidades no autorizadas.

Para más detalles:
https://docs.aws.amazon.com/sagemaker/latest/dg/encryption-at-rest.html
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Instancia AWS SageMaker Notebook no configurada con cifrado de datos en reposo mediante la clave KMS"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-sagemaker-notebook-instance' AND json.rule = 'notebookInstanceStatus equals InService and kmsKeyId does not exist'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
La instancia de notebook de AWS SageMaker no se puede configurar con cifrado de datos en reposo una vez creada. Debe crear una nueva instancia de notebook con cifrado en reposo mediante la clave KMS; migre todos los datos necesarios de la instancia de notebook reportada a la instancia de notebook recién creada antes de eliminar la instancia de notebook reportada.

Para crear una nueva instancia de notebook de AWS SageMaker,
1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de AWS SageMaker.
3. Elija Instancias de Notebook y luego elija 'Crear instancia de Notebook'.
4. En la página Crear instancia de notebook, en la sección 'Permisos y cifrado',
seleccione la clave KMS de la lista desplegable 'Clave de cifrado - opcional'. Si ya no hay ninguna clave KMS, primero debe crear una clave KMS.
5. Elija otros parámetros según sus necesidades y haga clic en el botón "Crear instancia de cuaderno".

Para eliminar la instancia de notebook reportada,
1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de AWS SageMaker.
3. Elija Instancias de Notebook y Elija la instancia de Notebook informada.
4. Haga clic en el menú desplegable 'Acciones' y seleccione la opción 'Detener', y cuando la instancia se detenga, seleccione la opción 'Eliminar'.
5. Dentro del cuadro de diálogo Eliminar <nombre-instancia-notebook>, haga clic en el botón Eliminar para confirmar la acción.

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}




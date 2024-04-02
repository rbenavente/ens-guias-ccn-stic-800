
resource "prismacloud_policy" "op_exp10_r3" {
   name = "Instancia AWS SageMaker Notebook no está cifrada con la clave administrada por el cliente CMK" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las instancias de notebook de SageMaker que no están cifradas mediante la clave administrada por el cliente. Las instancias de notebook de SageMaker deben cifrarse con claves maestras de cliente (CMK) de Amazon KMS en lugar de claves administradas de AWS para tener un control más granular sobre el proceso de cifrado/descifrado de datos en reposo y cumplir con los requisitos de cumplimiento.

Para más detalles:
https://docs.aws.amazon.com/sagemaker/latest/dg/encryption-at-rest.html
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Instancia AWS SageMaker Notebook no está cifrada con la clave administrada por el cliente CMK"
        criteria = "config from cloud.resource where api.name = 'aws-sagemaker-notebook-instance' AND json.rule = notebookInstanceStatus equals InService and kmsKeyId exists as X; config from cloud.resource where api.name = 'aws-kms-get-key-rotation-status' as Y; filter '$.X.kmsKeyId equals $.Y.key.keyArn and $.Y.keyMetadata.keyManager contains AWS'; show X; "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
El cifrado de la instancia de notebook de AWS SageMaker no se puede modificar una vez creado. Debe crear una nueva instancia de notebook con cifrado mediante una clave KMS personalizada; migre todos los datos necesarios de la instancia de notebook reportada a la instancia del notebook recién creada antes de eliminar la instancia de notebook reportada.

Para crear una nueva instancia de notebook de AWS SageMaker,
1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de AWS SageMaker.
3. Elija Instancias de Notebook y luego elija 'Crear instancia de Notebook'.
4. En la página Crear instancia de notebook, dentro de la sección 'Permisos y cifrado',
En la lista desplegable 'Clave de cifrado: opcional', elija una clave KMS personalizada para la nueva instancia del cuaderno de SageMaker.
5. Elija otros parámetros según sus necesidades y haga clic en el botón "Crear instancia de cuaderno".

Para eliminar la instancia de notebook reportada,
1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de AWS SageMaker.
3. Elija Instancias de Notebook y Elija la instancia de Notebook informada.
4. Haga clic en el menú desplegable 'Acciones', seleccione la opción 'Detener' y, cuando la instancia se detenga, seleccione la opción 'Eliminar'.
5. Dentro del cuadro de diálogo Eliminar <nombre-instancia-notebook>, haga clic en el botón Eliminar para confirmar la acción.

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}




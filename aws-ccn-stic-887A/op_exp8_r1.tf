resource "prismacloud_policy" "op_exp8_r1" {
   name = "La validación de logs de AWS CloudTrail no está habilitada en todas las regiones"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica AWS CloudTrails en los que la validación de logs no está habilitada en todas las regiones. La validación del archivo de registro de CloudTrail crea un archivo de resumen firmado digitalmente que contiene un hash de cada registro que CloudTrail escribe en S3. Estos archivos de resumen se pueden utilizar para determinar si un archivo de registro se modificó después de que CloudTrail lo entregó. Se recomienda habilitar la validación de archivos en todos los CloudTrails.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "La validación de logs de AWS CloudTrail no está habilitada en todas las regiones"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name='aws-cloudtrail-describe-trails' AND json.rule='logFileValidationEnabled is false' "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Accede al servicio 'CloudTrail'.
4. Para cada seguimiento informado, en Configuración > Ubicación de almacenamiento, asegúrese de que "Habilitar validación de archivos de registro" esté configurado en "Sí".

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp9.csrs_id # op.exp9 Compliance Section UUID

  }


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon1.csrs_id # op.mon1 Compliance Section UUID

  }
}




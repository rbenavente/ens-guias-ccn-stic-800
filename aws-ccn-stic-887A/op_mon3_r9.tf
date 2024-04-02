resource "prismacloud_policy" "op_mon3_r9" {
   name = "Distribución AWS CloudFront con el registro de acceso deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las distribuciones de CloudFront que tienen el registro de acceso deshabilitado. Al habilitar el registro de acceso en las distribuciones se crean archivos de registro que contienen información detallada sobre cada solicitud de usuario que recibe CloudFront. Los registros de acceso están disponibles para distribuciones web. Si habilita el registro, también puede especificar el depósito de Amazon S3 en el que desea que CloudFront guarde los archivos.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Distribución AWS CloudFront con el registro de acceso deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-cloudfront-list-distributions' AND json.rule = 'logging.enabled is false and logging.bucket is empty'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue hasta el panel de distribuciones de CloudFront.
4. Haga clic en la distribución reportada.
5. En la pestaña "General", haga clic en el botón "Editar".
6. En la página 'Editar distribución', establezca 'Registro' en 'Activado', elija un 'Depósito para registros' y un 'Prefijo de registro' según lo desee.
7. Haga clic en 'Sí, editar'

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id  # op.mon3 Compliance Section UUID

  }
 
   
}




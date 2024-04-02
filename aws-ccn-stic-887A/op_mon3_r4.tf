resource "prismacloud_policy" "op_mon3_r4" {
   name = "Logging para el plano de control de AWS EKS deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
El registro del plano de control de Amazon EKS proporciona registros de auditoría y diagnóstico directamente desde el plano de control de Amazon EKS a CloudWatch Logs en su cuenta. Estos registros le facilitan la seguridad y ejecución de sus clústeres. Puede seleccionar los tipos de registros exactos que necesita y los registros se envían como secuencias de registros a un grupo para cada clúster de Amazon EKS en CloudWatch.

Esta política genera una alerta si el registro del plano de control está deshabilitado.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Logging para el plano de control de AWS EKS deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-eks-describe-cluster' AND json.rule =  logging.clusterLogging[*].types[*] all empty or logging.clusterLogging[*].enabled is false "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para habilitar los registros del plano de control:

1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de Amazon EKS.
3. Elija el nombre del clúster para mostrar la información de su clúster.
4. En Registro, elija "Administrar registro".
5. Para cada tipo de registro individual, elija Activado.
6. Haga clic en 'Guardar cambios'


EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id  # op.mon3 Compliance Section UUID

  }
 
   
}




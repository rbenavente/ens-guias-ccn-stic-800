resource "prismacloud_policy" "op_acc4_r8" {
   name = "Actividad detectada con cuenta root"
   policy_type = "audit_event"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política detecta algún tipo de actividad realizada con el usuario root
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Actividad detectada con cuenta root"
        criteria = "event from cloud.audit_logs where subject IN ( 'root' )"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "AuditEvent"
        
    }
   recommendation = <<-EOT

No utilizar la cuenta raíz salvo necesidad expresa. Cuando se crea una cuenta en AWS, se deben crear usuarios, grupos o roles con privilegios administrativos para realizar las tareas de administración administrador y utilizar éstos, dejando sin uso el usuario root. Esta configuración debe entenderse como un mecanismo para impedir que el trabajo directo con privilegios de administrador repercuta negativamente en la seguridad, al acometer todas las acciones con el máximo privilegio cuando éste no es siempre requerido.

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }

}




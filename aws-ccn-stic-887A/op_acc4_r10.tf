resource "prismacloud_policy" "op_acc4_r10" {
   name = "Política de AWS IAM demasiado permisiva para todo el tráfico mediante una cláusula de condición"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica las políticas de IAM que tienen una política que es demasiado permisiva para todo el tráfico mediante una cláusula de condición. Si alguna declaración de política de IAM tiene una condición que contiene 0.0.0.0/0 o ::/0, permite todo el tráfico a los recursos asociados a esa política de IAM. Se recomienda encarecidamente tener la política de IAM con menos privilegios para proteger la fuga de datos y el acceso no autorizado.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de AWS IAM demasiado permisiva para todo el tráfico mediante una cláusula de condición"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-iam-get-policy-version' AND json.rule = document.Statement[?any((Condition.ForAnyValue:IpAddress.aws:SourceIp contains 0.0.0.0/0 or Condition.IpAddress.aws:SourceIp contains 0.0.0.0/0 or Condition.IpAddress.aws:SourceIp contains ::/0 or Condition.ForAnyValue:IpAddress.aws:SourceIp contains ::/0) and Effect equals Allow and Action contains *)] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT

1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de IAM
3. Haga clic en 'Políticas' en el panel de la izquierda.
4. Busque la Política para la cual se genera la alerta y haga clic en ella.
5. En la pestaña Permisos, haga clic en Editar política.
6. En el editor visual, haga clic para expandir y realizar lo siguiente;
a. Haz clic para ampliar 'Solicitar condiciones'
b. En 'IP de origen', elimine la fila con la entrada '0.0.0.0/0' o '::/0'. Agregue condiciones con rangos de IP restrictivos.
7. Haga clic en Revisar política y Guardar cambios.
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }

}




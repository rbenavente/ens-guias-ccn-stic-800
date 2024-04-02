resource "prismacloud_policy" "op_acc2_r2" {
   name = "AWS Auto Scaling Group no está configurada con el servicio de metadatos de instancia v2 (IMDSv2)"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
  Esta política identifica la configuración  de los grupos de escalado  automático donde IMDSv2 está configurado como opciona. Con IMDSv2, cada solicitud ahora está protegida mediante autenticación de sesión. La versión 2 de IMDS agrega nuevas protecciones que no estaban disponibles en IMDSv1 para proteger aún más sus instancias EC2 creadas por el grupo de escalado automático. Se recomienda utilizar solo IMDSv2 para todas sus instancias EC2.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Auto Scaling Group no está configurada con el servicio de metadatos de instancia v2 (IMDSv2)"
        criteria = "config from cloud.resource where api.name = 'aws-ec2-autoscaling-launch-configuration' AND json.rule = (metadataOptions.httpEndpoint does not exist) or (metadataOptions.httpEndpoint equals 'enabled' and metadataOptions.httpTokens equals 'optional') as X; config from cloud.resource where api.name = 'aws-describe-auto-scaling-groups' as Y; filter ' $.X.launchConfigurationName equal ignore case $.Y.launchConfigurationName'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
  No puede modificar una configuración de inicio después de crearla. Para cambiar la configuración de lanzamiento de un grupo de Auto Scaling, utilice una configuración de lanzamiento existente como base para una nueva configuración de lanzamiento con IMDSv2 habilitado.

Para actualizar el grupo de Auto Scaling para usar la nueva configuración de lanzamiento, siga los pasos a continuación:

1. Abra la consola de Amazon EC2.
2. En el panel de navegación izquierdo, en 'Auto Scaling', elija 'Grupos de Auto Scaling' y elija 'Iniciar configuraciones' cerca de la parte superior de la página.
3. Seleccione la configuración de inicio informada y elija Acciones, luego haga clic en 'Copiar configuración de inicio'. Esto configura una nueva configuración de inicio con las mismas opciones que la original, pero con "Copiar" agregado al nombre.
4. En la página "Crear configuración de inicio", expanda "Detalles avanzados" en "Configuración adicional - opcional".
5. En "Detalles avanzados", vaya a la sección "Versión de metadatos".
6. Seleccione la opción 'Solo V2 (se requiere token)'.
7. Cuando haya terminado, haga clic en el botón 'Crear configuración de inicio' en la parte inferior de la página.
8. En el panel de navegación, en Auto Scaling, elija Grupos de Auto Scaling.
9. Seleccione la casilla de verificación junto al grupo Auto Scaling.
10. Se abre un panel dividido en la parte inferior de la página, que muestra información sobre el grupo seleccionado.
11. En la pestaña Detalles, haga clic en el botón 'Editar' adyacente a la opción 'Iniciar configuración'.
12. En el menú desplegable 'Configuración de inicio', seleccione la configuración de inicio recién creada.
13. Cuando haya terminado de cambiar la configuración de inicio, haga clic en el botón 'Actualizar' en la parte inferior de la página.

Después de cambiar la configuración de lanzamiento de un grupo de Auto Scaling, todas las instancias nuevas se lanzan con las nuevas opciones de configuración. Las instancias existentes no se ven afectadas. Para actualizar instancias existentes,

1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha para la cual se genera la alerta.
3. Consulte la sección 'Configurar opciones de metadatos de instancias para instancias existentes' en la siguiente URL:
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-existing-instances.html

Para eliminar la configuración de inicio del grupo de Auto Scaling informada, siga los pasos a continuación:

1. Abra la consola de Amazon EC2.
2. En el panel de navegación izquierdo, en 'Auto Scaling', elija 'Grupos de Auto Scaling' y elija 'Iniciar configuraciones' cerca de la parte superior de la página.
3. Seleccione la configuración de inicio informada y elija Acciones, luego haga clic en 'Eliminar configuración de inicio'.
4. Haga clic en el botón 'Eliminar' para eliminar la configuración de inicio del grupo de escalado automático.

NOTA: Asegúrese de tomar las precauciones adecuadas antes de imponer el uso de IMDSv2, ya que las aplicaciones o agentes que usan IMDSv1, por ejemplo, el acceso a metadatos, se interrumpirán
EOT
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc2.csrs_id  # op.acc2 Compliance Section UUID

   }

}




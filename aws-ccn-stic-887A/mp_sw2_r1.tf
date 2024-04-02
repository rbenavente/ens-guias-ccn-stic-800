
resource "prismacloud_policy" "mp_sw2_r1" {
   name = "AWS CodeBuild habilitado en modo privilegiado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica los proyectos de CodeBuild donde está habilitado el modo privilegiado. El modo privilegiado otorga acceso sin restricciones a todos los dispositivos y ejecuta el demonio Docker dentro del contenedor. Se recomienda habilitar este modo solo para crear imágenes de Docker. Recomendó deshabilitar el modo privilegiado para evitar el acceso no deseado a las API de Docker y al hardware del contenedor, reduciendo el riesgo de posible manipulación o eliminación de recursos críticos.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS CodeBuild habilitado en modo privilegiado"
        criteria = "config from cloud.resource where api.name = 'aws-code-build-project' AND json.rule = environment.privilegedMode exists and environment.privilegedMode is true"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para deshabilitar el modo Privilegiado para el proyecto CodeBuild:

1. Inicie sesión en la Consola de administración de AWS.
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha para la cual se genera la alerta.
3. Navegue hasta 'Herramientas de desarrollador' en el menú desplegable 'Servicios' y seleccione 'CodeBuild'.
4. En el panel de navegación, elija 'Crear proyectos'.
5. Seleccione el proyecto de compilación informado y elija Editar, luego haga clic en "Entorno".
6. En la página Editar entorno, expanda la configuración haciendo clic en el botón 'Anular imagen'.
7. Desmarque la casilla de verificación "Habilite esta marca si desea crear imágenes de Docker o desea que sus compilaciones obtengan privilegios elevados". en la sección 'Privilegiados'.
8. Cuando haya terminado de cambiar la configuración del entorno de CodeBuild, haga clic en "Actualizar entorno".
EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsw2.csrs_id # mp.sw2 Compliance Section UUID

  }
 
}




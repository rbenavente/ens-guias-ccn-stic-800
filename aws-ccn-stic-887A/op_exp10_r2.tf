
resource "prismacloud_policy" "op_exp10_r2" {
   name = "Clúster AWS EMR no configurado con CSE CMK para el cifrado de datos en reposo (Amazon S3 con EMRFS)"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los clústeres de EMR que no están configurados con cifrado del lado del cliente con claves maestras del cliente (CSE CMK) para el cifrado de datos en reposo de Amazon S3 con EMRFS. Como práctica recomendada, utilice claves maestras de cliente (CMK) para cifrar los datos en su clúster EMR y garantizar un control total sobre sus datos.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Clúster  AWS EMR no configurado con CSE CMK para el cifrado de datos en reposo (Amazon S3 con EMRFS)"
        criteria = "config from cloud.resource where api.name = 'aws-emr-describe-cluster' as X; config from cloud.resource where api.name = 'aws-emr-security-configuration' as Y; filter '($.X.status.state does not contain TERMINATING) and ($.X.securityConfiguration contains $.Y.name) and ($.Y.EncryptionConfiguration.EnableAtRestEncryption is true) and ($.Y.EncryptionConfiguration.AtRestEncryptionConfiguration.S3EncryptionConfiguration exists) and ($.Y.EncryptionConfiguration.AtRestEncryptionConfiguration.S3EncryptionConfiguration.EncryptionMode contains CSE) and ($.Y.EncryptionConfiguration.AtRestEncryptionConfiguration.S3EncryptionConfiguration.EncryptionMode does not contain Custom)' ; show X; "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue al panel 'EMR' desde el menú desplegable 'Servicios'
4. Vaya a 'Configuraciones de seguridad', haga clic en 'Crear'
5. En la ventana Crear configuración de seguridad,
6. En el cuadro 'Nombre', proporcione un nombre para la nueva configuración de seguridad de EMR.
7. Para cifrado en reposo, haga clic en la casilla de verificación "Habilitar cifrado en reposo para datos EMRFS en Amazon S3".
8. En el menú desplegable "Modo de cifrado predeterminado", seleccione "CSE-Personalizado". Siga el enlace a continuación para conocer los pasos de configuración.
https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-encryption-enable.html
9. Haga clic en el botón 'Crear'
10. En el menú de la izquierda del panel de EMR, haga clic en "Clústeres".
11. Seleccione el clúster de EMR para el cual se generó la alerta y haga clic en el botón 'Clonar' en el menú superior.
12. En la ventana emergente Clonación, elija "Sí" y haga clic en "Clonar".
13. En la página Crear clúster, en la sección Opciones de seguridad, haga clic en 'configuración de seguridad'
14. En el menú desplegable 'Configuración de seguridad', seleccione el nombre de la configuración de seguridad creada en el paso 4 al paso 8, haga clic en 'Crear clúster'.
15. Una vez que haya configurado el nuevo clúster, verifique su funcionamiento y finalice el clúster de origen para dejar de incurrir en cargos por él.
16. En el menú de la izquierda del panel de EMR, haga clic en 'Clústeres', de la lista de clústeres seleccione el clúster de origen que recibe la alerta.
17. Haga clic en el botón 'Terminar' en el menú superior.
18. En la ventana emergente 'Terminar clústeres', haga clic en 'Terminar'.
​

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}




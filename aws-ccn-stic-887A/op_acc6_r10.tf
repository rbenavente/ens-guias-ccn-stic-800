resource "prismacloud_policy" "op_acc6_r10" {
   name = "Cuenta root de AWS configurada con Virtual MFA"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica las cuentas raíz de AWS que están configuradas con Virtual MFA. La raíz es una función importante en su cuenta y las cuentas raíz deben configurarse con hardware MFA. Hardware MFA agrega seguridad adicional porque requiere que los usuarios escriban un código de autenticación único desde un dispositivo de autenticación aprobado cuando acceden a sitios web o servicios de AWS.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS MFA no esta activo para los usuarios de acceso"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-iam-list-virtual-mfa-devices' AND json.rule = 'serialNumber contains root-account-mfa-device and user.arn contains root'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para administrar dispositivos MFA para su cuenta de AWS, debe utilizar sus credenciales de usuario raíz para iniciar sesión en AWS. No puede administrar dispositivos MFA para el usuario raíz mientras haya iniciado sesión con otras credenciales.

1. Inicie sesión en AWS Management Console con sus credenciales de usuario raíz.
2. Ir a IAM
3. Realice una de las siguientes acciones:
Opción 1: elija Panel y, en Estado de seguridad, expanda Activar MFA en su cuenta raíz.
Opción 2: en el lado derecho de la barra de navegación, seleccione el nombre de su cuenta y luego elija Mis credenciales de seguridad. Si es necesario, elija Continuar con Credenciales de seguridad. Luego expanda la sección Autenticación multifactor (MFA) en la página.
4. Elija Administrar MFA o Activar MFA, según la opción que eligió en el paso anterior.
5. En el asistente, elija Un dispositivo MFA de hardware y luego elija Siguiente paso.
6. Si tiene una clave de seguridad U2F como dispositivo MFA de hardware, elija la clave de seguridad U2F y haga clic en Continuar. Luego conecte la llave de seguridad USB U2F, cuando se complete la configuración, haga clic en Cerrar.
Si tiene algún otro dispositivo MFA de hardware, elija la opción Otro dispositivo MFA de hardware
a. En el cuadro Número de serie, escriba el número de serie que se encuentra en la parte posterior del dispositivo MFA.
b. En el cuadro Código de autenticación 1, escriba el número de seis dígitos que muestra el dispositivo MFA. Es posible que tengas que presionar el botón en la parte frontal del dispositivo para mostrar el número.
C. Espere 30 segundos mientras el dispositivo actualiza el código y luego escriba el siguiente número de seis dígitos en el cuadro Código de autenticación 2. Es posible que tengas que presionar nuevamente el botón en la parte frontal del dispositivo para mostrar el segundo número.
d. Elija el siguiente paso. El dispositivo MFA ahora está asociado con la cuenta de AWS.

Importante:
Envíe su solicitud inmediatamente después de generar los códigos de autenticación. Si genera los códigos y luego espera demasiado para enviar la solicitud, el dispositivo MFA se asocia exitosamente con el usuario, pero el dispositivo MFA no está sincronizado. Esto sucede porque las contraseñas de un solo uso basadas en el tiempo (TOTP) caducan después de un corto período de tiempo. Si esto sucede, puedes resincronizar el dispositivo.

EOT
   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}




resource "prismacloud_policy" "op_mon2_r2" {
   name = "Azure Monitor no captura todas las actividades"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Esta política identifica los perfiles de registro de Monitor que no están configurados para capturar todas las actividades. Un perfil de registro controla cómo se exporta el registro de actividad. La configuración del perfil de registro para recopilar registros para las categorías 'Escribir', 'Eliminar' y 'Acción' garantiza que todas las actividades del plano de control/administración realizadas en la suscripción se exporten.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Azure Monitor no captura todas las actividades"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-monitor-log-profiles-list' AND json.rule = 'isLegacy is true and (properties.categories[*] does not contain Write or properties.categories[*] does not contain Delete or properties.categories[*] does not contain Action)'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
En Azure Portal, no existe ninguna disposición para verificar o establecer categorías. Sin embargo, cuando se crea un perfil de registro mediante Azure Portal, las categorías Escribir, Eliminar y Acción se configuran de forma predeterminada.

Las actividades del perfil de registro solo se pueden configurar a través de CLI usando la API REST y CLI es:
1. Para enumerar la ejecución del perfil de registro,
lista de perfiles de registro de az monitor

2. Anote el nombre del perfil de registro informado y reemplácelo con <LOG_PROFILE_NAME> en el siguiente comando:
az account get-access-token --query "{suscripción:suscripción,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X GET -H "Autorización: Portador $1" -H "Tipo de contenido: aplicación/json" https://management.azure.com/subscriptions/$0/providers/microsoft.insights/ logprofiles/<LOG_PROFILE_NAME>?api-version=2016-03-01' | jq
Copie la salida JSON y guárdela como archivo 'input.json'.

3. Edite el archivo 'input.json' guardado para agregar todas las actividades 'Escribir', 'Eliminar' y 'Acción' en la sección de matriz JSON de categorías.

4. Ejecute el siguiente comando tomando 'input.json' como archivo de entrada,
az account get-access-token --query "{suscripción:suscripción,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X PUT -H "Autorización: Portador $1" -H "Tipo de contenido: aplicación/json" https://management.azure.com/subscriptions/$0/providers/microsoft.insights/ logprofiles/<LOG_PROFILE_NAME>?api-version=2016-03-01 -d@"input.json"'

NOTA: Para ejecutar todas las CLI anteriores, debe estar configurado con una suscripción de Azure y un token de acceso localmente. Y estos comandos CLI requieren el permiso 'microsoft.insights/logprofiles/*'.

EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opmon2.csrs_id # op.mon2 Compliance Section UUID

   }

}




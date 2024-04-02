resource "prismacloud_policy" "op_acc2_r4" {
   name = "Puertos administrativos no permitidos sin JIT (SMB)"
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
Esta política identifica puertos administrativos permitidos sin JIT
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Puertos administrativos no permitidos sin JIT (SMB)"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name= 'azure-network-nsg-list' AND json.rule = (securityRules[?any(access equals Allow and direction equals Inbound and name does not contain \"SecurityCenter-JITRule\" and (sourceAddressPrefix equals Internet or sourceAddressPrefix equals * or sourceAddressPrefix equals 0.0.0.0/0 or sourceAddressPrefix equals ::/0) and (destinationPortRange contains _Port.inRange(445,445) or destinationPortRanges[*] contains _Port.inRange(445,445) or destinationPortRanges[*] contains * or destinationPortRange contains *))] exists) and (id does not contain \"-managed/\" and id does not contain \"-mg/\")"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Cerrar el acceso al puerto o utilizar la opcion JIT (Just-In-Time).
No se permitira la exposición de ningun puerto administrativo de las VMs en Internet (ni de gestion de la VM ni de los servicios desplegados en la misma, salvo que el servicio sea publico). 
Los puertos administrativos de las VMs deben estar protegidos con el control de acceso JIT (Just-In-Time)."
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc2.csrs_id # op.acc2 Compliance Section UUID

   }

}




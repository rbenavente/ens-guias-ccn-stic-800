
resource "prismacloud_policy" "mp_si2_r1" {
   name = "Volumen AWS EBS con cifrado deshabilitado a nivel de región"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica las regiones de AWS en las que se crean nuevos volúmenes de EBS sin ningún cifrado. El cifrado de datos en reposo reduce la exposición involuntaria de los datos almacenados en volúmenes de EBS. Se recomienda configurar el volumen de EBS a nivel regional para que cada nuevo volumen de EBS creado en esa región esté habilitado con cifrado mediante el uso de una clave de cifrado proporcionada.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Volumen AWS EBS con cifrado deshabilitada a nivel de región"
        criteria = "config from cloud.resource where api.name = 'aws-ec2-ebs-encryption' AND json.rule = ebsEncryptionByDefault is false as X; config from cloud.resource where api.name = 'aws-region' AND json.rule = optInStatus does not equal not-opted-in as Y; filter '$.X.region equals $.Y.regionName'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para habilitar el cifrado a nivel de región de forma predeterminada, siga la siguiente URL:
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#encryption-by-default

Información adicional:

Para detectar volúmenes de EBS existentes que no estén cifrados; consulte Búsqueda guardada:
Los volúmenes de AWS EBS no están cifrados_RL

Para detectar volúmenes de EBS existentes que no están cifrados con CMK, consulte Búsqueda guardada:
El volumen de AWS EBS no está cifrado con la clave administrada por el cliente_RL
EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}




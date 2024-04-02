resource "prismacloud_policy" "mp_com3_r1" {
   name = "Política de negociación SSL en AWS Elastic Load Balancer (clásico) con cifrados inseguros"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica los Elastic Load Balancers (clásicos) que están configurados con una política de negociación SSL que contiene cifrados inseguros. Un cifrado SSL es un algoritmo de cifrado que utiliza claves de cifrado para crear un mensaje codificado. Los protocolos SSL utilizan varios cifrados SSL para cifrar datos a través de Internet. Como muchos de los otros cifrados no son seguros, se recomienda utilizar únicamente los cifrados recomendados en el siguiente enlace de AWS: https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-ssl-security-policy .html.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de negociación SSL en AWS Elastic Load Balancer (clásico) con cifrados inseguros"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-elb-describe-load-balancers' AND json.rule = \"policies[*].policyAttributeDescriptions[?(@.attributeName=='DHE-RSA-AES128-SHA'|| @.attributeName=='DHE-DSS-AES128-SHA' || @.attributeName=='CAMELLIA128-SHA' || @.attributeName=='EDH-RSA-DES-CBC3-SHA' || @.attributeName=='DES-CBC3-SHA' || @.attributeName=='ECDHE-RSA-RC4-SHA' || @.attributeName=='RC4-SHA' || @.attributeName=='ECDHE-ECDSA-RC4-SHA' || @.attributeName=='DHE-DSS-AES256-GCM-SHA384' || @.attributeName=='DHE-RSA-AES256-GCM-SHA384' || @.attributeName=='DHE-RSA-AES256-SHA256' || @.attributeName=='DHE-DSS-AES256-SHA256' || @.attributeName=='DHE-RSA-AES256-SHA' || @.attributeName=='DHE-DSS-AES256-SHA' || @.attributeName=='DHE-RSA-CAMELLIA256-SHA' || @.attributeName=='DHE-DSS-CAMELLIA256-SHA' || @.attributeName=='CAMELLIA256-SHA' || @.attributeName=='EDH-DSS-DES-CBC3-SHA' || @.attributeName=='DHE-DSS-AES128-GCM-SHA256' || @.attributeName=='DHE-RSA-AES128-GCM-SHA256' || @.attributeName=='DHE-RSA-AES128-SHA256' || @.attributeName=='DHE-DSS-AES128-SHA256' || @.attributeName=='DHE-RSA-CAMELLIA128-SHA' || @.attributeName=='DHE-DSS-CAMELLIA128-SHA' || @.attributeName=='ADH-AES128-GCM-SHA256' || @.attributeName=='ADH-AES128-SHA' || @.attributeName=='ADH-AES128-SHA256' || @.attributeName=='ADH-AES256-GCM-SHA384' || @.attributeName=='ADH-AES256-SHA' || @.attributeName=='ADH-AES256-SHA256' || @.attributeName=='ADH-CAMELLIA128-SHA' || @.attributeName=='ADH-CAMELLIA256-SHA' || @.attributeName=='ADH-DES-CBC3-SHA' || @.attributeName=='ADH-DES-CBC-SHA' || @.attributeName=='ADH-RC4-MD5' || @.attributeName=='ADH-SEED-SHA' || @.attributeName=='DES-CBC-SHA' || @.attributeName=='DHE-DSS-SEED-SHA' || @.attributeName=='DHE-RSA-SEED-SHA' || @.attributeName=='EDH-DSS-DES-CBC-SHA' || @.attributeName=='EDH-RSA-DES-CBC-SHA' || @.attributeName=='IDEA-CBC-SHA' || @.attributeName=='RC4-MD5' || @.attributeName=='SEED-SHA' || @.attributeName=='DES-CBC3-MD5' || @.attributeName=='DES-CBC-MD5' || @.attributeName=='RC2-CBC-MD5' || @.attributeName=='PSK-AES256-CBC-SHA' || @.attributeName=='PSK-3DES-EDE-CBC-SHA' || @.attributeName=='KRB5-DES-CBC3-SHA' || @.attributeName=='KRB5-DES-CBC3-MD5' || @.attributeName=='PSK-AES128-CBC-SHA' || @.attributeName=='PSK-RC4-SHA' || @.attributeName=='KRB5-RC4-SHA' || @.attributeName=='KRB5-RC4-MD5' || @.attributeName=='KRB5-DES-CBC-SHA' || @.attributeName=='KRB5-DES-CBC-MD5' || @.attributeName=='EXP-EDH-RSA-DES-CBC-SHA' || @.attributeName=='EXP-EDH-DSS-DES-CBC-SHA' || @.attributeName=='EXP-ADH-DES-CBC-SHA' || @.attributeName=='EXP-DES-CBC-SHA' || @.attributeName=='EXP-RC2-CBC-MD5' || @.attributeName=='EXP-KRB5-RC2-CBC-SHA' || @.attributeName=='EXP-KRB5-DES-CBC-SHA' || @.attributeName=='EXP-KRB5-RC2-CBC-MD5' || @.attributeName=='EXP-KRB5-DES-CBC-MD5' || @.attributeName=='EXP-ADH-RC4-MD5' || @.attributeName=='EXP-RC4-MD5' || @.attributeName=='EXP-KRB5-RC4-SHA' || @.attributeName=='EXP-KRB5-RC4-MD5')].attributeValue equals true\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Vaya al Panel de EC2 y seleccione 'Equilibradores de carga'
4. Haga clic en el balanceador de carga informado.
5. En la pestaña 'Oyentes', cambie el cifrado de la regla 'HTTPS/SSL'
Para una 'Política de seguridad predefinida', cambie 'Cifrado' a 'ELBSecurityPolicy-TLS‌-1-2-2017-01' o la última versión
Para una 'Política de seguridad personalizada', seleccione entre los cifrados seguros como se recomienda en el siguiente enlace de AWS:
https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-ssl-security-policy.html
6. 'Guarda' tus cambios

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom3.csrs_id # mp.com3 Compliance Section UUID

   }

}




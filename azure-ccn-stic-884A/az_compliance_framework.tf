
resource "prismacloud_compliance_standard" "ens_azure" {
    name = "ENS Azure - CCN-STIC 884A"
    description = "Esquema Nacional de Seguridad - Guia de configuración Segura para Azure CCN STIC 884A"
}

# op.acc Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_opacc" {
   cs_id = prismacloud_compliance_standard.ens_azure.cs_id
   name = "Marco Operacional - Control de Acceso"
   requirement_id = "op.acc"
}

resource "prismacloud_compliance_standard_requirement_section" "opacc1" {
    csr_id = prismacloud_compliance_standard_requirement.req_opacc.csr_id
    section_id = "op.acc.1"
    description = "Identificación"
}

resource "prismacloud_compliance_standard_requirement_section" "opacc2" {
    csr_id = prismacloud_compliance_standard_requirement.req_opacc.csr_id
    section_id = "op.acc.2"
    description = "Requisitos de Acceso"
}

resource "prismacloud_compliance_standard_requirement_section" "opacc3" {
    csr_id = prismacloud_compliance_standard_requirement.req_opacc.csr_id
    section_id = "op.acc.3"
    description = "Segregación de funciones y tareas"
}

resource "prismacloud_compliance_standard_requirement_section" "opacc4" {
    csr_id = prismacloud_compliance_standard_requirement.req_opacc.csr_id
    section_id = "op.acc.4"
    description = "Proceso de gestión de derechos de acceso"
}

resource "prismacloud_compliance_standard_requirement_section" "opacc5" {
    csr_id = prismacloud_compliance_standard_requirement.req_opacc.csr_id
    section_id = "op.acc.5"
    description = "Mecanismo de autenticación (usuarios de la organización"
}
resource "prismacloud_compliance_standard_requirement_section" "opacc6" {
    csr_id = prismacloud_compliance_standard_requirement.req_opacc.csr_id
    section_id = "op.acc.6"
    description = "Acceso local"
}
resource "prismacloud_compliance_standard_requirement_section" "opacc7" {
    csr_id = prismacloud_compliance_standard_requirement.req_opacc.csr_id
    section_id = "op.acc.7"
    description = "Acceso remoto"
}
# op.exp Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_opexp" {
   cs_id = prismacloud_compliance_standard.ens_azure.cs_id
   name = "Marco Operacional - Explotacion"
   requirement_id = "op.exp"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp8" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.8"
    description = "Registro de actividad de los usuarios"
}
resource "prismacloud_compliance_standard_requirement_section" "opexp10" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.10"
    description = "Protección de los registros de actividad"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp11" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.11"
    description = "Protección de claves criptográficas"
}

# op.cont Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_opcont" {
   cs_id = prismacloud_compliance_standard.ens_azure.cs_id
   name = "Marco Operacional - Continuidad del Servicio"
   requirement_id = "op.cont"
}

resource "prismacloud_compliance_standard_requirement_section" "opcont2" {
    csr_id = prismacloud_compliance_standard_requirement.req_opcont.csr_id
    section_id = "op.cont.2"
    description = "Plan de Continuidad"
}

resource "prismacloud_compliance_standard_requirement_section" "opcont3" {
    csr_id = prismacloud_compliance_standard_requirement.req_opcont.csr_id
    section_id = "op.cont.3"
    description = "Pruebas periódicas"
}

# op.mon Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_opmon" {
   cs_id = prismacloud_compliance_standard.ens_azure.cs_id
   name = "Marco Operacional - Monitorización del sistema"
   requirement_id = "op.mon"
}

resource "prismacloud_compliance_standard_requirement_section" "opmon1" {
    csr_id = prismacloud_compliance_standard_requirement.req_opmon.csr_id
    section_id = "op.mon.1"
    description = "Detección de intrusión"
}

resource "prismacloud_compliance_standard_requirement_section" "opmon2" {
    csr_id = prismacloud_compliance_standard_requirement.req_opmon.csr_id
    section_id = "op.mon.2"
    description = "Sistema de métricas"
}

# mp.com Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_mpcom" {
   cs_id = prismacloud_compliance_standard.ens_azure.cs_id
   name = "Medidas de Protección - Protección de las comunicaciones"
   requirement_id = "mp.com"
}

resource "prismacloud_compliance_standard_requirement_section" "mpcom1" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpcom.csr_id
    section_id = "mp.com.1"
    description = "Perímetro seguro"
}

resource "prismacloud_compliance_standard_requirement_section" "mpcom2" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpcom.csr_id
    section_id = "mp.com.2"
    description = "Protección de la confidencialidad"
}

resource "prismacloud_compliance_standard_requirement_section" "mpcom3" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpcom.csr_id
    section_id = "mp.com.3"
    description = "Protección  de la integridad y de la autenticidad"
}

resource "prismacloud_compliance_standard_requirement_section" "mpcom4" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpcom.csr_id
    section_id = "mp.com.4"
    description = "Segregación de redes"
}


# mp.si Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_mpsi" {
   cs_id = prismacloud_compliance_standard.ens_azure.cs_id
   name = "Medidas de Protección - Protección de los soportes de información"
   requirement_id = "mp.si"
}
resource "prismacloud_compliance_standard_requirement_section" "mpsi1" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpsi.csr_id
    section_id = "mp.si.1"
    description = "Etiquetado"
}
resource "prismacloud_compliance_standard_requirement_section" "mpsi2" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpsi.csr_id
    section_id = "mp.si.2"
    description = "Criptografía"
}
 
 resource "prismacloud_compliance_standard_requirement_section" "mpsi5" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpsi.csr_id
    section_id = "mp.si.5"
    description = "Borrado y destrucción"
}

# mp.info Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_mpinfo" {
   cs_id = prismacloud_compliance_standard.ens_azure.cs_id
   name = "Medidas de Protección - Protección de la Información"
   requirement_id = "mp.info"
}
resource "prismacloud_compliance_standard_requirement_section" "mpinfo2" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpinfo.csr_id
    section_id = "mp.info.2"
    description = "Calificación de la información"
}
resource "prismacloud_compliance_standard_requirement_section" "mpinfo3" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpinfo.csr_id
    section_id = "mp.info.3"
    description = "Cifrado"
}
resource "prismacloud_compliance_standard_requirement_section" "mpinfo9" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpinfo.csr_id
    section_id = "mp.info.9"
    description = "Copias de seguridad"
}

# mp.s Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_mps" {
   cs_id = prismacloud_compliance_standard.ens_azure.cs_id
   name = "Medidas de Protección - Protección de los servicios"
   requirement_id = "mp.s"
}


resource "prismacloud_compliance_standard_requirement_section" "mps2" {
    csr_id = prismacloud_compliance_standard_requirement.req_mps.csr_id
    section_id = "mp.s.2"
    description = "Protección de servicios y aplicaciones web"
}

resource "prismacloud_compliance_standard_requirement_section" "mps8" {
    csr_id = prismacloud_compliance_standard_requirement.req_mps.csr_id
    section_id = "mp.s.8"
    description = "Protección frente a la denegación de servicio"
}










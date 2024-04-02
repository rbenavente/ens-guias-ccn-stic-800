
resource "prismacloud_compliance_standard" "ens_aws" {
    name = "ENS AWS-CCN STIC 887A"
    description = "Esquema Nacional de Seguridad - Guia de configuración Segura para AWS CCN STIC 887A"
}
# mp.si Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_mpsi" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
   name = "Medidas de Protección - Protección de los soportes de información"
   requirement_id = "mp.si"
}

resource "prismacloud_compliance_standard_requirement_section" "mpsi2" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpsi.csr_id
    section_id = "mp.si.2"
    description = "Criptografía"
}
 
# mp.s Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_mps" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
   name = "Medidas de Protección - Protección de los servicios"
   requirement_id = "mp.s"
}

resource "prismacloud_compliance_standard_requirement_section" "mps1" {
    csr_id = prismacloud_compliance_standard_requirement.req_mps.csr_id
    section_id = "mp.s.1"
    description = "Protección del correo electrónico"
}

resource "prismacloud_compliance_standard_requirement_section" "mps2" {
    csr_id = prismacloud_compliance_standard_requirement.req_mps.csr_id
    section_id = "mp.s.2"
    description = "Protección de servicios y aplicaciones web"
}

resource "prismacloud_compliance_standard_requirement_section" "mps3" {
    csr_id = prismacloud_compliance_standard_requirement.req_mps.csr_id
    section_id = "mp.s.3"
    description = "Protección frente a la denegación de servicio"
}

# mp.com Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_mpcom" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
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
    description = "Separación de flujos de información en la red"
}

# mp.sw Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_mpsw" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
   name = "Medidas de Protección - Protección de las aplicaciones informáticas"
   requirement_id = "mp.sw"
}

resource "prismacloud_compliance_standard_requirement_section" "mpsw2" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpsw.csr_id
    section_id = "mp.sw.2"
    description = "Aceptación y puesta en servicio"
}

# mp.info Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_mpinfo" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
   name = "Medidas de Protección - Protección de la Información"
   requirement_id = "mp.info"
}

resource "prismacloud_compliance_standard_requirement_section" "mpinfo6" {
    csr_id = prismacloud_compliance_standard_requirement.req_mpinfo.csr_id
    section_id = "mp.info.6"
    description = "Copias de seguridad"
}

# op.ext  Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_opext" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
   name = "Marco Operacional - Recursos Externos"
   requirement_id = "op.ext"
}

resource "prismacloud_compliance_standard_requirement_section" "opext1" {
    csr_id = prismacloud_compliance_standard_requirement.req_opext.csr_id
    section_id = "op.ext.1"
    description = "Contratación y acuerdos a nivel de servicio"
}

resource "prismacloud_compliance_standard_requirement_section" "opext2" {
    csr_id = prismacloud_compliance_standard_requirement.req_opext.csr_id
    section_id = "op.ext.2"
    description = "Gestión diaria"
}

# op.pl Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_oppl" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
   name = "Marco Operacional - Planficacion"
   requirement_id = "op.pl"
}

resource "prismacloud_compliance_standard_requirement_section" "oppl2" {
    csr_id = prismacloud_compliance_standard_requirement.req_oppl.csr_id
    section_id = "op.pl.2"
    description = "Arquitectura de Seguridad"
}

resource "prismacloud_compliance_standard_requirement_section" "oppl4" {
    csr_id = prismacloud_compliance_standard_requirement.req_oppl.csr_id
    section_id = "op.pl.4"
    description = "Necesidades de procesamiento"
}

# op.mon Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_opmon" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
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

resource "prismacloud_compliance_standard_requirement_section" "opmon3" {
    csr_id = prismacloud_compliance_standard_requirement.req_opmon.csr_id
    section_id = "op.mon.3"
    description = "Vigilancia"
}

# op.exp Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_opexp" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
   name = "Marco Operacional - Explotacion"
   requirement_id = "op.exp"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp1" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.1"
    description = "Inventario de activos"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp10" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.10"
    description = "Protección de claves criptográficas"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp3" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.3"
    description = "Gestión de la configuración de seguridad"
}
resource "prismacloud_compliance_standard_requirement_section" "opexp4" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.4"
    description = "Mantenimiento y actualizaciones de seguridad"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp5" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.5"
    description = "Gestión de cambios"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp6" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.6"
    description = "Protección frente a código dañino"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp7" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.7"
    description = "Gestión de incidentes"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp8" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.8"
    description = "Registro de actividad"
}

resource "prismacloud_compliance_standard_requirement_section" "opexp9" {
    csr_id = prismacloud_compliance_standard_requirement.req_opexp.csr_id
    section_id = "op.exp.9"
    description = "Registro de la gestión de incidentes"
}

# op.acc Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_opacc" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
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

resource "prismacloud_compliance_standard_requirement_section" "opacc6" {
    csr_id = prismacloud_compliance_standard_requirement.req_opacc.csr_id
    section_id = "op.acc.6"
    description = "Mecanismo de autenticación (usuarios de la organización"
}

# op.cont Req y secciones

resource "prismacloud_compliance_standard_requirement" "req_opcont" {
   cs_id = prismacloud_compliance_standard.ens_aws.cs_id
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

resource "prismacloud_compliance_standard_requirement_section" "opcont4" {
    csr_id = prismacloud_compliance_standard_requirement.req_opcont.csr_id
    section_id = "op.cont.4"
    description = "Medios alternativos"
}

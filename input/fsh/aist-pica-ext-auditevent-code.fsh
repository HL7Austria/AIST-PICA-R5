/*##############################################################################
# Type:       FSH-File for an FHIR® Extension
# About:      Extension for the code of an audit event.
# Created by: AIST 
##############################################################################*/

Extension:    AISTPICAExtAuditeventCode
Id:           aist-pica-auditevent-ext-code
Title:        "Auditevent Code" 
Description:  "Code documented in a machine readable way in the AuditEvents. The codes refer to a value-set defining a standardized log of operational events."

* value[x] only CodeableConcept
* value[x] ^short = "Code identifying the action taking place in the audit event."
* value[x] 1..1
* extension 0..0

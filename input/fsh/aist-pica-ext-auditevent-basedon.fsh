/*##############################################################################
# Type:       FSH-File for an FHIR® Extension
# About:      Extension for the code of an audit event.
# Created by: AIST 
##############################################################################*/

Extension:    AISTPICAExtAuditeventBasedOn
Id:           aist-pica-auditevent-ext-basedon
Title:        "Auditevent BasedOn" 
Description:  "BasedOn documenting the process that the patient followed."

* value[x] only Reference(CarePlan)
* value[x] ^short = "CarePlan that was followed when treating the patient."
* value[x] 1..1
* extension 0..0

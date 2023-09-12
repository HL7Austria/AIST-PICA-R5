/*##############################################################################
# Type:       FSH-File for an FHIR® Extension
# About:      Extension for the code of an audit event.
# Created by: AIST 
##############################################################################*/

Extension:    AISTPICAExtAuditeventEncounter
Id:           aist-pica-auditevent-ext-encounter
Title:        "Auditevent Encounter" 
Description:  "Encounter documenting the patient pathway in a process."

* value[x] only Reference(Encounter)
* value[x] ^short = "Encounter that happened."
* value[x] 1..1
* extension 0..0

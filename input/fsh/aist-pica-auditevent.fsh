/*##############################################################################
# Type:       FSH-File for a FHIR® Profile
# About:      AIST PICA Core Profile for AuditEvent.
# Created by: AIST
##############################################################################*/

Profile:        AISTPICAAuditEventCore
Parent:         AuditEvent
Id:             aist-pica-auditevent-core
Title:          "AIST PICA Core AuditEvent Profile"
Description:    "AIST PICA Core AuditEvent Profile enforcing the patient and event time"

// Define Mandatory Fields (ae.entity.what and occured)
* entity 1..*
* entity ^short = "At least one entity must refer to the patient."
* entity ^slicing.rules = #open
* entity ^slicing.ordered = false
* entity ^slicing.description = "At least one entity must refer to the patient"
* entity contains patient 1..1
* entity[patient].what only Reference(Patient)
* entity[patient].what 1..1
* entity[patient].what ^short = "The patient this Audit event is for."
* period 1..1
* period ^short = "Documents when the event was conducted, not when it was audited."


Profile:        AISTPICAAuditEventConformance
Parent:         AISTPICAAuditEventCore
Id:             aist-pica-auditevent-conformance
Title:          "AIST PICA Conformance AuditEvent Profile"
Description:    "AIST PICA Conformance AuditEvent Profile enforcing the code value"

// Define Mandatory Fields (ae.code) as extension
* extension contains AISTPICAExtAuditeventCode named code 1..1
* extension[code] ^short = "Code identifying task in process. It is recommended to extend this profile and require a value-set."


Profile:        AISTPICAAuditEventPatientVisit
Parent:         AISTPICAAuditEventCore
Id:             aist-pica-auditevent-patientvisit
Title:          "AIST PICA Patient Visit AuditEvent Profile"
Description:    "AIST PICA Patient Visit AuditEvent Profile enforcing the encounter"

// Define Mandatory Fields (ae.encounter) as extension
* extension contains AISTPICAExtAuditeventEncounter named encounter 1..1
* extension[encounter] ^short = "Encounter of a patient with a care provider."

Profile:        AISTPICAAuditEventCarePathway
Parent:         AISTPICAAuditEventCore
Id:             aist-pica-auditevent-carepathway
Title:          "AIST PICA Care Pathway AuditEvent Profile"
Description:    "AIST PICA Care Pathway AuditEvent Profile enforcing the care plan"

// Define Mandatory Fields (ae.basedOn contains at least one CarePlan)
* extension contains AISTPICAExtAuditeventBasedOn named basedOn 1..1
* extension[basedOn] ^short = "Process that was followed in the treatment of this patient."


Profile:        AISTPICAAuditEventActor
Parent:         AISTPICAAuditEventCore
Id:             aist-pica-auditevent-actor
Title:          "AIST PICA Actor AuditEvent Profile"
Description:    "AIST PICA Actor AuditEvent Profile enforcing the participating actor(s)"

// Define Mandatory Fields (ae.agent)
* agent 1..*
* agent.who 1..1
* agent.who ^short = "Actor that participated in the task."
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

// Define Mandatory Fields (ae.patient and occured)
* patient 1..1 
* patient ^short = "The patient this Audit event is for."
* occurredDateTime 1..1
* occurredDateTime ^short = "Documents when the event was conducted, not when it was audited."

Profile:        AISTPICAAuditEventConformance
Parent:         AISTPICAAuditEventCore
Id:             aist-pica-auditevent-conformance
Title:          "AIST PICA Conformance AuditEvent Profile"
Description:    "AIST PICA Conformance AuditEvent Profile enforcing the code value"

// Define Mandatory Fields (ae.code)
* code 1..1
* code ^short = "Code identifying task in process. It is recommended to extend this profile and require a value-set."

Profile:        AISTPICAAuditEventPatientVisit
Parent:         AISTPICAAuditEventCore
Id:             aist-pica-auditevent-patientvisit
Title:          "AIST PICA Patient Visit AuditEvent Profile"
Description:    "AIST PICA Patient Visit AuditEvent Profile enforcing the encounter"

// Define Mandatory Fields (ae.encounter)
* encounter 1..1
* encounter ^short = "Encounter between the patient and a care provider."


Profile:        AISTPICAAuditEventCarePathway
Parent:         AISTPICAAuditEventCore
Id:             aist-pica-auditevent-carepathway
Title:          "AIST PICA Care Pathway AuditEvent Profile"
Description:    "AIST PICA Care Pathway AuditEvent Profile enforcing the care plan"

// Define Mandatory Fields (ae.basedOn contains at least one CarePlan)
* basedOn 1..*
* basedOn ^short = "Reference to care plan identifying the process to be conformance checked."
* basedOn ^slicing.rules = #open
* basedOn ^slicing.ordered = false
* basedOn ^slicing.description = "At least one care plan must be referenced"
* basedOn contains carePlan 1..*
* basedOn[carePlan] only Reference(CarePlan)


Profile:        AISTPICAAuditEventActor
Parent:         AISTPICAAuditEventCore
Id:             aist-pica-auditevent-actor
Title:          "AIST PICA Actor AuditEvent Profile"
Description:    "AIST PICA Actor AuditEvent Profile enforcing the participating actor(s)"

// Define Mandatory Fields (ae.agent is already required)
* agent 1..*
* agent.who ^short = "Actor that participated in the task."
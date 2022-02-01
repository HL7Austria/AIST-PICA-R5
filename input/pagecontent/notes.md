### Process Mining Fitness Levels

| Level | Description                                                                                                                                                   | Outcome                                                                               |
|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|
| core     | AuditEvent resources are created on server and refer to a Patient resource via ae.entity (see https://build.fhir.org/auditevent.html#patient)                 | We can mine process(es) for one patient                                               |
|  patient-visit (encounter)  | ae.encounter exists. It refers to a patient visit grouping multiple AuditEvents | We can mine a specific process OR  all processes during one encounter (hospital stay) |
| care-pathway (based-on) | ae.basedOn exists. It refers to a workflow grouping multiple AuditEvents | We can mine a specific process OR  all processes during one encounter (hospital stay) |
| conformance     | ae.code has at least one coding, that refers to a value-set defining a standardized log of operational events (e.g. http://radlex.org/RID/RID45812)           | We can mine only relevant activities, and know what those activities ar               |
| multi-perspective     | ae.agents lists all agents that participated in that process step.                                                                                            | We can mine the process from multiple perspectives of actors in them                  |
| 
**What is PICA?**

PICA is an implementation guide that details how the *conformance* of processes conducted in a medical setting can be validated compared to an existing guideline or process description. It does so by providing guidance on how to do correct logging via the FHIR® AuditEvent resource. The IG also provides guidance on how to conduct performance auditing based on this log with tools from the process mining domain, and including this in existing software architectures.

**What isn't PICA?**

PICA does **not** deal with mining processes, or enriching existing audit logs.

## Architecture

PICA can be applied to any FHIR® based audit logging. It is aligned with concepts from the [IHE RESTful Audit Trail and Node Authentication (RATNA)](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf) profile.

To be applicable as an addition in existing infrastructures, it is recommended to implement PICA as an *Event Repository*. An example for this, specific to the radiology domain, is outlined in [IHE Standardized Operational Log of Events (SOLE)](https://www.ihe.net/uploadedFiles/Documents/Radiology/IHE_RAD_Suppl_SOLE.pdf) profile. 

The PICA Project hosts a reference implementation of the *Event Repository* in [TODO](aist.science). This is a [HAPI](https://hapifhir.io/) based FHIR® server, supporting all profiles, extensions, and FHIR® Operations this IG has to offer.

## Process Mining Views

The following table shows the possible options PICA can be applied for conformance purposes. Based on the **core**, which is required at all times in a patient centric view, each view can be applied individually or joined with each other.

| View | Description                                                                                                                                                   | Outcome                                                                               |
|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|
| core     | AuditEvent resources are created on server and refer to a Patient resource via ae.entity (see https://build.fhir.org/auditevent.html#patient)                 | We can mine process(es) for a specific patient                                               |
|  patient-visit (encounter)  | ae.encounter exists. It refers to a patient visit grouping multiple AuditEvents | We can analyze the patient pathway during an encounter (hospital stay) |
| care-pathway (based-on) | ae.basedOn exists. It refers to a workflow grouping multiple AuditEvents | We can analyze a specific process |
| conformance     | ae.code has at least one coding, that refers to a value-set defining a standardized log of operational events (e.g. http://radlex.org/RID/RID45812)           | We can mine only relevant activities, and know what those activities are     |
| multi-perspective     | ae.agents lists all agents that participated in that process step.                                                                                            | We can mine the process from multiple perspectives (actors) | 
**What is PICA?**

PICA is an implementation guide that details how the *conformance* of processes conducted in a medical setting can be validated compared to an existing guideline or process description. It does so by providing guidance on how to do correct logging via the FHIR® AuditEvent resource. The IG also provides guidance on how to conduct performance auditing based on this log with tools from the process mining domain, and including this in existing software architectures.

**What isn't PICA?**

PICA does **not** deal with mining processes, or enriching existing audit logs.

### Architecture

PICA can be applied to any FHIR® based audit logging. It is aligned with concepts from the [IHE RESTful Audit Trail and Node Authentication (RATNA)](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf) profile.

To be applicable as an addition in existing infrastructures, it is recommended to implement PICA as an *Audit Record Repository*. An example for this, specific to the radiology domain, is outlined in [IHE Standardized Operational Log of Events (SOLE)](https://www.ihe.net/uploadedFiles/Documents/Radiology/IHE_RAD_Suppl_SOLE.pdf) profile. 

<div><img src="PICA.drawio.png" alt="PICA Architecture in relation to RATNA"></div>

The PICA Project hosts a reference implementation of the *Audit Record Repository* on GitHub [FHOOE-AIST-PICA-Server](https://github.com/FHOOEAIST/pica-hapi-fhir-jpaserver-starter). This is a [HAPI](https://hapifhir.io/) based FHIR® server, supporting all profiles, extensions, and FHIR® Operations this IG has to offer.

### FHIR R4 vs. R5

The PICA Implementation Guides for both FHIR versions are identical, however, since the standard has expanded in R5, several extensions are not necessary anymore. If you are browsing one of the two IG versions, the only difference between them is the Profiles and Extensions necessary to make this work. The remainder of the IG is identical.

### Process Mining Perspectives

The following table shows the possible options PICA can be applied for conformance purposes. Based on the **core**, which is required at all times in a patient centric view, each view can be applied individually or joined with each other. These perspectives are based on the work [Process Mining on FHIR - An Open Standards-Based Process Analytics Approach for Healthcare](https://pods4h.com/wp-content/uploads/2020/10/PODS4H_2020_paper_3.pdf)

ae references the AuditEvent resource in [FHIR R4B](https://hl7.org/fhir/R4B/auditevent.html) or [FHIR R5](https://hl7.org/fhir/auditevent.html) respectively.

| Perspective                | Description                                                                                                                                                                                                      | Outcome                                                                     | R4                                       | R5                                            |
|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|------------------------------------------|-----------------------------------------------|
| core                       | AuditEvent resources are created on server and refer to a Patient resource (see https://build.fhir.org/auditevent.html#patient)                                                                                  | We can mine process(es) for a specific patient                              | ae.entity.what & ae.period | ae.patient & ae.occuredDateTime |
| conformance (code)         | Tasks that were conducted were documented with machine readable codes in the AuditEvents. The codes refer to a value-set defining a standardized log of operational events (e.g. http://radlex.org/RID/RID45812) | We can mine only relevant activities, and know what those activities are    | Extension: PICACode                      | ae.code   
| patient-visit (encounter)  | An Encounter resource is referenced by the AuditEvent. It refers to a patient visit grouping multiple AuditEvents (e.g. one interaction between patient and healthcare provider)                                 | We can analyze the patient pathway during an encounter (e.g. hospital stay) | Extension: PICAEncounter                 | ae.encounter                                  |
| care-pathway (based-on)    | A pathway that was defined or recorded for the patient (CarePlan) was followed and documented in the AuditEvents.                                                                                                | We can analyze a specific process                                           | Extension: PICABasedOn                   | ae.basedOn                                    |                                    |
| actor (agents) | Agents that participated in process steps were identified in specific AuditEvents                                                                                                                                | We can mine the process from multiple perspectives (actors)                 | ae.agent.who                             | ae.agent.who                                  |
| data (entity) | Additional information (FHIR Resources) which are relevant for the patients pathway                                                                                                                                | In future the data could be used to perform conformance checking with data                | ae.entity.what                             | ae.entity.what                                  |

#### Data Quality

Data quality is the principal requirement for any form of data science, especially conformance checking, as this can only be done with sufficient quality of the process documentation. The PICA profiles and extensions define how logging should occur, via different optional profiles, to achieve specific outcomes in conformance checking. 

The main goal of this implementation guide is to keep the profiles as simple as possible, thus only using one FHIR resource, to keep the effort minimal for organizations which wish to conduct a conformance check. What PICA does **not** do is deal with enriching existing audit logs. This is one of the core reasons why no resources that are referenced in the AuditEvent are considered for loading information for the conformance checking.

Although the current focus is on standard conformance checking, potential future extensions are being considered. To support conformance checking with data, additional relevant FHIR resources (e.g. Observation) can be linked as references within ae.entity. It is important to note that **medical data should not be stored directly in the AuditEvent resource.** The specific use case will depend heavily on the available data and algorithms. Model as: Reference an FHIR resource, and use FHIRPath to the actual value that should be evaluated.


The following considerations explain why the selected fields are required for the different process perspectives, and why other fields were not chosen. They may hint how one may enrich an existing audit log for conformance checking, but an enrichment is complex, and where the necessary information may be found in existing systems will vary highly in different software systems, or even across different processes.

#### Which perspectives should be used to reconstruct and conformance check patient processes.

Simply: all of them, to get the best results. As minimal requirement to at least reconstruct a human readable process the **core** and **conformance** perspectives are needed, as they identify what (conformance) happened when (core) to which patient (core). The **care-pathway** resource allows you to check which events were recorded for a specific treatment plan, which is what is needed for conformance checking. The **patient-visit** allows viewing (one or more) treatments in the scope of one or more visits to a care provider, or alternatively allows to view how patients progress through their stay. Finally, **actor** can give an overview about who did what with the patient.

#### Core perspective

The PICA Core Profile is the minimum necessary perspective to reconstruct processes. It contains the two primary attributes:
- **Patient** - the person the process is about
- **EventTime** - when the event happened. If this is well documented in the audit event (ae.period, or ae.occuredDateTime) this information will be taken. 

##### What does the core perspective do?

The core perspective alone, allows one to view all changes (create, update, delete) concerning information related to a patient. Without any other perspectives, this does not concern a specific disease, hospital stay, etc, but the entire patient history. 

It is also not clear what happened to the patient with the core perspective alone, because this is covered in the *conformance* perspective. In case you wish to simply reconstruct patient pathways without covering the other perspectives, you may wish to use ae.entity.what to show which resources were accessed, as this is the lowest common denominator. 

##### Considerations

General:
- We use AuditEvent and not Provenance as AuditEvents are required in the healthcare domain, whereas Provenance resources are optional and serve a specific context.
- We do not use other FHIR Resources other than AuditEvents to keep the effort for implementers as small as possible.

Considerations for Event Time:
- ae.meta.lastUpdated could also be used, as this value is always set. However, this only captures when the server last conduced the write operation on the AuditEvent, and thus is *not used* as event time.
- EventTime could also be considered via ae.recorded. This field only captures when the AuditEvent was recorded, but not when the underlying process occured, and thus is *not used* as event time.
- EventTime could be tracked via the referenced based-on resources, for example Task.executionPeriod, however one Task can have multiple AuditEvents occuring, and a Task will also not always be available, as this would require FHIR based workflow management within the organization.


#### Conformance perspective

Core perspective to enable conformance checking. Requires the tasks that were conducted to be documented in a machine readable format:
- **Task** in the form of a machine readable code.

##### What does the conformance perspective do?

This perspective is the minimal requirement to enable conformance checking of processes. As every task that is done for a patient is documented with a machine readable code, reconstructed processes contain what has happened when for which patient. During conformance checking the processes can be filtered only to tasks relevant for the checked process.

Note that it is possible that one task is part of multiple processes. For example, a blood test (snomed code 396550006), could be part of a general health screening, or for checking the iron content before a blood donation. Thus, it is recommended to also consider the *care-pathway* perspective.

##### Considerations

- The ae.code field was added in FHIR R5 upon request as a result of this project
- In R4 ae.entity.type (and other codings) have different meanings and are not supposed to relate to the task that was conducted.
- In R4 ae.type, and subtype have a different meaning as well
- In R4 ae.entity.detail.type and ae.entity.detail.value could be used to document the task, but this was not recommended by the FHIR community, thus an extension was created.

#### Patient-Visit perspective

The patient visit perspective, enables documenting interactions between patients and healthcare providers:
- **Encounter** - Any visit from a patient with a healthcare provider

##### What does the patient-visit perspective do?

This perspective enables two scenarios:
- Conformance checking can be done on a "per visit" basis, for example if one wanted to check if and how regularly patients adhere to follow-up screenings. 
- In conjunction with the *care-pathway* perspective the treatment of a disease can be viewed / grouped in multiple visits, and (if data is available) over multiple care providers.

##### Considerations

- ae.encounter was added in FHIR R5 upon request as a result of this project. There is no corresponding R4 field, thus an extension was created. 
- In R4, then encounter resource captures encounter.statusHistory.period, which (if encounter.statusHistory.status is between arrived and finished) allows the capturing of which AuditEvents belong to the encounter, and might allow filling audit events with the extension in R4.

#### Care-Pathway perspective

Care pathway documents which care plan was followed for the patient:
- **Treatment Plan** that was followed, e.g. the treatment of a patient for a specific condition.

##### What does the care pathway perspective do?

The care pathway follows a specific treatment plan for a patient. As these CarePlans in FHIR represent the treatment plan, based on a guideline, this allows conformance checking of a process.

In FHIR there are several types of CarePlan. If the care plan you want to conformance check is made for a group (CarePlan.subject), you are able to process mine and conformance check for a group of patients. Otherwise, the care plan will be specific to one patient, and allows only to check the conformance of that one patient's process. In case you want to check the conformance for a specific process (e.g. Treatment for Burn Victims in specific Hospital), all of the care plans that were made for a patient need to be selected from the Audit Log. This depends massively on how FHIR is treated in the hospital, and could be one of the following options (among others):
- CarePlan.instantiatesCanonical refers to the treatment guideline in the form of a PlanDefinition, all care plans for one plan definition can be grouped together in this case
- CarePlan.basedOn refers to a generic CarePlan (similar to PlanDefinition)
- CarePlan.category identifies a code for a treatment that should be conformance checked
- Other options are: carePlan.title, CarePlan.instantiatesUri, ....

##### Considerations

- ae.basedOn was added in FHIR R5 upon request as a result of this project. It covers more than just CarePlan because of additional requirements in FHIR.
- CarePlan was chosen instead of PlanDefinition, even though PlanDefinition in FHIR is intended to define processes (not only treatment) in FHIR on a descriptive level. This was done for several reasons:
  - CarePlan is more used than PlanDefinition. CarePlan also can be used in the form of "this is our treatment plan for condition X", and PlanDefinition is only used if the care provider has a rigorous workflow management.
  - It is more likely that an AuditEvent references the CarePlan that was actually followed for a patient, than the PlanDefinition the CarePlan is basedOn.
- Workflow Management in FHIR is a highly complex topic, and other considerations could have been ActivityDefinition, Quesitonnaire (e.g. for filling a treatment plan for a patient), Tasks, Requests & Responses, etc. 
  - In case a care provider uses these FHIR Resources, it stands to reason that they have a rigorous workflow management, and thus is capable of documenting the reference to CarePlan in ae.basedOn even if, for example, a Task is part of a CarePlan and thus would also indirectly reference the CarePlan in the ae.

#### Actor perspective

The actor perspective enables viewing processes in the form of who (person, role, deparment, organization, or machine) was involved in which process step:
- **Actor** that was involved in the process step

##### What does the actor perspective do?

The actor perspective allows viewing the process from the viewpoint of a specific person, deparment, or organization. Alternatively, it allows viewing who was involved in the process at which specific step(s). For example, this can help identify bottlenecks with machines, or movement of patients between departments.

Note that the patient can be an actor as well, for example if they filled a questionnaire, or took their own vital signs.

##### Considerations

- agent.who is the minimal requirement for this implementation guide, and documented in FHIR
- optionally the agent.type and agent.role could be used to filter towards more specific involvement in the process.

#### Data perspective

The Data perspective, enables conformane checking with data. It requires the data stored in a FHIR Ressource, which is referenced:
- **FHIR Resource** with the values to evaluate needed data


##### What does the data perspective do?

This perspective is needed to enable conformance checking with data. Data-aware conformance checking is an advanced form of conformance checking that not only compares the sequence of events against a process model but also considers the data attributes associated with those events.

The application for a specific use case strongly depends on the available data and the algorithms applied, especially those that integrate additional information during the transformation process.


##### Considerations

- **Medical data should not be stored directly in the AuditEvent.** 
- ae.entity[x].what should reference the according FHIR Resource (e.g. Observation, Procedure,...) where the information is stored.
- With FHIRPath the value will be evaluated.
- Optionally the ae.entity[x].role could be used to filter or define which information should be extracted.


#### Further perspectives

In addition to PICA being this IG, it is also a project at the University of Applied Sciences Upper Austria going until December of 2025. If you have requirements concerning conformance checking of processes that are not covered in this implementation guide, or have questions on how to apply this IG, please contact the [AIST research team](https://aist.fh-hagenberg.at/index.php/en/team-2), specifically Oliver Krauss (oliver.krauss@fh-hagenberg.at) or Andreas Pointner (andreas.pointner@fh-hagenberg.at). 
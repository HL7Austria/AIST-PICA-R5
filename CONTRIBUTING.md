# Contributing to hl7-at-pica

The following is a set of guidelines for contributing to the PICA project and its packages,
which are hosted in the HL7® Austria organization on GitHub. These are mostly guidelines, not rules. Use your best judgment,
and feel free to propose changes to this document in a pull request.

<!-- TOC -->

- [Contributing to hl7-at-fhir-profiles](#contributing-to-hl7-at-fhir-profiles)
    - [Code of Conduct](#code-of-conduct)
    - [How Can I Contribute?](#how-can-i-contribute)
        - [Reporting Bugs](#reporting-bugs)
            - [Before Submitting A Bug Report](#before-submitting-a-bug-report)
            - [How Do I Submit A (Good) Bug Report?](#how-do-i-submit-a-good-bug-report)
        - [Request New Profiles/Extensions](#request-new-profilesextensions)
            - [How Do I Submit a (Good) Enhancement](#how-do-i-submit-a-good-enhancement)
    - [Issue and Pull Request Labels](#issue-and-pull-request-labels)
    - [Style guides](#styleguides)
        - [Git Commit Messages](#git-commit-messages)
        - [Naming Conventions](#naming-conventions)
    - [Additional Information](#additional-information)
    - [Support](#support)

<!-- /TOC -->

## Code of Conduct

This project and everyone that participates in it, is governed by the University of Applied Sciences Upper Austria. As the repository is hosted by the HL7® Austria, PICA also adheres to the Code of Conduct set out by the HL7® Austria FHIR® Technical Committee. By participating, you are expected to uphold this code. Please report unacceptable behavior to emmanuel.helm@fh-hagenberg.at or tcfhir@hl7.at.

## How Can I Contribute?
There are multiple ways of how one can contribute to the efforts of the PICA project:
- Active participation on the HL7® Austria TC FHIR® conference calls 
- Creating feature requests or bug reports here in this repository
- For questions and broader discussions, use the TC-Austria channel on [Zulip](https://chat.fhir.org)

### Reporting Bugs

- - For reporting bugs, the TC FHIR® created an issue template for GitHub, it can be found [here](https://github.com/HL7Austria/HL7-AT-PICA/blob/main/.github/ISSUE_TEMPLATE/hl7-at--bug-report.md) and is available automatically if a new issue is created.

#### Before Submitting A Bug Report

- Please make sure if there isn't already an open or closed GitHub issue in the PICA repository for the problem that you are facing. If the problem isn't directly related to HL7® Austria FHIR® profiles or extensions but is more general, please also make sure that it hasn't been dealt with on the official [FHIR® Chat] (https://chat.fhir.org).

#### How Do I Submit A (Good) Bug Report?

- In order to create a good bug report, you will be asked to fill out a couple of questions concerning your bug, which are necessary for the PICA project members in order to address the stated problem most effectively.  

 

| Bug Criteria | Description |
| --- | --- |
| Real Submitter | Who is the real submitter, in case the creation of the issue was done by proxy. |
| Resource(s)/Profiles incl. Version | Which resources or profiles are affected by this bug report? |
| Priority | Priority of this bug report (Blocker, Critical, Major, Minor, Trivial). |
| Describe the bug | A clear and concise description of what the bug is. |
| To Reproduce | Steps to reproduce the behavior. |
| Expected behavior | A clear and concise description of what you expected to happen. |

### Request New Profiles/Extensions
- For requesting new Profiles or Extensions or features in general the TC FHIR® created a feature request template for github, it can be found [here](https://github.com/HL7Austria/HL7-AT-PICA/blob/main/.github/ISSUE_TEMPLATE/hl7-at--feature-request.md) and is available automatically if a new issue is created.
- Use the issue to describe the intended use case and if applicable state some examples.

#### How Do I Submit a (Good) Enhancement

- In order to create a good feature request you will be asked to fill out a couple of questions concerning your request, which are necessary for the TC FHIR® in order to address the desired feature most effectively.

| Request Criteria | Description |
| --- | --- |
| Real Submitter | Who is the real submitter, in case the creation of the issue was done by proxy. |
| Resource(s)/Profiles incl. Version | Which resources or profiles are affected by this bug report? |
| Priority | Priority of this request (Blocker, Critical, Major, Minor, Trivial). |
| Is your feature request related to a problem? Please describe. | A clear and concise description of what the problem is. |
| Describe the solution you'd like | A clear and concise description of what you want to happen. |
| Describe alternatives you've considered | A clear and concise description of any alternative solutions or features you've considered. |

## Issue and Pull Request Labels

| Label name | Description |
| --- | --- |
| `discussion` | needs to be discussed in a meeting of the technical committee FHIR® in HL7® Austria |
| `review` | a solution to an open issue is provided, however the solution has to be reviewed before closing the respective issue |
| `bug` | marks a bug in the implementation |
| `enhancement` | propose a new feature or a change in an existing profile/extension |
| `blocked` | issues marked with `blocked` are dependent on other issue still in progress |
| `hot` | marks issues with high priority, these are only assigned by the HL7® Austria TC-FHIR®, any invalid use on issues will be removed without discussion |


## Style guides

### Git Commit Messages

A commit message must start with the corresponding ticket number in GitHub (#TICKETNUMBER) each commit message must have a description which should be in present tense and use imperative voice

### Naming Conventions

In general, the HL7® [FHIR® naming conventions](http://wiki.hl7.org/index.php?title=FHIR_Guide_to_Designing_Resources#Naming_Rules_.26_Guidelines) apply. Essentially these conventions ask for **consistency** and **precision** (i.e. minimizing ambiguity, while ensuring the meaning is easily understood) when naming fields, resources or operations.

Most of these guidelines are suggestions, except the following rules that *must* be followed:
-  be U.S. English (spelled correctly!)
-  be expressed as a noun, with a preceding adjective where necessary to clarify the semantics and to make unique
-  not make use of trade-marked terms
-  case style must be followed:
   - resources must be lower-case - ex. `at-pica-patient`, patient resource is all lower case
   - elements must be lowerCamelCase - ex. `at-pica-ext-address-additionalInformation`, the element address.additionalInformation is lowerCamelCase
   - operations must be lower-case - e. `at-pica-exampleoperation` example operation is all lower case

#### Profile Naming conventions

The **StructureDefintion Id** of a profile follows a prefix pattern, meaning that a name from left to right goes from specific to generic. It uses UpperCamelCase.

**ProfileName** = [*Realm*-], *Use-*, *ParentProfile*

**Realm** = Is this profile supposed to be used in a realm? Then use the **countryCode**[^ISO3166-3]

**Use** = What is this profile used for? **lower case**

**ParentProfile** =  Which profile does this profile extend from? **lower case**

[^ISO3166-3]: country codes are [ISO 3166-3](https://www.iso.org/iso-3166-country-codes.html) in the Alpha-2 code format, all lowercase.

Example: Patient used in Austria, for PICA.
```
Realm = Austria -> at- (country code)
Use = HL7® Austria FHIR® PICA -> pica-
ParentProfile = Patient -> patient
at-pica-patient
```

Example: Audit Event for PICA
```
Realm = Austria -> at-
Use = ELGA -> pica-
ParentProfile = AuditEvent -> auditevent
at-pica-auditevent
```

#### Extension Naming conventions

The **StructureDefintion Id** of an extension follows a suffix pattern, meaning that a name from left to right goes from generic to specific.

**ExtensionName** = [*Realm*-], *Use-*, *ext-* *ProfileItIsFor-*, *FieldItAdds*

**Realm** = Is this profile supposed to be used in a realm? Then use the **countryCode**[^ISO3166-3]

**Use** = What is this profile used for? **lower case**

**ext-** = indication that this is an Extension **lower case**

**ProfileItIsFor** = Either Base Profile or **Profile** previously defined (optional if extension can occur anywhere -> Ex. NullFlavor), without the Realm. **lower case**

**FieldItAdds** = **unique naming** for field **lowerCamelCase**

Example: Religions for a patient registered in Austria 
```
Realm = Austria -> at-
Use = HL7® Austria FHIR® PICA -> pica-
Profile = Patient -> patient-
FieldItAdds = Religion -> religion
at-pica-ext-patient-religion
```

Example: Extra field in Address
```
Realm = Austria -> at-
Use = HL7® Austria FHIR® PICA -> pica-
Profile = Address -> address
FieldItAdds = Additional Information -> additionalInformation
at-pica-ext-address-additionalInformation
```

## Additional Information

### Documentation of decisions on issues

As the PICA project is a publicly funded project by an academic institution, there is no formal voting, as is usual in the HL7® domain. Design decisions are documented in the issues, as are decision on how to implement / why we rejected issues or bug-reports that were made. 

## Support
We actively monitor the issues coming in through the GitHub repository at https://github.com/HL7Austria/HL7-AT-FHIR-PICA/issues. You are welcome to register your bugs and feature suggestions there. For questions and broader discussions, we use the TC-Austria channel on [Zulip](https://chat.fhir.org).

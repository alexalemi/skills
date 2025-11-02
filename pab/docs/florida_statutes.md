# Florida Statutes Access Guide

## Overview
This guide provides instructions for accessing specific sections of the Florida Statutes using available tools.

## Primary Method: Florida Senate Website

### URL Pattern
The most reliable method for accessing Florida Statutes is through the Florida Senate website using the following URL pattern:

```
https://www.flsenate.gov/Laws/Statutes/[YEAR]/[STATUTE_NUMBER]
```

### Parameters
- **YEAR**: The year of the statutes (e.g., 2025, 2024)
- **STATUTE_NUMBER**: The statute section number in the format `XXXX.XX` (e.g., 0270.10, 163.3161)

### Examples
- Florida Statute Â§270.10 (2025): `https://www.flsenate.gov/Laws/Statutes/2025/0270.10`
- Florida Statute Â§163.3161 (2025): `https://www.flsenate.gov/Laws/Statutes/2025/163.3161`
- Florida Statute Â§112.501 (2025): `https://www.flsenate.gov/Laws/Statutes/2025/112.501`

## Usage Instructions

### When to Use
Use the `web_fetch` tool to access Florida Statutes when:
- You need the current text of a specific statute
- The user references a Florida Statute by number
- You need to verify statute language or details
- The statute is not already available in project files

### How to Use
1. Identify the statute number from the user's query
2. Construct the URL using the pattern above
3. Use the `web_fetch` tool with the constructed URL
4. Extract and present the relevant statute text

### Example Implementation
```
User asks: "What does Florida Statute 270.10 say?"

Step 1: Identify statute number: 270.10
Step 2: Construct URL: https://www.flsenate.gov/Laws/Statutes/2025/0270.10
Step 3: Call web_fetch with the URL
Step 4: Extract and summarize the statute content
```

## Alternative Sources

### Florida Legislature Website
The official legislature website (`www.leg.state.fl.us`) is less reliable for programmatic access due to JavaScript rendering limitations. Use the Florida Senate website instead.

### Project Knowledge
Before fetching statutes from the web, check if relevant statutes are already available in the project files. Several Florida Statutes are already included in this project's knowledge base.

## Best Practices

1. **Check Project Files First**: Always search project knowledge before fetching from the web
2. **Use Current Year**: Default to the most recent year (2025) unless the user specifies otherwise
3. **Format Statute Numbers Correctly**: Ensure leading zeros are included (e.g., 0270.10, not 270.10)
4. **Cite Sources**: When presenting statute text, always include the statute number and year
5. **Handle Errors Gracefully**: If a fetch fails, try alternative sources or inform the user

## Key PAB-Relevant Statutes

### Chapter 163 - Community Planning (Most Important for PAB Work)

**§163.3161 - Community Planning Act**
- Legislative intent and framework for local comprehensive planning
- Establishes state policy empowering local governments to plan and regulate development
- Emphasizes protection of private property rights while allowing regulation
- **Key for:** Understanding the legal foundation for comprehensive planning in Florida

**§163.3177 - Required and Optional Elements of Comprehensive Plan**
- Specifies the 9 required elements (FLUE, TE, sanitary sewer/solid waste/drainage/potable water/aquifer recharge, conservation, recreation and open space, housing, capital improvements, intergovernmental coordination, property rights)
- Additional coastal management element for coastal communities
- Details what each element must contain
- **Key for:** Verifying comprehensive plan completeness and required content

**§163.3194 - Legal Status of Comprehensive Plans**
- Establishes that development orders and permits must be consistent with comprehensive plan
- Defines consistency requirements
- Procedures for determining consistency
- **Key for:** Evaluating whether applications are consistent with the comprehensive plan

**§163.3202 - Land Development Regulations**
- Requirements for local land development regulations (LDRs)
- How LDRs implement the comprehensive plan
- Consistency between LDRs and comprehensive plan
- **Key for:** Understanding relationship between comp plan and zoning/LDC

**§163.3215 - Urban Infill and Redevelopment Areas**
- Designation of urban infill and redevelopment areas
- Expedited review processes for these areas
- Incentives for development in designated areas
- **Key for:** Reviewing applications in Community Redevelopment Areas or infill areas

**§163.3174 - Local Planning Agency**
- Powers and duties of planning advisory boards
- Meeting and procedural requirements
- Recommendations to local governing body
- **Key for:** Understanding PAB authority and responsibilities

**§163.3184 - Process for Adoption of Comprehensive Plan or Plan Amendment**
- Procedures for plan amendments
- Public hearing requirements
- State review requirements
- **Key for:** Understanding the comprehensive plan amendment process

**§163.3245 - Discrimination in Land Development Prohibitions**
- Prohibits discrimination based on race, color, religion, sex, national origin, age, handicap, or familial status
- **Key for:** Fair housing and equal protection considerations

### Chapter 380 - Regional Planning and Development

**§380.0651 - Developments of Regional Impact (DRI)**
- Standards and thresholds for DRIs
- Review procedures for large-scale developments
- Regional impact considerations
- **Key for:** Identifying whether a development qualifies as a DRI

**§380.06 - Developments of Regional Impact; Guidelines and Standards**
- Detailed DRI guidelines, thresholds, and review criteria
- **Key for:** Large development project review

### Chapter 112 - Public Officers and Employees

**§112.501 - Municipal Board Members; Suspension; Removal**
- Grounds for suspension or removal of board members
- Procedural requirements
- **Key for:** Understanding board member conduct requirements

**§112.3143 - Voting Conflicts of Interest**
- When board members must abstain from voting
- Required disclosures
- Penalties for violations
- **Key for:** Identifying and properly handling conflicts of interest

**§112.313 - Standards of Conduct for Public Officers**
- Ethical standards for public officials
- Prohibited conduct
- **Key for:** Ethical compliance

### Chapter 286 - Open Government (Sunshine Law)

**§286.011 - Public Meetings and Records; Public Inspection**
- Requirements for open meetings
- When meetings must be public
- Notice requirements
- **Key for:** Ensuring PAB meetings comply with Sunshine Law

**§286.012 - Voting Requirement**
- How votes must be recorded
- **Key for:** Proper voting procedures

### Chapter 119 - Public Records

**§119.07 - Inspection and Copying of Records**
- Public records access requirements
- Exemptions
- **Key for:** Understanding public records obligations

## Common Florida Statutes in Project Context

The following statutes may already be available in project files:
- Florida Statute 112.501 - Municipal board members; suspension; removal
- Florida Statute 163.3161 - Community Planning Act
- Florida Statute 163.3174 - Local Planning Agency

## Troubleshooting

### Issue: URL Returns No Content
- Verify the statute number format (include leading zeros)
- Check that the statute exists for the specified year
- Try an alternative year if the current year returns no results

### Issue: Statute Not Found
- Verify the statute number is correct
- Check if the statute has been repealed or renumbered
- Search project knowledge for related statutes

## Notes
- The Florida Senate website provides clean, accessible text without requiring JavaScript
- Statute content includes the full text, related links, and bill citations
- Always verify you're accessing the correct year's version of the statute

---
name: planning-advisory-board
description: This skill should be used when analyzing Planning Advisory Board (PAB) agenda items, evaluating development proposals against Kissimmee's Comprehensive Plan and Land Development Code, checking zoning or future land use for parcels, or assessing applications using Strong Towns principles. Also use for questions about PAB procedures, Florida planning statutes, or Kissimmee city regulations.
---

# Planning Advisory Board

## Overview

This skill provides workflows for analyzing Planning Advisory Board agenda items by evaluating proposals against the Kissimmee Comprehensive Plan, Land Development Code, Florida Statutes, Rosenberg's Rules of Order, and Strong Towns principles. Use these workflows to assess development proposals and inform voting decisions.

# Workflows

## Finding PAB Agendas

### Step 1: Fetch the Events List

Use `web_fetch` to retrieve the events API with today's date as the filter:
```
https://kissimmeefl.api.civicclerk.com/v1/Events?$filter=startDateTime+ge+YYYY-MM-DD&$orderby=startDateTime+asc,+eventName+asc
```

Replace `YYYY-MM-DD` with the current date (e.g., `2025-11-02`).

### Step 2: Filter for PAB Meetings
Look for events where:
- `eventName` equals `"Planning Advisory Board"`
- `eventCategoryName` equals `"Advisory Boards"`

### Step 3: Check for Published Agendas
In each PAB event, check the `publishedFiles` array:
- If the array contains items, agendas are available
- Look for files with `"type": "Agenda"` or `"type": "Agenda Packet"`
- The full PDF URL is: `https://kissimmeefl.api.civicclerk.com/` + `url` field

Example: `https://kissimmeefl.api.civicclerk.com/stream/KISSIMMEEFL/be3d7aa1-af81-44d1-92ee-ecc9485252ef.pdf`

After fetching the PDF, use the pdf skill to extract text and analyze it.

## Assessing a New PAB Agenda

To assess a PAB agenda:

1. Use the pdf skill to extract and read the full agenda PDF
2. Identify all action items requiring PAB vote (typically rezoning, conditional use permits, variance requests, comp plan amendments)
3. For each action item, launch a Task agent (subagent_type: "general-purpose") to perform detailed analysis (see "Assessing Individual PAB Agenda Item" below)
4. After all agents complete, compile findings into a markdown report with voting recommendations

## Assessing Individual PAB Agenda Item

To assess an individual agenda item, launch parallel Task agents to evaluate compliance with multiple frameworks. Each agent should return specific findings with section/policy citations.

**Launch these analyses in parallel when possible:**

1. **Comprehensive Plan Consistency**
   - Check against FLUE (Future Land Use Element), TE (Transportation Element), and CIE (Capital Improvements Element)
   - Reference: `./references/compplan-guide.md` and `./references/compplan/` txt files
   - Focus on Goals, Objectives, and Policies hierarchy (e.g., Policy 1.1.1.1)

2. **Land Development Code Compliance**
   - Check LDC Chapter 14-3 (Development Review Procedures), 14-4 (Zoning), 14-7 (Parking/Access), 14-10 (Subdivision)
   - Reference: `./references/kissimmee-code-guide.md` and `./data/KissimmeeFLCodeofOrdinancesEXPORT20250822.xlsx`
   - Verify dimensional requirements, setbacks, parking, FAR, density limits

3. **Florida Statutes**
   - Check consistency with Chapter 163 (Community Planning Act)
   - Use WebFetch to access: `https://www.flsenate.gov/Laws/Statutes/2025/[statute_number]`
   - Key statutes: §163.3177 (comp plan elements), §163.3194 (consistency requirements), §163.3202 (LDRs)

4. **Rules of Procedure**
   - Check compliance with Rosenberg's Rules of Order
   - Reference: `./references/rosenbergs-rules.pdf`

5. **Constitutional Review**
   - Check for potential takings (5th Amendment), due process, equal protection issues
   - Reference: `./references/constitution.md`

6. **Strong Towns Principles**
   - Evaluate financial sustainability, value-per-acre, walkability, incremental development
   - Reference: `./references/strong-towns.md`
   - This is an advisory framework to supplement (not replace) legal requirements

After all agents complete, synthesize findings into a markdown report with specific citations and a clear voting recommendation.

## Checking the Future Land Use of a Parcel

GIS shapefile data for Future Land Use designations is available in `./data/future_land_use/` (17 FLU categories: AE, CG, CONS, IN, INST, MF-HDR, MF-MDR, MH-MDR, MU-D, MU-FR, MU-T, MU-V, OR, REC, SF-LDR, SF-MDR, UT). The shapefiles have been extracted and are ready to use.

Use Python with geopandas for spatial queries, or ogrinfo for command-line inspection. Key fields include `PROP_FLUM` (FLU code), `FLU_NAME`, `DENSITY`, and `FAR`.

Cross-reference findings with Comprehensive Plan FLUE (Objective 1.2).

**For detailed instructions, field descriptions, and code examples:** See `./references/gis-data-guide.md`

## Checking the Zoning of a Parcel

GIS shapefile data for Zoning Districts is available in `./data/Zoning_Districts/` (36 zoning codes including T-zones, residential, commercial, and PUDs). The shapefiles have been extracted and are ready to use.

Use Python with geopandas for spatial queries, or ogrinfo for command-line inspection. Key fields include `ZONING_COD`, `SUMMARY_LI`, dimensional requirements (`LOT_AREA`, `LOT_WIDTH`, `HEIGHT`), and setbacks (`Front`, `Side`, `Rear`).

Cross-reference findings with LDC Chapter 14-4 (Zoning).

**For detailed instructions, field descriptions, and code examples:** See `./references/gis-data-guide.md` and `./references/kissimmee-code-guide.md`

## Reading the Kissimmee Comprehensive Plan

The Kissimmee 2040 Comprehensive Plan text is available in `./references/compplan/` (11 txt files extracted from the original 646-page comprehensive plan). For PAB work, prioritize FLUE (Future Land Use), TE (Transportation), and CIE (Capital Improvements). Use `Comp Plan_12.2022_GOPS Only_reduced.txt` for quick policy lookups during meetings (contains only Goals, Objectives, and Policies).

Each element follows a Goal > Objective > Policy hierarchy (e.g., Policy 1.1.1.1). Look for "shall" (mandatory), "should" (recommended), and "may" (permissive) language.

**For complete element descriptions, navigation tips, and policy analysis:** See `./references/compplan-guide.md`

## Reading the Kissimmee City Code and Land Development Code

The City Code is available in `./data/KissimmeeFLCodeofOrdinancesEXPORT20250822.xlsx` (Excel file with 5 columns: `Url`, `NodeId`, `Title`, `Subtitle`, `Content`).

**Three main parts:**
- **Part I:** City Charter
- **Part II:** Code of General Ordinances (includes PAB authority in Chapter 2: §2-209 to §2-219)
- **Part III:** Land Development Code (most relevant for PAB work - focus on Chapters 14-3, 14-4, 14-7, 14-10)

**Search tips:**
- Use `NodeId` column to navigate hierarchy (e.g., "PTIIILADECO_CH14-3DEREBOPR" for Chapter 14-3)
- Use `Title` column for topic keywords (parking, density, setback)
- Use `Content` column for specific requirements (search with grep or pandas)

**For detailed navigation instructions, PAB authorities, and complete section listing:** See `./references/kissimmee-code-guide.md`, `./references/kissimmee-code-sections.md`, and `./references/relevant-code.md`

## Reading the Rules of Procedure

The PAB uses Rosenberg's Rules of Order (replacing Robert's Rules). Reference document: `./references/rosenbergs-rules.pdf`

## Reading the Florida Statutes

Access Florida Statutes using WebFetch with URL pattern: `https://www.flsenate.gov/Laws/Statutes/2025/[STATUTE_NUMBER]`

**Key PAB-Relevant Statutes (Chapter 163 - Community Planning):**
- §163.3161 - Community Planning Act
- §163.3177 - Required/optional comp plan elements
- §163.3194 - Legal status and consistency requirements
- §163.3202 - Land development regulations
- §163.3215 - Urban infill and redevelopment areas

Use current year (2025) and include leading zeros in statute numbers (e.g., 0270.10).

**For detailed instructions and additional statutes:** See `./references/florida_statutes.md`

## Reading the US Constitution

Reference document: `./references/constitution.md`

**Key PAB-Relevant Provisions:**
- **Fifth Amendment** - Due process, takings clause (property rights)
- **Fourteenth Amendment** - Equal protection, due process
- **First Amendment** - Free speech (sign regulations)

Ensure land use decisions comply with constitutional protections, particularly takings, due process, and equal protection.

## Assessing Strong Towns Principles

Strong Towns is a non-profit advocating for financially sustainable urban development. Use this framework as an advisory lens to evaluate long-term financial and community impacts.

**Core Concept:** Modern suburban development creates unsustainable liabilities (Growth Ponzi Scheme).

**Key evaluation questions:**
- Does it generate sufficient revenue to cover perpetual infrastructure costs?
- Is it incremental and adaptable, or a large transformative gamble?
- Does it create value-per-acre through human-scaled, walkable design?
- Does it avoid "stroads" and minimize parking mandates?

This is an **advisory framework** to supplement (not replace) Comprehensive Plan and LDC requirements.

**For detailed principles and guidance:** See `./references/strong-towns.md`

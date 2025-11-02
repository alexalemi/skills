---
name: planning-advisory-board
description: Use pab to help answers questions about the planning advisory board, pab, rules of procedure, zoning, comp plan amendments, the kissimmee city code, kissimmee in general, strong towns, parking reform, housing reform, etc.
---

# Planning Advisory Board

## Overview

This skill is a set of techniques for searching for and reading things like the Kissimmee city code, florida statutes, roberts' rules, rosenberg's rules, etc.  To help analyze new PAB agenda items and try to make sense of them and help determine how to vote.

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

## Assessing a new PAB agenda

In order to assess a new pab agenda, do the following things.

 1. Read the whole agenda
 2. For each agenda item, spawn a new subagent to analyze it in detail.

## Assessing Individual PAB Agenda item

In order to assess an individual PAB Agenda item, you have to analyze the following things.

 1. Does it agree or disagree with the Comprehensive Plan?
 2. Does it agree or disagree with the Kissimmee City Code?
 3. Does it agree or disagree with Kissimmee Land Development Code?
 4. Does it agree or disagree with our rules of procedure?
 5. Does it agree or disagree with Florida Statutes?
 6. Does it agree or disagree with the US Constitution?
 7. Does it agree or disagree with Strong Town Principles?

For each of these, launch a separate subagent to do the analysis, you can use the explained search tools to try to access all of these sources.

Finally, use a separate agent to try to summarize the findings of all of the subagents and compile it into a Markdown report.

## Checking the Future Land Use of a parcel

GIS shapefile data for Future Land Use designations is available in `./data/future_land_use.zip`.

**17 FLU Categories:** AE, CG, CONS, IN, INST, MF-HDR, MF-MDR, MH-MDR, MU-D, MU-FR, MU-T, MU-V, OR, REC, SF-LDR, SF-MDR, UT

**Key Fields:**
- `PROP_FLUM` - FLU code (e.g., "MU-T", "SF-LDR")
- `FLU_NAME` - Full name (e.g., "MU-T (Tapestry)")
- `DENSITY` - Residential density limits
- `FAR` - Floor Area Ratio

**Tools to use:**
- Python with geopandas (recommended for spatial queries)
- QGIS (for visual exploration)
- ogrinfo command-line tool

**Cross-reference with:** Comprehensive Plan FLUE (Objective 1.2) - see `compplan-guide.md`

**For detailed instructions and code examples:** See `./docs/gis-data-guide.md`

## Checking the Zoning of a parcel

GIS shapefile data for Zoning Districts is available in `./data/Zoning_Districts.zip`.

**36 Zoning Codes:** AC, AI, AO, B-2, B-3, B-5, BP, CF, HC, HF, IB, MH, MHP, MUPUD, OS, RA-1, RA-2, RA-3, RA-4, RB-1, RB-2, RC-1, RC-2, RE, RPB, RPUD, SD, SRPUD, T1, T3, T4-O, T4-R, T5-M, T5-U, T6, UT

**Key Fields:**
- `ZONING_COD` - Zoning code (e.g., "T5-M", "B-3")
- `SUMMARY_LI` - Description and minimum lot area
- `LOT_AREA`, `LOT_WIDTH`, `LOT_DEPTH` - Dimensional requirements
- `HEIGHT` - Maximum building height
- `Front`, `Side`, `Street_Sid`, `Rear` - Setback requirements
- `LOT_COVERA` - Maximum lot coverage
- `FAR` - Floor Area Ratio

**Tools to use:**
- Python with geopandas (recommended for spatial queries)
- QGIS (for visual exploration)
- ogrinfo command-line tool

**Cross-reference with:** LDC Chapter 14-4 (Zoning) - see `kissimmee-code-guide.md`

**For detailed instructions and code examples:** See `./docs/gis-data-guide.md`

## Reading the Kissimmee Comprehensive Plan

The Kissimmee 2040 Comprehensive Plan is located in `./docs/compplan/` and consists of 11 PDF documents (646 total pages) organized into elements:

**Most PAB-Relevant Elements (check these first):**
- **FLUE** (01_FLUE_Dec21.pdf) - Future Land Use - land use designations, density/intensity standards
- **TE** (02_TE_Dec21.pdf) - Transportation - multimodal requirements, access management, street design
- **CIE** (08_CIE_Dec21.pdf) - Capital Improvements - concurrency, level of service standards

**Other Elements:**
- **HE** (03) - Housing, **PFE** (04) - Public Facilities, **CONS** (05) - Conservation, **ROSE** (06) - Recreation, **ICE** (07) - Intergovernmental Coordination, **EDEV** (10) - Economic Development, **PR** (11) - Property Rights

**Primary Working Reference:**
- **Comp Plan_12.2022_GOPS Only_reduced.pdf** (238 pages) - Consolidated Goals, Objectives, and Policies from all elements. Use this for quick policy lookups during PAB meetings.

Each element follows a Goal > Objective > Policy hierarchy (e.g., Policy 1.1.1.1). Look for "shall" (mandatory), "should" (recommended), and "may" (permissive) language.

**For detailed guide:** See `./docs/compplan-guide.md`

## Reading the Kissimmee City Code and Land Development Code

The file `./docs/KissimmeeFLCodeofOrdinancesEXPORT20250822.xlsx` contains the complete Kissimmee City Code organized into 3 main parts:

- **Part I: City Charter** - Charter provisions, administrative structure, elections, finance
- **Part II: Code of General Ordinances** - 26 chapters covering administration, buildings, utilities, traffic, etc.
- **Part III: Land Development Code** - 11 chapters (most relevant for PAB work)

**Key PAB Authority Sections (Part II, Chapter 2):**
- **§2-209 to §2-219** - PAB establishment, powers, duties, and procedures
- **§2-210** - Composition: 7 voting members + 1 school board non-voting member, quorum is 4
- **§2-211** - Organization: Majority of quorum required for action
- **§2-362** - PAB also designated as Brownfield Advisory Committee

**Key PAB Authority Sections (Part III - Land Development Code):**
- **§14-3-1** - PAB powers: local planning agency, comp plan review, zoning amendments
- **§14-3-29** - Conditional uses: PAB has final approval authority (subject to appeal)
- **§14-7-22(E)2** - Parking reduction: Up to 50% reduction for non-residential in TNDs
- **§14-4-8(4)(b)ii** - Building separation waiver in PUDs
- **§14-11-16** - Approval of true works of art (murals, statuary)

**For PAB work, focus on:**
- **Chapter 14-3:** Development Review Boards and Procedures (NodeId: `PTIIILADECO_CH14-3DEREBOPR`)
- **Chapter 14-4:** Zoning (NodeId: `PTIIILADECO_CH14-4ZO`)
- **Chapter 14-7:** Access, Circulation and Parking
- **Chapter 14-10:** Subdivision and Site Design

The Excel file has 5 columns: `Url`, `NodeId`, `Title`, `Subtitle`, `Content`. Use the NodeId field to navigate the hierarchical structure (underscores indicate hierarchy levels).

**For detailed instructions:** See `./docs/kissimmee-code-guide.md`
**For complete section listing:** See `./docs/kissimmee-code-sections.md`
**For PAB-specific authorities:** See `./docs/relevant-code.md`

## Reading our rules of procedure

We originally used Robert's rules as our board's rules of procedure, but have now adopted Rosenberg's rules.

There is a copy of Rosenberg's rules in `./docs/rosenbergs-rules.pdf`.

## Reading the Florida Statutes

Florida Statutes can be accessed using `web_fetch` with the Florida Senate website:

**URL Pattern:** `https://www.flsenate.gov/Laws/Statutes/[YEAR]/[STATUTE_NUMBER]`

**Key PAB-Relevant Statutes (Chapter 163 - Community Planning):**
- **§163.3161** - Community Planning Act (legislative intent and framework)
- **§163.3177** - Required and optional comprehensive plan elements
- **§163.3194** - Legal status of comprehensive plans (consistency requirements)
- **§163.3202** - Land development regulations
- **§163.3215** - Designation of urban infill and redevelopment areas

**Other Important Statutes:**
- **§380.0651** - Developments of Regional Impact (DRI)
- **§112.501** - Municipal board members; suspension; removal

When searching, use the current year (2025) and include leading zeros in statute numbers (e.g., 0270.10).

**For detailed instructions:** See `./docs/florida_statutes.md`

## Reading the US Constitution

The US Constitution is available in `./docs/constitution.md`.

**Key PAB-Relevant Provisions:**
- **Fifth Amendment** - Due process, takings clause (property rights)
- **Fourteenth Amendment** - Equal protection, due process (applies Fifth Amendment to states)
- **First Amendment** - Free speech considerations for sign regulations

When evaluating land use decisions, PAB must ensure compliance with constitutional protections, particularly regarding property rights (takings), due process, and equal protection.

## Assessing Strong Town Principles

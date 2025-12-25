# Kissimmee City Code: Comprehensive Access Guide

This guide provides detailed instructions for programmatically accessing and searching the Kissimmee City Code Excel file.

## File Overview

**File:** `./docs/KissimmeeFLCodeofOrdinancesEXPORT20250822.xlsx`
- **Size:** 1,800 rows of ordinance data
- **Sheet Name:** Sheet1
- **Last Export:** August 22, 2025

## File Structure

### Columns

The Excel file contains 5 columns:

1. **Url** - Web URL to the ordinance on the official Kissimmee website
2. **NodeId** - Hierarchical identifier using underscores to indicate structure levels
3. **Title** - Section or chapter title
4. **Subtitle** - Additional descriptive text
5. **Content** - The full text of the ordinance (can be thousands of characters)

### Three Main Parts

The code is organized into three major parts:

1. **PTICH** (183 rows) - Part I: City Charter
2. **PTIICOGEOR** (1,309 rows) - Part II: Code of General Ordinances
3. **PTIIILADECO** (298 rows) - Part III: Land Development Code

## NodeId Hierarchy System

The NodeId field uses underscores to represent hierarchical levels:

```
PTIIILADECO_CH14-4ZO_14-4-1APOTSU_14-4-1-1GERU
│           │         │            └─ Subsection (14-4-1-1)
│           │         └─ Section (14-4-1)
│           └─ Chapter (CH14-4ZO = Chapter 14-4 Zoning)
└─ Part (PTIIILADECO = Part III Land Development Code)
```

**Pattern:** More underscores = deeper in the hierarchy

## Reading the File with Python/Pandas

### Basic Loading

```python
import pandas as pd

# Read the Excel file
df = pd.read_excel('./docs/KissimmeeFLCodeofOrdinancesEXPORT20250822.xlsx')

# Display basic info
print(f"Total rows: {len(df)}")
print(f"Columns: {list(df.columns)}")
```

## Common Search Patterns

### 1. Search by NodeId Prefix (Most Efficient for Sections)

Get entire chapters or sections by filtering on NodeId prefix:

```python
# Get all of Chapter 14-4 (Zoning)
zoning = df[df['NodeId'].str.startswith('PTIIILADECO_CH14-4ZO', na=False)]

# Get all of Land Development Code (Part III)
ldc = df[df['NodeId'].str.startswith('PTIIILADECO', na=False)]

# Get all of General Ordinances (Part II)
general = df[df['NodeId'].str.startswith('PTIICOGEOR', na=False)]

# Get specific section
section = df[df['NodeId'] == 'PTIIILADECO_CH14-4ZO_14-4-1APOTSU']
```

### 2. Search by Keyword in Titles

Find sections by searching in the Title column:

```python
# Find all zoning-related entries
zoning = df[df['Title'].str.contains('zoning', case=False, na=False)]

# Find parking regulations
parking = df[df['Title'].str.contains('parking', case=False, na=False)]

# Find subdivision requirements
subdivision = df[df['Title'].str.contains('subdivision', case=False, na=False)]

# Multiple keywords (OR logic)
df[(df['Title'].str.contains('setback', case=False, na=False)) |
   (df['Title'].str.contains('yard', case=False, na=False))]
```

### 3. Search Within Content (Full Text Search)

Search within the actual ordinance text:

```python
# Find all ordinances mentioning "setback"
setback_mentions = df[df['Content'].str.contains('setback', case=False, na=False)]

# Find specific measurements
height_limits = df[df['Content'].str.contains(r'\d+\s*feet', case=False, na=False, regex=True)]

# Search for specific terms
affordable_housing = df[df['Content'].str.contains('affordable housing', case=False, na=False)]
```

### 4. Combined Searches

Combine multiple criteria for precise results:

```python
# Find zoning sections that mention "residential"
zoning_residential = df[
    (df['NodeId'].str.startswith('PTIIILADECO_CH14-4ZO', na=False)) &
    (df['Content'].str.contains('residential', case=False, na=False))
]

# Find development review procedures with specific keywords
dev_review = df[
    (df['NodeId'].str.startswith('PTIIILADECO_CH14-3DEREBOPR', na=False)) &
    (df['Title'].str.contains('approval', case=False, na=False))
]
```

## PAB-Relevant NodeId Prefixes

For Planning Advisory Board work, these are the most commonly needed sections:

```python
# Zoning (Chapter 14-4)
ZONING = 'PTIIILADECO_CH14-4ZO'

# Development Review Boards and Procedures (Chapter 14-3)
DEV_REVIEW = 'PTIIILADECO_CH14-3DEREBOPR'

# Subdivision and Site Design (Chapter 14-10)
SUBDIVISION = 'PTIIILADECO_CH14-10SUSIDEPUIM'

# Terms Defined (Chapter 14-2)
DEFINITIONS = 'PTIIILADECO_CH14-2TEDE'

# Form-Based Code (Chapter 14-5)
FORM_BASED = 'PTIIILADECO_CH14-5FOBACO'

# Access, Circulation and Parking (Chapter 14-7)
PARKING = 'PTIIILADECO_CH14-7ACCIPA'

# All Land Development Code
ALL_LDC = 'PTIIILADECO'

# Chapter 2 - Administration, Boards and Commissions (Part II)
PAB_ESTABLISHMENT = 'PTIICOGEOR_CH2AD_ARTIIIBOCO_DIV3PLADBO'
```

## Critical PAB Authority Sections

These sections define PAB's specific powers and should be referenced when exercising authority:

### Part II - Chapter 2: Board Establishment and Powers

**§2-209 - Designation as Planning Agency**
- Designates PAB as the local planning agency under F.S. §163.3174
- Foundational authority for all PAB planning functions

**§2-210 - Composition and Terms**
- 7 voting members + 1 school board non-voting member
- Quorum: 4 members
- Majority of quorum required for action
- Members must serve 1 year before eligible for chair

**§2-211 - Organization**
- PAB sets its own rules of procedure
- All meetings must be open to public
- All records are public records

**§2-214 - Review of Regulations, Codes and Amendments**
- PAB must review ALL proposed land development regulations and amendments
- Makes recommendations on consistency with comprehensive plan
- **Important:** If something goes to commission without PAB review, it violates this section

**§2-362 & §2-361 - Brownfield Advisory Committee**
- PAB is also designated as the Brownfield Advisory Committee
- Additional powers under F.S. §§376.77-376.86

### Part III - Land Development Code: Specific Authorities

**§14-3-1 - Planning Advisory Board Powers**
```python
# Search for PAB powers section
pab_powers = df[df['NodeId'].str.contains('14-3-1', na=False)]
```
Key authorities:
- Act as local planning agency (F.S. §163.3174)
- Review and recommend on comprehensive plan amendments
- Review land development regulations for consistency
- Review zoning map amendments
- Review conditional uses (with approval authority)

**§14-3-29 - Conditional Uses (FINAL APPROVAL AUTHORITY)**
```python
# Find conditional use procedures
conditional_uses = df[df['NodeId'].str.contains('14-3-29', na=False)]
```
- **PAB has final approval authority** (not just recommendation)
- Decisions become final after 10 days unless appealed
- Exception: If applicant is PAB member, commissioner, or city employee, goes to commission

**§14-7-22(E)2 - Parking Reduction Authority (UP TO 50%)**
```python
# Find parking regulations
parking_reqs = df[df['NodeId'].str.contains('14-7-22', na=False)]
```
- Can reduce parking requirements by up to 50% for non-residential uses in Traditional Neighborhood Developments
- Must determine uses primarily serve residents/businesses within neighborhood
- Final decision by city commission after PAB review

**§14-4-8(4)(b)ii - Building Separation Waiver in PUDs**
```python
# Find PUD regulations
pud_regs = df[df['NodeId'].str.contains('14-4-8', na=False)]
```
- Standard: 15 feet between multi-family structures (4+ units), +5 feet per story
- **PAB can review and recommend partial waiver**
- Commission makes final decision
- Must consider impact on light, air, privacy, fire hazards

**§14-4-6 - Minimum Lot Size Waiver (Business Park)**
```python
# Find zoning district regulations
zoning_districts = df[df['NodeId'].str.contains('14-4-6', na=False)]
```
- Standard: 5-acre minimum for Business Park (BP) district
- Commission may waive upon PAB recommendation

**§14-11-16 - True Works of Art (APPROVAL AUTHORITY)**
```python
# Find sign regulations for art
art_approval = df[df['NodeId'].str.contains('14-11-16', na=False)]
```
- PAB must approve all murals, statuary, and similar outdoor items
- Must determine: (1) It's true art, not a sign, and (2) Compatible with surrounding area
- Director can approve if determined to be customary yard/building accessory

**§14-6-40 - Drive-Through Facility Alternatives**
```python
# Find drive-through regulations
drive_through = df[df['NodeId'].str.contains('14-6-40', na=False)]
```
- PAB can consider alternate locations for drive-through windows/menu boards
- Case-by-case basis if alternate location furthers code intent

**§38-214 - Right-of-Way Vacation Procedures**
```python
# Find ROW vacation procedures (Chapter 38)
row_vacation = df[df['NodeId'].str.contains('38-214', na=False) |
                   df['Content'].str.contains('vacation of rights-of-way', case=False, na=False)]
```
- PAB reviews right-of-way abandonment applications
- Considers benefit to community as a whole
- Recommends rearrangement of streets for better circulation
- Provides approximate valuation of ROW
- Can recommend monetary compensation or alternate ROW

**§14-3-16 - Level of Review Required**
```python
# Find table showing what PAB reviews
review_table = df[df['NodeId'].str.contains('14-3-16', na=False)]
```
- Contains table showing which applications require PAB review
- Critical reference for determining PAB jurisdiction

**§14-3-20 - Public Hearings**
```python
# Find public hearing procedures
public_hearings = df[df['NodeId'].str.contains('14-3-20', na=False)]
```
- PAB can: Approve, Approve with conditions, Continue, or Deny
- When approving with conditions, can address: size/bulk/location, construction period, landscaping, signage, lighting, ingress/egress, design, hours of operation, traffic/environmental mitigation

**§14-3-23 - Comprehensive Plan Amendments**
```python
# Find comp plan amendment procedures
comp_plan_amend = df[df['NodeId'].str.contains('14-3-23', na=False)]
```
- Lists criteria for future land use amendments
- Amendment must be consistent with comp plan goals/objectives/policies
- Must meet one of 7 specific reasons listed in code

**§18-65 - Affordable Housing Advisory Committee**
```python
# Find affordable housing committee (Chapter 18)
ahac = df[df['NodeId'].str.contains('18-65', na=False) |
           df['Content'].str.contains('affordable housing advisory', case=False, na=False)]
```
- **One PAB member must actively serve on Affordable Housing Advisory Committee**
- Required membership composition

### Quick Reference: Search by Authority Type

```python
# Find all sections mentioning PAB approval authority
pab_approval = df[df['Content'].str.contains('planning advisory board.*approve', case=False, na=False, regex=True)]

# Find all sections mentioning PAB recommendation authority
pab_recommend = df[df['Content'].str.contains('planning advisory board.*recommend', case=False, na=False, regex=True)]

# Find all sections mentioning PAB review authority
pab_review = df[df['Content'].str.contains('planning advisory board.*review', case=False, na=False, regex=True)]

# Find all waiver authorities
waivers = df[df['Content'].str.contains('may be waived.*planning advisory board', case=False, na=False, regex=True)]
```

## Best Practices

### 1. Check for Content
Not all rows have content in the Content field. Some are just organizational headers:

```python
# Filter to only rows with actual content
has_content = df[df['Content'].notna() & (df['Content'].str.len() > 0)]

# Check if a section has content
section = df[df['NodeId'] == 'PTIIILADECO_CH14-4ZO']
if section['Content'].iloc[0]:
    print(section['Content'].iloc[0])
else:
    print("This is just a header section")
```

### 2. Display Results Clearly
When showing results, include relevant context:

```python
# Display search results with context
for idx, row in results.iterrows():
    print(f"Title: {row['Title']}")
    print(f"NodeId: {row['NodeId']}")
    print(f"Content preview: {row['Content'][:200]}...")
    print(f"URL: {row['Url']}")
    print("-" * 80)
```

### 3. Navigate Hierarchies
Get parent or child sections using NodeId:

```python
# Get all subsections of a chapter
chapter_prefix = 'PTIIILADECO_CH14-4ZO_'
subsections = df[
    df['NodeId'].str.startswith(chapter_prefix, na=False) &
    (df['NodeId'] != 'PTIIILADECO_CH14-4ZO')  # Exclude the parent
]

# Count sections by hierarchy level
df['hierarchy_level'] = df['NodeId'].str.count('_')
print(df.groupby('hierarchy_level').size())
```

### 4. Cross-Reference with URLs
The Url column provides links to official web versions:

```python
# Get official URL for a section
section = df[df['NodeId'] == 'PTIIILADECO_CH14-4ZO_14-4-1APOTSU']
official_url = section['Url'].iloc[0]
print(f"Official source: {official_url}")
```

## Example: Complete Workflow

Here's a complete example of analyzing a zoning question:

```python
import pandas as pd

# Load the code
df = pd.read_excel('./docs/KissimmeeFLCodeofOrdinancesEXPORT20250822.xlsx')

# Research question: What are the height restrictions for residential zoning?
# Step 1: Get all zoning sections
zoning = df[df['NodeId'].str.startswith('PTIIILADECO_CH14-4ZO', na=False)]

# Step 2: Search for height-related content within zoning
height_sections = zoning[
    zoning['Content'].str.contains('height', case=False, na=False)
]

# Step 3: Further filter for residential
residential_height = height_sections[
    height_sections['Content'].str.contains('residential', case=False, na=False)
]

# Step 4: Display results
for idx, row in residential_height.iterrows():
    print(f"\n{'='*80}")
    print(f"Section: {row['Title']}")
    print(f"NodeId: {row['NodeId']}")
    print(f"\nContent:\n{row['Content']}")
    print(f"\nOfficial URL: {row['Url']}")
```

## Troubleshooting

### Issue: No results found
- Check for typos in NodeId prefixes
- Use case-insensitive searches: `case=False`
- Try broader search terms first, then narrow down
- Check if section exists in the sections overview document

### Issue: Too many results
- Add more specific filters
- Search within a specific chapter using NodeId prefix
- Combine Title and Content filters

### Issue: Content appears truncated
- The Content field may contain very long text
- Use pandas display options: `pd.set_option('display.max_colwidth', None)`
- Or explicitly print the full content: `print(row['Content'])`

## Related Documents

- **Section Overview:** See `kissimmee-code-sections.md` for a complete listing of all chapters
- **Main Skill Instructions:** See `../SKILL.md` for integration into PAB workflows
- **Florida Statutes:** See `florida_statutes.md` for accessing state-level laws

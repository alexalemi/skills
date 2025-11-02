# Kissimmee GIS Data Guide: Zoning and Future Land Use

This guide explains how to use the GIS data files for determining zoning and future land use designations for parcels in Kissimmee.

## Overview

The PAB skill includes GIS shapefiles containing spatial data for:
1. **Future Land Use (FLU)** designations from the comprehensive plan
2. **Zoning Districts** from the land development code

These files allow you to determine what zoning and future land use apply to any location or parcel in Kissimmee.

## File Locations

**Data directory:** `./data/`

**Files:**
- `future_land_use.zip` (2.7 MB) - Future Land Use Map polygons
- `Zoning_Districts.zip` (2.1 MB) - Zoning district polygons

**Extracted shapefiles** (after unzipping):
- `future_land_use.shp` (+ .dbf, .prj, .shx, .cpg, .sbn, .sbx, .shp.xml)
- `zoning_districts.shp` (+ .dbf, .prj, .shx, .cpg, .sbn, .sbx, .shp.xml)

## Technical Specifications

### Coordinate Reference System

Both datasets use **NAD83 / Florida East (ftUS)** projection:
- **EPSG Code:** Not standard EPSG, custom Florida State Plane
- **Units:** US Survey Feet
- **Projection:** Transverse Mercator
- **Origin:** Latitude 24.333°, Longitude -81°

### Dataset Statistics

**Future Land Use:**
- **Feature Count:** 17 polygons
- **Geometry Type:** Polygon/MultiPolygon
- **Last Updated:** October 27, 2025
- **Extent:** (499923.82, 1424105.79) to (557742.70, 1459461.49) ft

**Zoning Districts:**
- **Feature Count:** 64 polygons
- **Geometry Type:** Polygon
- **Last Updated:** October 27, 2025
- **Extent:** (499925.51, 1424105.79) to (557742.70, 1459461.49) ft

---

## Future Land Use Data Structure

### Fields

| Field Name | Type | Description |
|------------|------|-------------|
| PROP_FLUM | String(20) | Future Land Use Map designation code (e.g., "MU-T", "SF-LDR") |
| FLU_NAME | String(50) | Full designation name (e.g., "MU-T (Tapestry)") |
| DENSITY | String(10) | Residential density limits (dwelling units per acre) |
| FAR | String(50) | Floor Area Ratio for non-residential uses |
| Shape_area | Real | Area of the polygon (square feet) |
| Shape_len | Real | Perimeter of the polygon (feet) |

### All Future Land Use Categories

| Code | Full Name | Category Type |
|------|-----------|---------------|
| AE | AE (Airport Expansion) | Airport/Special |
| CG | CG (Commercial General) | Commercial |
| CONS | CONS (Conservation) | Conservation |
| IN | IN (Industrial Business) | Industrial |
| INST | INST (Institutional) | Institutional |
| MF-HDR | MF-HDR (Multiple Family High Density Residential) | Residential |
| MF-MDR | MF-MDR (Multiple Family Medium Density Residential) | Residential |
| MH-MDR | MH-MDR (Mobile Home Medium Density Residential) | Residential |
| MU-D | MU-D (Downtown) | Mixed Use |
| MU-FR | MU-FR (Flora Ridge) | Mixed Use |
| MU-T | MU-T (Tapestry) | Mixed Use |
| MU-V | MU-V (Vine Street) | Mixed Use |
| OR | OR (Office Residential) | Mixed Use |
| REC | Recreation (REC) | Recreation |
| SF-LDR | SF-LDR (Single Family Low Density Residential) | Residential |
| SF-MDR | SF-MDR (Single Family Medium Density Residential) | Residential |
| UT | UT (Utilities) | Utilities |

**Total:** 17 designations

---

## Zoning Districts Data Structure

### Fields

| Field Name | Type | Description |
|------------|------|-------------|
| OBJECTID | Integer64 | Unique object identifier |
| ZONING_COD | String(10) | Zoning district code (e.g., "RS-1", "B-3", "T5-M") |
| LOT_WIDTH_ | Real | Minimum lot width (feet) |
| LOT_DEPTH_ | Real | Minimum lot depth (feet) |
| LOT_COVERA | Real | Maximum lot coverage (percentage) |
| HEIGHT | Real | Maximum building height (feet) |
| FAR | Real | Floor Area Ratio |
| SUMMARY_LI | String(100) | Summary description with minimum lot area |
| GlobalID | String(38) | Global unique identifier (GUID) |
| Front | String(50) | Front setback requirement (feet) |
| Side | String(50) | Side setback requirement (feet) |
| Street_Sid | String(50) | Street side setback requirement (feet) |
| Rear | String(50) | Rear setback requirement (feet) |
| LOT_AREA | Real | Minimum lot area (square feet) |
| DRC_NO | String(10) | Development Review Committee number |
| DocumentLi | String(250) | URL link to zoning classification information |
| Shape_STAr | Real | Area of the polygon (square feet) |
| Shape_STLe | Real | Perimeter of the polygon (feet) |

### All Zoning District Categories

| Code | Description | Type |
|------|-------------|------|
| AC | AC (Agricultural Conservation) | Agricultural |
| AI | AI (Airport Industrial) | Airport |
| AO | AO (Airport Operations) | Airport |
| B-2 | B-2 (Neighborhood Commercial) | Commercial |
| B-3 | B-3 (General Commercial) | Commercial |
| B-5 | B-5 (Office Commercial) | Commercial |
| BP | BP (Business Park) | Commercial/Industrial |
| CF | CF (Community Facility) | Institutional |
| HC | HC (Highway Commercial) | Commercial |
| HF | HF (Hospital Facility) | Institutional |
| IB | IB (Industrial Business) | Industrial |
| MH | MH (Mobile Home 6,000 sqft) | Residential |
| MHP | MHP (Mobile Home Park) | Residential |
| MUPUD | MUPUD (Mixed Use Planned Unit Development) | Mixed Use/PUD |
| OS | OS (Open Space) | Conservation |
| RA-1 | RA-1 (Single Family Residential) | Residential |
| RA-2 | RA-2 (Single Family Residential) | Residential |
| RA-3 | RA-3 (Single Family Residential) | Residential |
| RA-4 | RA-4 (Single Family Residential) | Residential |
| RB-1 | RB-1 (Medium Density Residential) | Residential |
| RB-2 | RB-2 (Medium Density Residential - Office) | Residential/Mixed |
| RC-1 | RC-1 (Multiple Family Medium Density Residential) | Residential |
| RC-2 | RC-2 (Multiple Family High Density Residential) | Residential |
| RE | RE (Residential Estate) | Residential |
| RPB | RPB (Residential Professional Business) | Mixed Use |
| RPUD | RPUD (Residential Planned Unit Development) | Residential/PUD |
| SD | SD (Special District) | Special |
| SRPUD | SRPUD (Short Term Rental Planned Unit Development) | Residential/PUD |
| T1 | T1 (Natural) | Form-Based Code |
| T3 | T3 (Edge) | Form-Based Code |
| T4-O | T4-O (Neighborhood Open) | Form-Based Code |
| T4-R | T4-R (Neighborhood Restricted) | Form-Based Code |
| T5-M | T5-M (Mixed-Use Center) | Form-Based Code |
| T5-U | T5-U (Mixed-Use Urban Core) | Form-Based Code |
| T6 | T6 (Waterfront) | Form-Based Code |
| UT | UT (Utilities) | Utilities |

**Total:** 36 unique zoning codes across 64 polygons

---

## Working with the Data

### Method 1: Python with GeoPandas (Recommended)

GeoPandas makes it easy to work with shapefiles and perform spatial queries.

#### Installation

```bash
pip install geopandas
```

#### Basic Loading and Exploration

```python
import geopandas as gpd
import pandas as pd

# Load the shapefiles
flu = gpd.read_file('data/future_land_use.shp')
zoning = gpd.read_file('data/zoning_districts.shp')

# Explore the data
print("Future Land Use categories:")
print(flu[['PROP_FLUM', 'FLU_NAME']].drop_duplicates())

print("\nZoning districts:")
print(zoning[['ZONING_COD', 'SUMMARY_LI']].drop_duplicates().sort_values('ZONING_COD'))

# View first few records
print(flu.head())
print(zoning.head())
```

#### Find What Zone/FLU Covers a Specific Point

```python
from shapely.geometry import Point

# Create a point (x, y in Florida State Plane feet)
# Example coordinates for a location in Kissimmee
point = Point(530000, 1450000)
point_gdf = gpd.GeoDataFrame({'geometry': [point]}, crs=flu.crs)

# Find which FLU polygon contains this point
flu_match = flu[flu.contains(point)]
if not flu_match.empty:
    print(f"Future Land Use: {flu_match.iloc[0]['FLU_NAME']}")
    print(f"Code: {flu_match.iloc[0]['PROP_FLUM']}")
    print(f"Density: {flu_match.iloc[0]['DENSITY']}")

# Find which zoning district contains this point
zone_match = zoning[zoning.contains(point)]
if not zone_match.empty:
    print(f"\nZoning: {zone_match.iloc[0]['ZONING_COD']}")
    print(f"Description: {zone_match.iloc[0]['SUMMARY_LI']}")
    print(f"Min Lot Area: {zone_match.iloc[0]['LOT_AREA']} sqft")
    print(f"Max Height: {zone_match.iloc[0]['HEIGHT']} feet")
    print(f"Setbacks - Front: {zone_match.iloc[0]['Front']}, "
          f"Side: {zone_match.iloc[0]['Side']}, Rear: {zone_match.iloc[0]['Rear']}")
```

#### Convert Lat/Lon to State Plane Coordinates

```python
from pyproj import Transformer

# Create transformer from WGS84 (lat/lon) to Florida State Plane East
transformer = Transformer.from_crs("EPSG:4326", flu.crs, always_xy=True)

# Example: Convert lat/lon to state plane
lat, lon = 28.3, -81.4  # Example coordinates
x, y = transformer.transform(lon, lat)
print(f"Lat {lat}, Lon {lon} => X {x:.2f}, Y {y:.2f}")

# Now use the converted coordinates
point = Point(x, y)
# ... proceed with spatial query as above
```

#### Query by Parcel Address (Requires Geocoding)

```python
from geopy.geocoders import Nominatim
from pyproj import Transformer

# Geocode an address
geolocator = Nominatim(user_agent="pab_skill")
address = "101 Church St, Kissimmee, FL"
location = geolocator.geocode(address)

if location:
    # Convert to state plane
    transformer = Transformer.from_crs("EPSG:4326", flu.crs, always_xy=True)
    x, y = transformer.transform(location.longitude, location.latitude)

    # Create point and query
    point = Point(x, y)
    flu_match = flu[flu.contains(point)]
    zone_match = zoning[zoning.contains(point)]

    print(f"Address: {address}")
    print(f"FLU: {flu_match.iloc[0]['FLU_NAME'] if not flu_match.empty else 'Not found'}")
    print(f"Zoning: {zone_match.iloc[0]['ZONING_COD'] if not zone_match.empty else 'Not found'}")
```

#### Generate Summary Report for a Location

```python
def get_parcel_info(x, y, flu_gdf, zoning_gdf):
    """
    Get comprehensive parcel information for given coordinates.

    Args:
        x, y: Coordinates in Florida State Plane East (feet)
        flu_gdf: GeoDataFrame with future land use data
        zoning_gdf: GeoDataFrame with zoning data

    Returns:
        dict: Dictionary with FLU and zoning information
    """
    point = Point(x, y)

    # Find FLU
    flu_match = flu_gdf[flu_gdf.contains(point)]
    flu_info = {
        'code': flu_match.iloc[0]['PROP_FLUM'] if not flu_match.empty else None,
        'name': flu_match.iloc[0]['FLU_NAME'] if not flu_match.empty else None,
        'density': flu_match.iloc[0]['DENSITY'] if not flu_match.empty else None,
        'far': flu_match.iloc[0]['FAR'] if not flu_match.empty else None,
    }

    # Find Zoning
    zone_match = zoning_gdf[zoning_gdf.contains(point)]
    zoning_info = {
        'code': zone_match.iloc[0]['ZONING_COD'] if not zone_match.empty else None,
        'description': zone_match.iloc[0]['SUMMARY_LI'] if not zone_match.empty else None,
        'min_lot_area': zone_match.iloc[0]['LOT_AREA'] if not zone_match.empty else None,
        'max_height': zone_match.iloc[0]['HEIGHT'] if not zone_match.empty else None,
        'setbacks': {
            'front': zone_match.iloc[0]['Front'] if not zone_match.empty else None,
            'side': zone_match.iloc[0]['Side'] if not zone_match.empty else None,
            'street_side': zone_match.iloc[0]['Street_Sid'] if not zone_match.empty else None,
            'rear': zone_match.iloc[0]['Rear'] if not zone_match.empty else None,
        },
        'lot_coverage': zone_match.iloc[0]['LOT_COVERA'] if not zone_match.empty else None,
        'far': zone_match.iloc[0]['FAR'] if not zone_match.empty else None,
    }

    return {'flu': flu_info, 'zoning': zoning_info}

# Usage
info = get_parcel_info(530000, 1450000, flu, zoning)
print("FLU:", info['flu'])
print("Zoning:", info['zoning'])
```

#### List All Zones with Their Requirements

```python
# Get unique zoning districts with their requirements
zones_summary = zoning.drop_duplicates(subset=['ZONING_COD']).sort_values('ZONING_COD')

print("Zoning Districts Summary:")
for idx, row in zones_summary.iterrows():
    print(f"\n{row['ZONING_COD']}: {row['SUMMARY_LI']}")
    print(f"  Min Lot Area: {row['LOT_AREA']} sqft")
    print(f"  Max Height: {row['HEIGHT']} ft")
    print(f"  Setbacks - F:{row['Front']} S:{row['Side']} R:{row['Rear']}")
    if row['LOT_COVERA'] > 0:
        print(f"  Lot Coverage: {row['LOT_COVERA']}%")
```

### Method 2: Command Line with ogrinfo/ogr2ogr

GDAL tools provide command-line access without Python.

#### Inspect Shapefile Metadata

```bash
# View structure and first few features
ogrinfo -al -so future_land_use.shp

# View all features
ogrinfo -al future_land_use.shp

# Query specific features
ogrinfo future_land_use.shp future_land_use -where "PROP_FLUM='MU-T'"
```

#### List All Categories

```bash
# List all FLU codes
ogrinfo -al future_land_use.shp | grep "PROP_FLUM\|FLU_NAME" | paste - - | sort -u

# List all zoning codes
ogrinfo -al zoning_districts.shp | grep "ZONING_COD\|SUMMARY_LI" | paste - - | sort -u
```

#### Export to Other Formats

```bash
# Convert to GeoJSON (more portable)
ogr2ogr -f GeoJSON future_land_use.geojson future_land_use.shp
ogr2ogr -f GeoJSON zoning_districts.geojson zoning_districts.shp

# Convert to CSV (loses geometry)
ogr2ogr -f CSV future_land_use.csv future_land_use.shp
ogr2ogr -f CSV zoning_districts.csv zoning_districts.shp
```

### Method 3: Desktop GIS Software

For visual exploration, use QGIS (free, open-source):

1. **Install QGIS:** https://qgis.org/
2. **Load Shapefiles:** Drag and drop .shp files into QGIS
3. **Identify Tool:** Click on any polygon to see its attributes
4. **Measure Tool:** Measure distances and areas
5. **Selection:** Select parcels by attributes or location

---

## Integration with PAB Resources

### Cross-Reference with Comprehensive Plan

The Future Land Use designations correspond to policies in the **Comprehensive Plan FLUE** (01_FLUE_Dec21.pdf):

- Each FLU code (e.g., "SF-LDR", "MU-T") has corresponding policies in FLUE Goal 1.2
- Density and FAR limits in the shapefile data should match comp plan policies
- Use the comp plan guide (`compplan-guide.md`) to find relevant policies

**Example Workflow:**
1. Find FLU designation using GIS data (e.g., "MU-T")
2. Look up "Multimodal Transportation District" or "MU-T" in FLUE
3. Review policies under Objective 1.2.11 (MMTD)

### Cross-Reference with Land Development Code

Zoning codes correspond to regulations in **LDC Chapter 14-4** (Zoning):

- Each zoning code (e.g., "RS-1", "B-3", "T5-M") is detailed in §14-4-6 or §14-4-7
- Dimensional standards in the shapefile should match LDC requirements
- Use the city code guide (`kissimmee-code-guide.md`) to search for zoning regulations

**Example Workflow:**
1. Find zoning district using GIS data (e.g., "T5-M")
2. Search LDC for "T5-M" or "Mixed-Use Center"
3. Review permitted uses, dimensional standards, and special requirements

### PAB Use Cases

**1. Comprehensive Plan Amendment Review**
- Check existing FLU designation for subject property
- Compare with proposed FLU designation
- Evaluate compatibility with surrounding FLU designations
- Reference comp plan policies for both existing and proposed designations

**2. Rezoning Application Review**
- Check existing zoning district for subject property
- Compare with proposed zoning district
- Verify that proposed zoning is consistent with FLU designation
- Check compatibility with surrounding zoning districts
- Verify dimensional requirements

**3. Conditional Use or Variance Review**
- Confirm current zoning district
- Look up dimensional requirements (setbacks, height, lot coverage)
- Evaluate proposed variance against established standards
- Check surrounding context

**4. Site Plan Review**
- Verify compliance with zoning dimensional requirements
- Check setbacks, height, lot coverage against shapefile data
- Confirm use is allowed in the zoning district

---

## Common Issues and Troubleshooting

### Issue: Point doesn't match any polygon

**Cause:** Coordinates may be in wrong projection or outside city limits

**Solution:**
- Verify coordinates are in Florida State Plane East (feet)
- Check if point is within Kissimmee city limits
- Convert lat/lon to state plane using transformer

### Issue: geopandas not installed

**Cause:** Package not available in environment

**Solution:**
```bash
pip install geopandas
# or
conda install geopandas
```

### Issue: Multiple polygons match a point

**Cause:** Overlapping polygons (e.g., special overlays)

**Solution:**
```python
# Get all matching polygons
matches = zoning[zoning.contains(point)]
for idx, row in matches.iterrows():
    print(f"{row['ZONING_COD']}: {row['SUMMARY_LI']}")
```

### Issue: Shapefile files scattered

**Cause:** Shapefiles consist of multiple files with same basename

**Solution:**
- Always keep all files together (.shp, .dbf, .prj, .shx, etc.)
- When moving/copying, move all files with the same basename
- geopandas/ogrinfo only needs the .shp filename but requires the other files

---

## Additional Resources

**Kissimmee GIS Portal:**
- https://kissimmee-gis-web-1-1-kissgis.hub.arcgis.com/

**Zoning Classifications Info:**
- https://www.kissimmee.gov/Business-Development/Development/Planning-Zoning/Find-Your-Propertys-Zoning-Category/Zoning-Classifications

**Related PAB Documentation:**
- Comprehensive Plan Guide: `compplan-guide.md`
- City Code Guide: `kissimmee-code-guide.md`
- Florida Statutes Guide: `florida_statutes.md`

---

## Quick Reference

### Python Quick Start

```python
import geopandas as gpd
from shapely.geometry import Point

# Load data
flu = gpd.read_file('data/future_land_use.shp')
zoning = gpd.read_file('data/zoning_districts.shp')

# Check a point (State Plane feet)
point = Point(530000, 1450000)
flu_match = flu[flu.contains(point)]
zone_match = zoning[zoning.contains(point)]

print("FLU:", flu_match.iloc[0]['FLU_NAME'] if not flu_match.empty else "Not found")
print("Zone:", zone_match.iloc[0]['ZONING_COD'] if not zone_match.empty else "Not found")
```

### Command Line Quick Start

```bash
# Extract files (if not already done)
cd data
unzip -o future_land_use.zip
unzip -o Zoning_Districts.zip

# View info
ogrinfo -al -so future_land_use.shp
ogrinfo -al -so zoning_districts.shp

# List categories
ogrinfo -al future_land_use.shp | grep "PROP_FLUM"
ogrinfo -al zoning_districts.shp | grep "ZONING_COD"
```

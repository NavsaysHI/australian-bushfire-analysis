# Australian Bushfire Analysis — September 2019

An analysis of Australian bushfire hotspots using NASA FIRMS VIIRS satellite data.
This project covers the early onset of the 2019–2020 Black Summer bushfire season,
analysing 96,152 fire detection hotspots across Australia during September 2019.

## Dashboard

**View the interactive Tableau dashboard here:**
(https://public.tableau.com/views/AustralianBushfireAnalysisSeptember2019/Dashboard1?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
![Dashboard Preview](dashboard_preview.png)

## Tools Used

- **Excel** — Data cleaning, column extraction, filtering
- **SQL (SQLite / DB Browser)** — Exploratory data analysis and insight generation
- **Tableau Public** — Interactive dashboard visualisation
- **NASA FIRMS** — VIIRS 375m satellite fire detection data

## Repository Structure

```
australian-bushfire-analysis/
│
├── data/
│   └── bushfire_clean.csv        # Cleaned dataset (96,152 rows)
│
├── sql/
│   └── bushfire_queries.sql      # All 5 SQL queries with comments
│
└── README.md
```

##  Data Source

- **Source:** NASA FIRMS (Fire Information for Resource Management System)
- **Satellite:** VIIRS 375m (Suomi NPP)
- **Coverage:** Australia — September 2019
- **Original dataset:** Kaggle — Australian Bush Fire Satellite Data (NASA)
- **Link:** https://www.kaggle.com/datasets/nagarajbhat/australian-bush-fire-satellite-data-nasa

## Data Cleaning Steps

1. Filtered to vegetation fires only (type = 0)
2. Removed low confidence detections (confidence = l)
3. Extracted month and year from acquisition date
4. Added month name column for readability
5. Removed unnecessary columns (scan, track, satellite, instrument, version)
6. Final clean dataset: 96,152 rows

## 🔍 SQL Analysis — Key Findings

### Finding 1 — Daily Hotspot Trend
- Peak fire activity occurred on **6–9 September 2019** with 6,000–6,800 hotspots per day
- Quietest day was **21 September** with only 1,025 detections
- Highest single-day peak intensity recorded on **10 September** at 479.2 MW

### Finding 2 — Regional Breakdown
| Region | Total Hotspots | Avg Intensity (MW) | Peak Intensity (MW) |
|---|---|---|---|
| Northern Territory | 30,409 | 10.01 | 575.0 |
| NSW/ACT | 26,186 | 8.13 | 479.2 |
| Western Australia | 26,026 | 9.44 | 360.4 |
| Queensland | 12,052 | 10.26 | 406.5 |
| Victoria | 1,024 | 6.24 | 102.9 |
| Tasmania | 344 | 9.67 | 298.4 |

### Finding 3 — Fire Detection by Hour
- Most detections occurred between **2am–6am** (satellite pass window)
- Hour 7 recorded the highest average intensity at **28.7 MW**

### Finding 4 — Top Fire Events
- Single most intense event: **NT, 30 September** at **575 MW**
- Second most intense: **NSW, 10 September** at **479.2 MW**
- Multiple 445 MW events clustered around **12 September in NSW**

### Finding 5 — Detection Confidence
- 90.9% nominal confidence detections — avg intensity 7.6 MW
- 9.1% high confidence detections — avg intensity 26.61 MW (3.5x more intense)

## Dashboard Features

- **Hotspot Map** — 96,152 fire points plotted on dark map, coloured and sized by Fire Radiative Power
- **Daily Trend** — Dual axis line chart showing daily hotspot count vs average fire intensity
- **Region Analysis** — Horizontal bar chart of hotspot count by Australian region
- **Top Fire Events** — Bubble chart of highest intensity events sized and coloured by FRP

## Author

**Navdeep (Nav)**
- GitHub: https://github.com/NavsaysHI
- LinkedIn: https://www.linkedin.com/in/navdeep-rao

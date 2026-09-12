# Airline Route Profitability & Operations Analytics

## Project Overview

This project analyzes airline route profitability and operational performance using Excel, MySQL, and Power BI.

The goal was to understand how route characteristics, passenger demand, aircraft utilization, operating costs, fleet allocation, and seasonality affect profitability.

The analysis covers 7,974 flight records and follows a complete analytics workflow:

**Raw Data → Data Audit & Cleaning → SQL Analysis → Power BI Dashboard → Business Insights → Recommendations**

Rather than focusing only on which routes were profitable, the project investigates why performance differed across routes and operational conditions.

## Business Problem

Airline profitability is influenced by more than passenger volume. Route characteristics, aircraft deployment, operating costs, demand levels, and seasonality can all affect whether a flight generates or destroys value.

The objective of this project was to evaluate the financial and operational performance of an airline's route network and identify the factors associated with differences in profitability.

The analysis focused on answering the following business questions:

- Which routes generate the highest and lowest profits and profit margins?
- How does profitability differ across short-, medium-, and long-haul routes?
- Are loss-making routes primarily associated with low passenger utilization, or are other factors involved?
- Which operating costs have the greatest impact on route economics?
- How does aircraft type and deployment relate to profitability and loss rates?
- How do demand levels and seasonality affect load factor and profitability?
- Where are the largest concentrations of financial losses?
- What operational or commercial areas could management investigate to improve route performance?

## Dataset Overview

The dataset contains 7,974 flight-level records representing operations from Dubai (DXB) across multiple destinations.

The original dataset contains 33 fields covering:

- Flight and route information
- Aircraft type and capacity
- Passenger volume and load factor
- Route category and demand level
- Ticket and ancillary revenue
- Operating cost components
- Total revenue and total cost
- Profit and profit margin
- Seasonality

The dataset includes short-, medium-, and long-haul routes operated using six aircraft types.

### Data Quality Issues Identified

During the initial audit, the dataset contained 792 missing values across three financial fields:

| Field | Missing Values |
|---|---:|
| Ancillary Revenue | 271 |
| Catering Cost | 265 |
| Handling Cost | 256 |
| **Total** | **792** |

No duplicate records were identified.

Missing financial values were investigated rather than automatically treated as zero. Where the underlying accounting relationships supported reconstruction, missing values were derived from the corresponding revenue or cost components.

## Data Audit & Cleaning

Before performing the analysis, the dataset was audited in Excel to verify the reliability of key financial and operational fields.

### Validation Checks

Temporary validation columns were created to test:

- Revenue consistency
- Profit calculation
- Load factor
- Profit margin
- Origin consistency
- Route construction
- Season classification

Origin, route, profit margin, and season classification were validated against their expected relationships.

Load factor was recalculated as:

**Passengers ÷ Aircraft Capacity**

Small differences were observed between the recalculated and recorded load factors. Investigation showed that these differences were consistent with rounding in the recorded values. A tolerance of **0.006** was therefore used for the final validation rather than requiring an exact match.

### Missing Value Treatment

Missing values were not automatically replaced with zero.

For missing **Ancillary Revenue**, the value was reconstructed using:

**Ancillary Revenue = Total Revenue − Ticket Revenue**

For missing **Catering Cost** and **Handling Cost**, the missing component was derived from Total Cost after accounting for the remaining recorded cost components.

All 792 originally missing financial values were resolved using these accounting relationships.

### Duplicate Check

The 33 original dataset fields were checked for duplicate records. No duplicate rows were identified.



\# **Data** Observations — Olist E-commerce Dataset



\## orders

\*\*Grain:\*\* 1 row = 1 order



\*\*Observations:\*\*

\- Orders exist in multiple lifecycle states (created, shipped, delivered, canceled, unavailable).

\- Only a subset of orders reach the `delivered` state.

\- Some orders have missing delivery dates, mostly tied to non-delivered statuses.



\*\*Implication:\*\*

\- Revenue and delivery analysis should consider only delivered orders to avoid incorrect results.



---



\## order\_items

\*\*Grain:\*\* 1 row = 1 item within an order



\*\*Observations:\*\*

\- A single order can contain multiple items.

\- Price and freight are stored at item level, not order level.

\- Item count per order varies significantly.



\*\*Implication:\*\*

\- The reporting fact table should be item-grained to prevent revenue duplication.



---



\## payments

\*\*Grain:\*\* 1 row = 1 payment record



\*\*Observations:\*\*

\- Orders can have multiple payment records.

\- Payment values are split across installments or payment methods.

\- Payment totals do not always align one-to-one with order totals.



\*\*Implication:\*\*

\- Payment data must be aggregated before joining and should not be used directly as revenue.



---



\## customers

\*\*Grain:\*\* 1 row = 1 customer



\*\*Observations:\*\*

\- Customers can place multiple orders over time.

\- Customer location (state, city) is consistent and usable for geography analysis.

\- Customer behavior (repeat vs one-time) is not explicitly stored.



\*\*Implication:\*\*

\- Repeat customer logic must be derived from order history.



---



\## products

\*\*Grain:\*\* 1 row = 1 product



\*\*Observations:\*\*

\- Products are mapped to categories, but some category values are missing or inconsistent.

\- Product data is relatively static compared to transactional tables.

\- Product performance depends on order\_items, not standalone product records.



\*\*Implication:\*\*

\- Product analysis must rely on joins with order\_items and handle unknown categories explicitly.



---



\## reviews

\*\*Grain:\*\* 1 row = 1 order review



\*\*Observations:\*\*

\- Not all delivered orders have reviews.

\- Review scores are subjective and optional.

\- Reviews are recorded after delivery completion.



\*\*Implication:\*\*

\- Review metrics should be treated as quality indicators, not mandatory performance measures.



---



\## delivery\_metrics (derived)

\*\*Grain:\*\* 1 row = 1 order



\*\*Observations:\*\*

\- Delivery time varies widely across orders and regions.

\- Missing delivery dates usually indicate incomplete or canceled orders.

\- Longer delivery durations often align with lower review scores.



\*\*Implication:\*\*

\- Delivery time is a key operational KPI and should be analyzed alongside customer satisfaction.




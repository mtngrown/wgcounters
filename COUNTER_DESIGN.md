# Wargame Counter Design — Canonical Geometry Context

## 1. Objective

Design square cardboard wargame counters (½″ and ⅝″ typical sizes) using a strict, factor-rich integer coordinate system to eliminate:

- subtle drift
- fractional alignment errors
- off-center NATO symbols
- inconsistent stroke weights
- typographic misalignment
- accumulation of manual placement artifacts

Goal:

Perfect structural parameterization first.
Then add intentional analog-style drift as a separate layer.

---

## 2. Canonical Master Coordinate System

### Master Grid Size: 1200 × 1200 units

Rationale:

1200 = 2⁴ × 3 × 5²

This provides clean divisibility for:

- 2, 4, 8, 16
- 3
- 5
- 6, 10, 12, 15, 20, 24, 25, etc.

This avoids the structural limitations of 1024 (2¹⁰), which lacks 3 and 5 factors.

---

## 3. Physical Counter Mapping

### ½″ Counter

½″ maps to 600 × 600 units.

600 is divisible by:
2, 3, 4, 5, 6, 8, 10, 12, 15, 20, 24, 25, etc.

### ⅝″ Counter (0.625″)

⅝″ maps to 750 × 750 units.

750 is divisible by:
2, 3, 5, 6, 10, 15, 25, etc.

Both sizes are integer-exact within the 1200 master grid.

No fractional scaling.

---

## 4. Structural Layer (Must Be Exact)

All geometry in this layer must be integer-aligned.

### 4.1 Outer Border

- Border inset: integer units
- Border stroke width: integer
- Corner radius: integer

### 4.2 Interior Zones (Canonical Template)

Example vertical layout for 600 or 750 space:

#### Option A — Third-Based

- Header: 1/3
- Center: 1/3
- Footer: 1/3

Exact integers:

600 → 200 / 200 / 200
750 → 250 / 250 / 250

#### Option B — 5-Unit Banding

Example:

- Header: 20%
- Center: 60%
- Footer: 20%

600 → 120 / 360 / 120
750 → 150 / 450 / 150

Zone heights must always be integer.

---

## 5. Alignment Rules

### 5.1 Geometric Centering

All primary symbols positioned by:

- exact center coordinates
- integer midpoint arithmetic

### 5.2 Optical Correction Layer (Optional but Controlled)

Optical nudges allowed:

- ±1–3 units
- must be systematic per symbol type
- never arbitrary per counter

Same symbol → same correction.

---

## 6. Stroke System

Define canonical stroke weights relative to grid.

Example for 600 base:

- Thin stroke: 6 units
- Heavy stroke: 12 units
- Divider lines: 6 units
- Outer border: 12–18 units

For 750 base:

Scale proportionally but remain integer.

No fractional stroke widths allowed in structural layer.

---

## 7. Typography System

- Single type family
- Fixed sizes (e.g., header size, stat size)
- Fixed tracking
- Fixed baseline grid alignment

All text bounding boxes must align to integer grid coordinates.

Numerals should align on consistent vertical metric.

---

## 8. Symbol Library Policy

All reusable elements (must not be redrawn manually):

- NATO frames
- echelon indicators
- arrows
- step dots
- strength boxes
- size markers

Each symbol:

- defined once
- snapped to grid
- stored as canonical reusable asset
- never freehand-adjusted per counter

---

## 9. Drift Layer (Analog Simulation)

Drift must only be applied after structural layer is perfect.

### 9.1 Drift Characteristics

- Low-frequency noise
- Slight correlated distortion
- Not independent random jitter per vertex
- Directionally biased (simulating rapidograph inking)

### 9.2 Acceptable Drift Parameters

- Positional jitter: ±1–3 units
- Stroke variation: ±1 unit
- Minor curvature variation
- Micro-rotation < 0.5°

Drift should be deterministic if seeded or parameterized by noise function.

Never structural.

---

## 10. Implementation Principles

1. Structural geometry must remain integer-exact.
2. No fractional coordinates.
3. No floating drift unless in designated analog layer.
4. All composition rules must be encoded in template.
5. Manual placement must be prohibited unless snapping enabled.

---

## 11. Why 1200 Instead of 1024

1024 = 2¹⁰
Lacks 3 and 5 factors.

Results in:

- fractional thirds
- fractional fifths
- subtle compositional drift
- weaker grid expressiveness

1200 enables:

- binary harmony
- third-based layouts
- fifth-based proportional systems
- clean mapping to ½″ and ⅝″ counters

---

## 12. Design Philosophy

Separate:

Layer 1 — Perfect Rational Geometry
Layer 2 — Optical Correction
Layer 3 — Analog Drift Simulation

Never mix them.

Accidental slop is eliminated.
Intentional imperfection becomes controllable.


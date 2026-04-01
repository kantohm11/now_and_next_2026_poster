# iTHEMS Now & Next 2026 Poster — Design Spec

## Format

- A0 portrait (841 x 1189 mm), two-column layout
- Typst with Pollux template
- Bibliography: `references.bib`, `springer-mathphys` citation style

## Tooling

- **Typst** (to be installed)
- **Pollux** package for A0 two-column academic poster
- **fletcher** for commutative diagrams
- **cetz** overlay (via fletcher's `render` callback) if needed for custom shapes
- Native Typst `.bib` support for references

## Source Material

- `span_enforcing/` submodule: Quarto slides from Simons Collaboration Annual Meeting 2025
- Content is adapted (not copy-pasted) — restructured for poster format

## Content Structure

### Left Column: Pedagogical Introduction

Target audience: broad, including mathematical biologists and non-specialists.

1. **What physicists do** — microscopic theory to macroscopic predictions. Adapt slide 1 visual: QFT.svg (microscopic), copper wire photo (gapless/conductor), tires photo (gapped/insulator), connected by arrows with "?" — recreated in Typst layout.
2. **Symmetry as a bridge** — shared property between micro and macro worlds. Charge conservation as intuitive example: if conserved microscopically, also conserved macroscopically. (Mainly about internal symmetry, which is less intuitive than spacetime symmetry.)
   - **New illustration needed**: pictorial style — physical imagery (particles → bulk material) with a symmetry constraint bridging them. Concrete design TBD during implementation.
3. **'t Hooft anomaly matching** — existing known criterion using symmetry to constrain IR physics
4. **New proposal (span enforcing)** — a new criterion, complementary to anomaly matching, realized on lattice/discrete systems

### Right Column: Technical Content

Focus on main logic and examples. Skip module categories details.

1. **The span setup** — $\mathcal{D} \leftarrow \mathcal{E} \rightarrow \mathcal{C}$ and the condition (no compatible TQFT pair implies gaplessness)
2. **Focused situation** — 1+1d, continuous $G$, finite subgroup $H$
3. **Examples** (text + one diagram each where needed, avoiding repetitive diagrams):
   - $\mathrm{U}(1)$ + $\mathrm{TY}(\mathbb{Z}_2)$ (Kramers-Wannier duality)
   - XX chain
   - $\mathrm{U}(1)$-invariant clock model
4. **Outlook**
   - Systematically study and find Hamiltonians preserving gaplessness-enforcing spans (seeking collaborators)
   - Higher dimensions

## Diagrams to Port (fletcher)

Only two commutative diagrams selected (poster avoids repetitive variants):

| Name | Description | Poster section |
|------|-------------|----------------|
| `symmetry-span-G-H` | General span: $\mathrm{Vect}_H \to \mathcal{C}$, $\mathrm{Vect}_H \to \mathbf{Vect}_G$ | Main logic |
| `symmetry-span-U1-TY-lattice` | $\mathrm{U}(1)$ + $\mathrm{TY}(\mathbb{Z}_2)$ lattice span | XX chain example |

## Non-TikZ Figures

From slide 1 (to be adapted in Typst):
- `QFT.svg` — Inkscape drawing of microscopic physics
- `copper_wire.jpg` / `tires.jpeg` — photos for gapless vs gapped
- Layout with arrows and "?" connecting micro to macro outcomes

New:
- "Symmetry as a bridge" illustration — pictorial, physical imagery (particles → bulk material) with symmetry constraint bridging them. Design TBD.

## What is NOT included

- Module categories details (even in technical part)
- Full categorical machinery — focus on the core argument and illustrative examples
- Mexican hat potential (deferred; can render as SVG and embed later if needed)
- Diagrams from: span-diagram-surround, span-TQFT, RG_flow, compact boson, invertible example, Rep(D₈), 3+1d Maxwell

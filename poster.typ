#import "@preview/pollux:0.1.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

// Theme
// iTHEMS brand colors
#set-theme(steel-blue)
#update-theme(
  lang: "en",
  heading-color: rgb("#B50000"),
  fill-color: rgb("#B50000"),
  stroke-color: rgb("#690000"),
)

// Layout
#set page("a0", margin: 0cm)
#set-poster-layout(layout-a0)
#set columns(gutter: 2.0em)

// Text size for A0
#set text(size: 24pt)

// Math font
#show math.equation: set text(font: "New Computer Modern Math")

// --- Fletcher diagram functions ---

#let span-diagram-G-H() = fletcher.diagram(
  cell-size: 25mm,
  node-stroke: none,
  node((0, 0), $"Vect"_H$),
  node((1, 0), $cal(C)$),
  node((0, 1), $bold("Vect")_G^(omega=0)$),
  edge((0, 0), (1, 0), $i_(cal(C))$, "hook->"),
  edge((0, 0), (0, 1), $i_(cal(D))$, "hook->", label-side: right),
)

#let span-diagram-U1-TY-lattice() = fletcher.diagram(
  cell-size: 25mm,
  node-stroke: none,
  node((0, 0), $"Vect"_(ZZ_2)$),
  node((1, 0), $"TY"(ZZ_2)_"lattice"$),
  node((0, 1), $bold("Vect")_("U"(1))^(omega=0)$),
  edge((0, 0), (1, 0), $i_(cal(C))$, "hook->"),
  edge((0, 0), (0, 1), $i_(cal(D))$, "hook->", label-side: right),
)

// --- Title ---

// Custom title box with logo
#rect(
  inset: 0.5em,
  width: 100%,
  fill: rgb("#B50000"),
  stroke: rgb("#690000"),
)[
  #set text(fill: white, weight: "regular")
  #grid(
    columns: (auto, 1fr, auto),
    align: (left + horizon, center + horizon, right + horizon),
    column-gutter: 1em,
    // Left: iTHEMS logo
    pad(left: 1em, image("ithems_logo.svg", height: 4em)),
    // Center: title and authors
    [
      #v(25pt)
      #set align(center)
      #text(size: 75pt)[Symmetry Spans and Enforced Gaplessness]
      #v(1.4em, weak: true)
      #text(size: 55pt)[Takamasa Ando¹, #underline[Kantaro Ohmori]²]
      #v(1.2em, weak: true)
      #text(size: 40pt)[¹Yukawa Institute for Theoretical Physics, ²RIKEN iTHEMS]
      #v(25pt)
    ],
    // Right: spacing to balance
    pad(right: 1em, box(width: 4em * 4)),
  )
]
#v(-1.0cm)

// --- Main content ---

#box(inset: 2.0cm)[
#columns(2, [

// ========================================
// LEFT COLUMN: Pedagogical Introduction
// ========================================

#column-box(heading: "Bridging Scales")[

  #align(center)[
    _Constrain IR from UV symmetry. Engineer UV from IR targets._
  ]
  #v(0.5em)

  #import fletcher.cetz as cetz
  #grid(
    columns: (auto, 1fr, auto),
    align: (center + top, center + horizon, left + top),
    column-gutter: 0.3em,
    // Left: microscopic model
    [#align(center)[
      *Microscopic model*
      #image("span_enforcing/pictures/QFT.svg", width: 10em)
    ]],
    // Center: diverging double arrows with "?"
    [#cetz.canvas(length: 1em, {
      import cetz.draw: *
      // Upper arrow (both-side)
      line((-2, 0.4), (2, 1.4), stroke: 6pt, mark: (start: "stealth", end: "stealth", fill: black, scale: 1.8))
      // Lower arrow (both-side)
      line((-2, -0.4), (2, -1.4), stroke: 6pt, mark: (start: "stealth", end: "stealth", fill: black, scale: 1.8))
      // "?" label
      content((0, 0), text(weight: "bold", size: 48pt)[?])
    })],
    // Right: macroscopic phenomena
    [#align(center)[
      *Macroscopic phenomena*
    ]
    #v(0.3em)
    #stack(dir: ttb, spacing: 1.2em,
      grid(columns: (4em, auto), gutter: 0.4em, align: (center + horizon, left + horizon),
        image("span_enforcing/pictures/copper_wire.jpg", height: 2.5em),
        [_gapless_ \ (conductor)],
      ),
      grid(columns: (4em, auto), gutter: 0.4em, align: (center + horizon, left + horizon),
        image("span_enforcing/pictures/tires.jpeg", height: 2.5em),
        [_gapped_ \ (insulator)],
      ),
    )],
  )
]

#v(0.8em)

#column-box(heading: "Symmetry Classifies Phases")[

  Spins on a lattice with *SO(3) rotation symmetry* can realize different macroscopic phases:

  #align(center)[
    #image("pictures/ferromagnetism.pdf", width: 55%)
  ]

  - *Ferromagnet* — SO(3) spontaneously broken, gapless (magnons)
  - *Paramagnet* — SO(3) preserved, gapped

  Can symmetry do more than classify? \
  Can it *force* gaplessness — exclude all gapped phases?
]

#v(0.8em)

#column-box(heading: [Existing Tool: 't Hooft Anomaly Matching])[

  An *anomaly* is a quantum property of a symmetry that persists across scales.
  When a *continuous* symmetry $G$ has an anomaly ($omega != 0$),
  the IR theory *must be gapless*.

  #align(center)[
    #emph[Can we find *other* symmetry properties that enforce gaplessness?]
  ]
]

#v(0.8em)

#column-box(heading: "New Proposal: Symmetry Span Criterion")[

  Consider *two* symmetries $cal(C)$ and $cal(D)$ acting on a theory,
  sharing a common sub-symmetry $cal(E)$:

  #align(center)[#span-diagram-G-H()]

  If their TQFT categories have *trivial intersection*
  over $cal(E)$, then the IR theory must be *gapless*!

  - Directly applicable to *lattice systems*.
  - Complementary to anomaly matching.

  Based on Ando--Ohmori (2026) @Ando:2026ffy.
]


#colbreak()


// ========================================
// RIGHT COLUMN: Technical Content
// ========================================

#column-box(heading: [The Span Setup: 1+1d, continuous $G$, finite $H$])[

  - $cal(D) = bold("Vect")_G^(omega=0)$: continuous symmetry ($G$ connected)
  - $cal(C)$: (possibly non-invertible) finite symmetry
  - $cal(E) = "Vect"_H$: finite subgroup $H subset G$
  - $"TQFT"(G) tilde.eq NN[G"-SPTs"]$ (no SSB for connected $G$)

  *Criterion:* If
  $i_(cal(C))^* "TQFT"(cal(C)) inter i_(cal(D))^* "TQFT"(G) = {0}$,
  the system admits no symmetric TQFT — it must be gapless.
]

#v(0.8em)

#column-box(heading: [$"U"(1) + "TY"(ZZ_2)$: Kramers--Wannier Duality])[

  - $i_(cal(C))^* "TQFT"("TY"(ZZ_2))
    = NN[("Vect"_(ZZ_2) plus.o "Vect")]$
    - $"SSB"_(ZZ_2)$ and $"triv"_(ZZ_2)$ exchanged by KW duality
  - $i_(cal(D))^* "TQFT"("U"(1)) tilde.eq NN["Vect"]$
  - Intersection $= {0}$ #sym.arrow.r.double *no symmetric TQFT!*
]

#v(0.8em)

#column-box(heading: "XX Chain (Lattice Realization)")[

  #align(center)[#span-diagram-U1-TY-lattice()]

  Spin chain $cal(H) = limits(times.o)_j CC^2_j$ with:
  - KW duality $"TY"(ZZ_2)_"lattice"$ and $"U"(1)$: $Q = sum_j X_j$
  - $H = sum_j (Y_j Z_(j+1) - Z_j Y_(j+1))$
    $arrow.squiggly^("RG")$ compact boson at $R = sqrt(2) R_("s.d.")$
  - Span generates *Onsager algebra*
    $arrow.squiggly^("RG")$ $"U"(1)^"shift" times "U"(1)^"wind"$ with mixed anomaly
]

#v(0.8em)

#column-box(heading: [$"U"(1)$-Invariant $ZZ_N$ Clock Chain])[

  - $cal(H) = limits(times.o)_j CC^N_j$, with $X^N = Z^N = 1$,
    $X Z = e^(2 pi i \/ N) Z X$
  - Same span structure with $"TY"(ZZ_N)_"lattice"$
  - Generates *Onsager algebra*
  - Symmetric *interacting* Hamiltonian
  - RG flow: $c = 1, 3(n-1) \/ (n+1)$ (integrable)
]

#v(0.8em)

#column-box(heading: "Outlook")[

  - *Systematic Hamiltonian search:*
    Find lattice Hamiltonians preserving gaplessness-enforcing spans
    — _seeking collaborators!_
  - *Higher dimensions:*
    The span criterion extends naturally;
    e.g. 3+1d Maxwell theory at special coupling.
]

#v(0.8em)

#bibliography("span_enforcing/references.bib",
  style: "springer-mathphys-brackets.csl",
  title: "References",
)

])
]


#bottom-box()[
  Supported by RIKEN iTHEMS.
  arXiv: 2602.11696
]

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

// --- Callout blocks ---

#let _callout(body, symbol, accent) = {
  let bar-width = 36pt
  block(width: 100%, radius: 4pt, clip: true, stroke: 1pt + accent, fill: accent.lighten(92%), above: 0.6em, below: 0.6em)[
    #place(left)[
      #rect(width: bar-width, height: 100%, fill: accent, stroke: none)
    ]
    #place(left + horizon)[
      #box(width: bar-width)[
        #align(center)[#text(fill: white, weight: "bold", size: 30pt)[#symbol]]
      ]
    ]
    #pad(left: bar-width + 0.5em, rest: 0.5em)[#body]
  ]
}

#let callout-question(body) = _callout(body, "?", rgb("#2266AA"))
#let callout-important(body) = _callout(body, "!", rgb("#CC2222"))

// --- Fletcher diagram functions ---

#let span-diagram-full() = image("pictures/span_diagram_full.pdf", height: 6em)

#let span-diagram-U1-TY-lattice() = fletcher.diagram(
  cell-size: (25mm, 18mm),
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
    columns: (16em, 1fr, 16em),
    align: (left + horizon, center + horizon, right + horizon),
    column-gutter: 1em,
    // Left: iTHEMS logo
    pad(left: 1.5em, image("ithems_logo.svg", height: 3.5em)),
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
    // Right: arXiv link
    pad(right: 1.5em)[
      #align(center)[
        #text(size: 36pt)[arXiv:] \
        #link("https://arxiv.org/abs/2602.11696")[#text(size: 36pt)[2602.11696]] \
        #text(size: 24pt)[@Ando:2026ffy]
      ]
    ],
  )
]
#v(-1.5cm)

// --- Main content ---

#box(inset: 2.0cm)[
#columns(2, [

// ========================================
// LEFT COLUMN: Pedagogical Introduction
// ========================================

#align(center)[#text(size: 28pt, style: "italic", fill: gray.darken(20%))[#underline[Overview]]]
#v(0.1em)

#column-box(heading: "Bridging Scales")[

  #align(center)[
    _Constrain IR from UV symmetry. Engineer UV from IR targets._
  ]
  #v(0.3em)

  #import fletcher.cetz as cetz
  #grid(
    columns: (auto, 1fr, auto),
    align: (center + top, center + horizon, left + top),
    column-gutter: 0.3em,
    // Left: microscopic model
    [#align(center)[
      *Microscopic model*
      #image("span_enforcing/pictures/QFT.svg", width: 8em)
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

#v(0.15em)

#column-box(heading: "Symmetry Classifies Phases")[

  Spins on a lattice with *SO(3) rotation symmetry* can realize different phases:

  #align(center)[
    #image("pictures/ferromagnetism.pdf", width: 40%)
  ]

  - *Ferromagnet* : SO(3) spontaneously broken, gapless 
  - *Paramagnet* : SO(3) preserved, gapped

  #callout-question[
    Can symmetry do more than classify? \
    Can it *force* gaplessness — exclude all gapped phases?
  ]
]

#v(0.15em)

#column-box(heading: [Existing Tool: 't Hooft Anomaly Matching])[

  An *anomaly* is a quantum property of a symmetry that persists across scales.

  #callout-important[
    *'t Hooft (1980)*: when a *continuous* symmetry $G$ has an anomaly ($omega != 0$),
    the IR theory *must be gapless*.
  ]

  However, perturbative anomalies cannot be realized on a lattice.

  #callout-question[
    Can we find *other* symmetry properties that enforce gaplessness?
  ]
]

#v(0.15em)

#column-box(heading: "New Proposal: Symmetry Span Criterion")[

  A *lattice alternative* to 't Hooft anomaly matching.

  Consider *two* symmetries $cal(C)$ and $cal(D)$ acting on a theory,
  sharing a common sub-symmetry $cal(E)$:

  #align(center)[
    #import fletcher.cetz as cetz
    #cetz.canvas(length: 1.5em, {
      import cetz.draw: *

      // --- Left: Symmetry side ---
      let cx = -4.2
      let ca = (cx, 0.5)
      let cb = (cx, -0.5)
      let rx = 1.8
      let ry = 1.3
      // Draw fills
      circle(ca, radius: (rx, ry), stroke: none, fill: rgb("#CC6622").lighten(88%))
      circle(cb, radius: (rx, ry), stroke: none, fill: rgb("#2266AA").lighten(88%))
      // Find intersection and fill with gray
      intersections("si", {
        circle(ca, radius: (rx, ry), stroke: none, fill: none)
        circle(cb, radius: (rx, ry), stroke: none, fill: none)
      })
      merge-path(close: true, fill: rgb("#555555").lighten(75%), stroke: none, {
        arc-through("si.0", (cx, 0.5 - ry), "si.1")
        arc-through("si.1", (cx, -0.5 + ry), "si.0")
      })
      // Draw borders on top
      circle(ca, radius: (rx, ry), stroke: 2.5pt + rgb("#CC6622"), fill: none)
      circle(cb, radius: (rx, ry), stroke: 2.5pt + rgb("#2266AA"), fill: none)
      // Labels
      content((cx, 1.4), text(weight: "bold", size: 28pt)[$ cal(C) $])
      content((cx, -1.4), text(weight: "bold", size: 28pt)[$ cal(D) $])
      content((cx, 0), text(weight: "bold", size: 26pt)[$ cal(E) $])
      content((cx, -2.5), text(size: 28pt)[Symmetries])

      // --- Arrow ---
      line((-1.5, 0), (1.5, 0), stroke: 2.5pt, mark: (end: "stealth", fill: black, scale: 1.4))
      content((0, 0.6), text(size: 17pt)[gapped phases])

      // --- Right: Gapped phases side ---
      circle((4.2, 0), radius: (2.4, 1.8), stroke: 2.5pt + rgb("#555555"), fill: rgb("#555555").lighten(92%))
      circle((3.1, 0.4), radius: (1.0, 0.7), stroke: 2.5pt + rgb("#CC6622"), fill: rgb("#CC6622").lighten(82%))
      circle((5.3, -0.4), radius: (1.0, 0.7), stroke: 2.5pt + rgb("#2266AA"), fill: rgb("#2266AA").lighten(82%))
      // Labels
      content((3.1, 0.4), text(size: 23pt)[$cal(C)$-phases])
      content((5.3, -0.4), text(size: 23pt)[$cal(D)$-phases])
      content((4.2, -1.3), text(size: 23pt)[$cal(E)$-phases])
      content((4.2, -2.5), text(size: 28pt)[Gapped phases])
      // "no overlap" indicator
      content((4.2, 0.0), text(weight: "bold", size: 24pt, fill: rgb("#CC2222"))[$ emptyset $])
    })
  ]

  #callout-important[
    If no gapped $cal(E)$-phase can be simultaneously
    a $cal(C)$-phase and a $cal(D)$-phase,
    then the theory must be *gapless*!
  ]

  In all examples, the span generates a continuous symmetry
  with anomaly macroscopically. \
  #sym.arrow.r *Lattice alternative of continuous 't Hooft anomaly!*

  #callout-question[
    Systematic constructions and discoveries of gapless lattice systems based on symmetry spans?
  ]
]


#colbreak()


// ========================================
// RIGHT COLUMN: Technical Content
// ========================================

#align(center)[#text(size: 28pt, style: "italic", fill: gray.darken(20%))[#underline[Technical Details]]]
#v(0.1em)

#column-box(heading: [The Span Setup: 1+1d, continuous $G$, finite $H$])[

  #align(center)[#span-diagram-full()]

  - $cal(D) = bold("Vect")_G^(omega=0)$: continuous symmetry ($G$ connected)
  - $cal(C)$: (possibly non-invertible) finite symmetry
  - $cal(E) = "Vect"_H$: finite subgroup $H subset G$
  - $"TQFT"(G) tilde.eq NN[G"-SPTs"]$ (no SSB for connected $G$)

  *Criterion:* If
  $i_(cal(C))^* "TQFT"(cal(C)) inter i_(cal(D))^* "TQFT"(G) = {0}$,
  the system admits no symmetric TQFT — it must be gapless.
]

#v(0.15em)

#column-box(heading: [$"U"(1) + "TY"(ZZ_2)$: Kramers--Wannier Duality])[

  - $i_(cal(C))^* "TQFT"("TY"(ZZ_2))
    = NN[("Vect"_(ZZ_2) plus.o "Vect")]$
    - $"SSB"_(ZZ_2)$ and $"triv"_(ZZ_2)$ exchanged by KW duality
  - $i_(cal(D))^* "TQFT"("U"(1)) tilde.eq NN["Vect"]$
  - Intersection $= {0}$ #sym.arrow.r.double *no symmetric TQFT!*
]

#v(0.15em)

#column-box(heading: "XX Chain (Lattice Realization)")[

  #align(center)[#span-diagram-U1-TY-lattice()]

  Spin chain $cal(H) = limits(times.o)_j CC^2_j$ with:
  - KW duality $"TY"(ZZ_2)_"lattice"$ and $"U"(1)$: $Q = sum_j X_j$
  - $H = sum_j (Y_j Z_(j+1) - Z_j Y_(j+1))$
    $arrow.squiggly^("RG")$ compact boson at $R = sqrt(2) R_("s.d.")$
  - Span generates *Onsager algebra*
    $arrow.squiggly^("RG")$ $"U"(1)^"shift" times "U"(1)^"wind"$ with mixed anomaly
]

#v(0.15em)

#column-box(heading: [$"U"(1)$-Invariant $ZZ_N$ Clock Chain])[

  - $cal(H) = limits(times.o)_j CC^N_j$, with $X^N = Z^N = 1$,
    $X Z = e^(2 pi i \/ N) Z X$
  - Same span structure with $"TY"(ZZ_N)_"lattice"$
  - Generates *Onsager algebra*
  - Symmetric *interacting* Hamiltonian
  - RG flow: $c = 1, 3(n-1) \/ (n+1)$ (integrable)
]

#v(0.15em)

#column-box(heading: "Outlook")[

  - *Systematic Hamiltonian search:*
    Find lattice Hamiltonians preserving gaplessness-enforcing spans
    — _seeking collaborators!_
  - *Higher dimensions:*
    The span criterion extends naturally;
    e.g. 3+1d Maxwell theory at special coupling.
]

#v(0.3em)

#bibliography("span_enforcing/references.bib",
  style: "springer-mathphys-brackets.csl",
  title: "References",
)

])
]

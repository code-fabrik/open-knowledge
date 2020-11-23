# Glossary

## Symbol

The schematic representation of a component. This only describes the interface
(number of pins) and what the function of a specific part is.

## Footprint

Physical representation of a component, including the position of the pins
(also called "Land Pattern").

## Pads

Areas on which the copper of the circuit board will be exposed. Those area can
be soldered.

## Mil

Mil is a distance unit often used in PCB design and is equal to 1/1000th of an
inch. 100 mil are 2.54mm, which is the usual spacing between pins.

## Courtyard

The area where no other components must be placed, defined by the manufacturing
capabilities and physical size of eventual protrusions of the components.

## Layers

A PCB consists of multiple layers that are produced in a different way. Some
layers have an F.* and a B.* version, which means front and back.

* Cu: Copper layers
* Silk: Artwork on the silkscreen layers. Component outlines or polarity
markers
* Mask: Area **free** of soldermask, e.g. where the copper is exposed
* Paste: Area to be covered by solder paste (a.k.a. stencil)
* Edge.cuts: Board shape
* Adhes: adhesive area, for bottom mounted SMD during manufacturing
* CrtYd: Courtyard area (see courtyard), place to be left free from other
components
* Fab: Documentation for the assembly process

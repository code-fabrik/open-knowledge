# KiCad

## Intro

In KiCad, a PCB project consists of a schematic and the PCB layout. The schematic defines which components are present and what connections exist. The PCB layout then defines the traces and planes of the finished PCB.

## Creating the schematic

First, you need to create the schematic for the desired PCB. Open the Schema Editor to get started.

Drawing the schema consists of three tasks: placing components, placing power ports and drawing connections. All three items can be selected in the right menu bar or accessed with the keyboard shortcuts A (add component), P (add power port) and W (place wire).

As in all other parts of the program, you can also use M (move component), R (rotate component) and DEL (delete component).

Once you have completed the schematic, add values to the components (such as resistor value or capacitor capacity) by hovering the component and pressing V (add value). Move the values to some place where they do not interfere with your work.

Some common components:

| Component | Name |
|----|----|
| Resistor | Device:R |
| Header pin | Connector_Generic:Conn_MMxNN |

## Adding the footprints

Component footprints are managed separately from the schematic symbols. In this second step, you need to assign a footprint to every component. To do so, open `Tools` > `Assign Footprints` or use the Footprint menu item in the top menu bar.

The opening window displays a list of all your components, along with a list of possible footprints to assign to the components. Select one of your components, find the corresponding footprint and double click it to assign it.

Some common footprints:

| Component | Footprint |
|----|----|
| Resistor | Resistor_THT:R_Axial_DIN0207 (6.3x2.5mm) |
| Any IC | Package_DIP:DIP (any number of pins) |
| Header pin | Connector_PinHeader_2.54mm (any number of pins) |

## Generating the netlist

Use the top menu bar or `Tools` > `Generate netlist file` to generate the netlist and save it into the same folder as the project resides.

## Drawing the PCB

Open the PCB Layout Editor to draw the PCB. First, you need to import the netlist similarly to how you created it in the Schema Editor. All components will appear packed together on the PCB.

Use the same shortcuts as in the Schematic Editor to position and rotate the components. Move the resistor and capacitor values to their appropriate locations. Try to untangle the connection lines as far as possible.

The right sidebar lists all possible layers and tools you can use. The most important are the following:

| Layer | Description |
|---|---|
| F.Cu and B.Cu | Front and Back Copper Layer (Traces) |
| F.SilkS and B.SilkS | Front and Back Silkscreen (Labels and Text) |
| F.Mask and B.Mask | Front and Back Solder Mask (Coating on top of traces) |
| Edge.Cuts | Cut lines for PCB edge |

Select a layer, then the "Route Tracks" tool and start drawing. To create a conductive plane, use the "Filled Zones" tool. It allows you to select the electric level it should have and automatically connects to all corresponding pads.

To create a via, draw a wire and press V (create via) to place a via at the current cursor position.

In the end, create the edge cuts by selecting the "Edge.Cuts" layer and using the "Graphic lines" tool.

## Design Rule Check

Use `Inspect` > `Design Rule Check` or the bug in the top menu bar to perform a DRC. Make sure all pads are connected and no traces are too close to each other.

## Visual Check

Use `View` > `3D-Viewer` to check your PCB in the graphical view.

## Export

Use `File` > `Plot` or the Plotter top menu bar item to export the Gerber files. Enable the "Use Protel filename extensions" checkmark and export the following layers:

* F.Cu and B.Cu
* F.SilkS and B.SilkS
* F.Mask and B.Mask
* Edge.Cuts

Export those files whereever you want.

Additionally create the drill files by clicking the "Generate Drill Files" button. Leave all options as they are.

## Printing

If you want to print the PCB using a service like DirtyPCB, you need to rename the Edge file from `.gm1` to `.gko`.

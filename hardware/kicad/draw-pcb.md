# Drawing the PCB

![pcb editor icon](images/pcb-editor.png)

Open the PCB Layout Editor to draw the PCB. First, you need to import the netlist similarly to how you created it in the Schema Editor by clicking the `Load Netlist` icon. All components will appear packed together on the PCB.

![load netlist icon](images/generate-netlist.png)

Use the same shortcuts as in the Schematic Editor to position and rotate the components. You must click to select them before being able to move them. Move the resistor and capacitor values to their appropriate locations. Try to untangle the connection lines as far as possible.

The right sidebar lists all possible layers and tools you can use. The most important are the following:

| Layer | Description |
|---|---|
| F.Cu and B.Cu | Front and Back Copper Layer (Traces) |
| F.SilkS and B.SilkS | Front and Back Silkscreen (Labels and Text) |
| F.Mask and B.Mask | Front and Back Solder Mask (Coating on top of traces) |
| Edge.Cuts | Cut lines for PCB edge |

Select a layer, then the "Route Tracks" tool and start drawing. To create a conductive plane, use the "Filled Zones" tool. It allows you to select the electric level it should have and automatically connects to all corresponding pads.

![route tracks tool icon](images/route-tracks.png)

![filled zones tool icon](images/filled-zones.png)

To create a via, draw a wire and press V (create via) to place a via at the current cursor position.

In the end, create the edge cuts by selecting the "Edge.Cuts" layer and using the "Graphic lines" tool.

## Design Rule Check

Use `Inspect` > `Design Rule Check` or the bug in the top menu bar to perform a DRC. Make sure all pads are connected and no traces are too close to each other.

## Visual Check

Use `View` > `3D-Viewer` to check your PCB in the graphical view.


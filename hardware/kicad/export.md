# Export

Use `File` > `Plot` or the Plotter top menu bar item to export the Gerber files. Enable the "Use Protel filename extensions" checkmark and export the following layers:

* F.Cu and B.Cu
* F.SilkS and B.SilkS
* F.Mask and B.Mask
* Edge.Cuts

Export those files whereever you want.

Additionally create the drill files by clicking the "Generate Drill Files" button. Leave all options as they are.

## Printing

If you want to print the PCB using a service like DirtyPCB, you need to rename the Edge file from `.gm1` to `.gko`.
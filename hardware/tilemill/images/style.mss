Map {
  background-color: white;
}

@color: rgb(0, 66, 138);

#roads{
  line-width: 1;
  line-color: transparent;
}
#roads[fclass = "motorway"] { line-width: 3; line-color: @color; }
#roads[fclass = "motorway_link"] { line-width: 3; line-color: @color; }
#roads[fclass = "trunk"] { line-width: 3; line-color: @color; }
#roads[fclass = "primary"] { line-width: 3; line-color: @color; }
#roads[fclass = "secondary"] { line-width: 2; line-color: @color; }
#roads[fclass = "tertiary"] { line-width: 2; line-color: @color; }

#roads[fclass = "residential"] { line-width: 1.4; line-color: @color; }
#roads[fclass = "living_street"] { line-width: 1.4; line-color: @color; }
#roads[fclass = "unclassified"] { line-width: 1.4; line-color: @color; }

#roads[fclass = "path"] { line-width: 1; line-color: @color; }
#roads[fclass = "pedestrian"] { line-width: 1; line-color: @color; }
#roads[fclass = "service"] { line-width: 1; line-color: @color; }
#roads[fclass = "cycleway"] { line-width: 1; line-color: @color; }
#roads[fclass = "track"] { line-width: 1; line-color: @color; }
/*#roads[type = "footway"] { line-width: 1.8; line-color: red; }*/

#roads[fclass = "rail"] { line-width: 1.8; line-color: @color; }



#waterareas, #waterareas2 {
  line-color: rgb(0, 90, 191);
  line-width: 0.5;
  polygon-opacity:1;
  polygon-fill: rgb(0, 90, 191);
}


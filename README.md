# polygon_overlap
Given two sets of polygons, finds the regions where polygons from one set overlap the polygons from the other set.

Matlab scripts in this repo provide a source code to find the overlaping parts of two groups of polygons. Multiple polygons can be present in each group and polygons can be scatterted or be in a tight grid formation. 

The code compares each polygon from one group against each polygon from another group and finds overlaps if they exist. Each found overlap is added to a third group.

The code also includes a demo script that generates configurable number of random polygons at random locations for each group. Then the polygon overlap function is called and and the resulting overlaps are displayed along with the original polygons.

![image](https://github.com/melihaltun/polygon_overlap/assets/40482921/77cc0c54-e191-471d-b9a2-84e46150ac28)


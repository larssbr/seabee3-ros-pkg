**Contents:**


# Tutorials #
  * See [SeaBee3Tutorials#Software](SeaBee3Tutorials#Software.md)

# Existing Software Components #
> | Component | **TAGS** | Authors / Reviewers |
|:----------|:---------|:--------------------|
> | [base\_libs](http://code.google.com/p/seabee3-ros-pkg/wiki/base_libs) | <font color='#00DD00'>IMPL</font>| Edward T. Kaszubski |
> | [color\_classifier](http://code.google.com/p/seabee3-ros-pkg/wiki/color_classifier) | <font color='#00DD00'>IMPL</font>| <font color='#0000DD'>REV</font>| Edward T. Kaszubski |
> | [image\_server](http://code.google.com/p/seabee3-ros-pkg/wiki/image_server) | <font color='#00DD00'>IMPL</font>| Rand Voorhies       | Edward T. Kaszubski |
> | [jaus\_adapter](http://code.google.com/p/seabee3-ros-pkg/wiki/jaus_adapter) | <font color='#00DD00'>IMPL</font>| <font color='#0000DD'>REV</font>| John O'Hollaren     |
> | [landmark\_finder](http://code.google.com/p/seabee3-ros-pkg/wiki/landmark_finder) | <font color='#00DD00'>IMPL</font>| <font color='#0000DD'>REV</font>| Edward T. Kaszubski |
> | [landmark\_map\_server](http://code.google.com/p/seabee3-ros-pkg/wiki/landmark_map_server) | <font color='#00DD00'>IMPL</font>| <font color='#0000DD'>REV</font>| Edward T. Kaszubski |
> | [localization\_defs](http://code.google.com/p/seabee3-ros-pkg/wiki/localization_defs) | <font color='#00DD00'>IMPL</font>| <font color='#0000DD'>REV</font>| Edward T. Kaszubski |
> | [rectangle\_finder](http://code.google.com/p/seabee3-ros-pkg/wiki/rectangle_finder) | <font color='#00DD00'>IMPL</font>| <font color='#0000DD'>REV</font>| Unassigned          |
> | [seabee3\_controls](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_controls) | <font color='#00DD00'>IMPL</font>| Edward T. Kaszubski |
> | [seabee3\_driver](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_driver) | <font color='#00DD00'>IMPL</font>| Rand Voorhies       | Edward T. Kaszubski |
> | [seabee3\_mission\_control](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_mission_control) | <font color='#00DD00'>IMPL</font>| <font color='#0000DD'>REV</font>| Noah Olsman         |
> | [seabee3\_physics](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_physics) | <font color='#00DD00'>IMPL</font>| <font color='#0000DD'>REV</font>| Rand Voorhies       | Edward T. Kaszubski | Dhruv Monga         |
> | [seabee3\_simulator](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_simulator) | <font color='#DDDD00'>PROP</font>| <font color='#0000DD'>REV</font>| John O'Hollaren     |
> | [seabee3\_teleop](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_teleop) | <font color='#00DD00'>IMPL</font>| Edward T. Kaszubski |
> | [seabee3\_util](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_util) | <font color='#00DD00'>IMPL</font>| Edward T. Kaszubski |
> | [slam\_landmarks](http://code.google.com/p/seabee3-ros-pkg/wiki/slam_landmarks) | <font color='#DDDD00'>PROP</font>| <font color='#0000DD'>REV</font>| Edward T. Kaszubski |
> | [sonar\_node](http://code.google.com/p/seabee3-ros-pkg/wiki/sonar_node) | <font color='#DDDD00'>PROP</font>| <font color='#DD6600'>DOC_TMP</font>| Unassigned          |
> | [xsens\_driver](http://code.google.com/p/seabee3-ros-pkg/wiki/xsens_driver) | <font color='#00DD00'>IMPL</font>| <font color='#0000DD'>REV</font>| Edward T. Kaszubski |

| <font color='#00DD00'>IMPL</font>**: implemented**|
|:---------------------------------|
| <font color='#DDDD00'>PROP</font>**: proposed**|
| <font color='#0000DD'>REV</font>**: undergoing review/reimplementation**|
| <font color='#DD6600'>DOC_TMP</font>**: documentation is an empty template**|
| <font color='#DD0000'>DEP</font>**: deprecated/soon to be removed/renamed**|

# Technical Info #
  * seabee3-ros-pkg source dependency and message passing diagram; message types are color-coded; services that are colored black are implemented but not utilized by any other components in the package and are most likely used for diagnostics

![![](http://lh4.ggpht.com/_EiQADOyrLss/TFiJb4o84LI/AAAAAAAAA0Y/7SZtuQosL-o/s350/seabee3.png)](http://lh4.ggpht.com/_EiQADOyrLss/TFiJb4o84LI/AAAAAAAAA0Y/7SZtuQosL-o/d/seabee3.png)
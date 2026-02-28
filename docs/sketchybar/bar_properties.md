# Bar Properties | SketchyBar.pdf
## Metadata
- PDFFormatVersion=1.4
- IsLinearized=false
- IsAcroFormPresent=false
- IsXFAPresent=false
- IsCollectionPresent=false
- IsSignaturesPresent=false
- CreationDate=D:20260228073639Z00'00'
- Producer=macOS バージョン26.3（ビルド25D125） Quartz PDFContext
- ModDate=D:20260228073639Z00'00'



## Contents
### Page 1
Configuration Bar PropertiesBar PropertiesBar PropertiesBar PropertiesBar PropertiesConfiguration of the barConfiguration of the barConfiguration of the barConfiguration of the barFor an example configuration see the supplied defaultsketchybarrc. The configuration file resides in~/.config/sketchybar/sketchybarrc and is a regular script that gets executed whenSketchyBarlaunches, everything persistent should be set up in this script.It is possible to play with properties in the commandline and change them on the fly while the bar isrunning, once you find a fitting value you can include it in the sketchybarrc file, such that theconfiguration is restored on restart. When configuringSketchyBar it can be helpful to stop the brewservice and run sketchybar from the commandline directly to see all relevant error messages andwarnings directly.The global bar properties can be configured by invoking:where possible settings are:<setting<setting<setting<setting>>>> <value<value<value<value>>>> defaultdefaultdefaultdefault descriptiondescriptiondescriptiondescriptioncolor <argb_hex> 0x44000000 Color of the barborder_color <argb_hex> 0xffff0000 Color of the bars borderposition top , bottom top Position of the bar on thescreenheight <integer> 25 Height of the barnotch_display_height <integer> 0 Override of the height ofthe bar on notched displaysmargin <integer> 0 Margin around the bary_offset <integer> 0 Vertical offset of the barfrom its default positioncorner_radius <positive_integer> 0 Corner radius of the barborder_width <positive_integer> 0 Border width of the barsborderblur_radius <positive_integer> 0 Blur radius applied to thebackground of the barpadding_left <positive_integer> 0Padding between the leftbar border and the leftmostitempadding_right <positive_integer> 0Padding between the rightbar border and therightmost itemnotch_width <positive_integer> 200The width of the notch tobe accounted for on theinternal displaynotch_offset <positive_integer> 0Additional y_offsetexclusively applied tonotched screensdisplaymain , all ,<positive_integerlist>all Display to show the bar onhidden <boolean> , current off If all / the current bar ishiddentopmost <boolean> , window offIf the bar should be drawnon top of everything , oron top of all window ssticky <boolean> on Makes the bar sticky duringspace changesfont_smoothing <boolean> off If fonts should besmoothenedshadow <boolean> off If the bar should draw ashadowYou can find the nomenclature for all the types here. If you are looking for colors, check out the colorpicker.Previous«««« SetupSetupSetupSetupNextItem PropertiesItem PropertiesItem PropertiesItem Properties »»»»FeaturesSetupBar PropertiesItem PropertiesSpecial ComponentsPopup MenusEvents & ScriptingQuerying InformationAnimationsType NomenclatureReloading theconfigurationTips & TricksCreditsConfigurationsketchybar --bar <setting>=<value> ... <setting>=<value>Configuration of the barSketchyBarSketchyBarSketchyBarSketchyBar Features Setup & Installation Configuration Search ⌘ K

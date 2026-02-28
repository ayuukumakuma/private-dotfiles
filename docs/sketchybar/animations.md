# Animations | SketchyBar.pdf
## Metadata
- PDFFormatVersion=1.4
- IsLinearized=false
- IsAcroFormPresent=false
- IsXFAPresent=false
- IsCollectionPresent=false
- IsSignaturesPresent=false
- CreationDate=D:20260228074118Z00'00'
- Producer=macOS バージョン26.3（ビルド25D125） Quartz PDFContext
- ModDate=D:20260228074118Z00'00'



## Contents
### Page 1
Configuration AnimationsAnimationsAnimationsAnimationsAnimationsAnimating the barAnimating the barAnimating the barAnimating the barAll transitions between <argb_hex> , <integer> and <positive_integer> values can be animated,by prepending the animation command in front of any regular --set or --bar command:where the <curve> is any of the animation curves:linear , quadratic , tanh , sin , exp , circThe <duration> is a positive integer quantifying the number of animation steps (the duration is theframe count on a 60Hz display, such that the temporal duration of the animation in seconds is givenby <duration> / 60C.The animation systemalways animates between allcurrent values and the values specified in aconfiguration command (i.e. --bar or --set commands).Perform multiple animations chained togetherPerform multiple animations chained togetherPerform multiple animations chained togetherPerform multiple animations chained togetherIf you want to chain two or more animations together, you can do so by simply changing the propertymultiple times in a single call, e.g.will animate the bar to the first offset and after that to the second offset. You can chain together asmain animations as you like and you can change the animation function in between. This is a nice wayto create custom animations with key-frames. You can also make other properties wait with theiranimation till another animation is finished, by simply setting the property that should wait to itscurrent value in the first animation.A new non-animated --set command targeting a currently animated property will cancel theanimation queue and immediately set the value.A new animated --set command targeting a currently animated property will cancel the animationqueue and immediately begin with the new animation, beginning at the current state.Previous«««« Querying InformationQuerying InformationQuerying InformationQuerying InformationNextType NomenclatureType NomenclatureType NomenclatureType Nomenclature »»»»FeaturesSetupBar PropertiesItem PropertiesSpecial ComponentsPopup MenusEvents & ScriptingQuerying InformationAnimationsType NomenclatureReloading theconfigurationTips & TricksCreditsConfigurationsketchybar --animate <curve> <duration> \--bar <property>=<value> ... <property>=<value> \--set <name> <property>=<value> ... <property>=<value>sketchybar --animate sin 30 --bar y_offset=10 y_offset=0Animating the barPerform multiple animationschained togetherSketchyBarSketchyBarSketchyBarSketchyBar Features Setup & Installation Configuration Search ⌘ K

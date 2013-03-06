rapidmotion
===========

## Pre-alpha release
Still a work in progress

## Requirements
Requires ProMotion, sugarcube, and bubble-wrap



## Extensions to ProMotion::Screen

### Text input
Adds to current Screen. Adds done button to keyboard, positions at the top or bottom of the screen.

~~~ruby

add_input :email, {bottom:0, placeholder:'Third'}
add_input :email, {top:0, placeholder:'First'}
add_input :email, {top:1, placeholder:'Second'}

~~~


### Buttons
Adds to current Screen. Positions at the top or bottom of the screen.

~~~ ruby
add_button title:"Save", bottom:1, action:'callback'
add_button title:"Skip", bottom:0, action:'another_callback'
add_button title:"I do not", bottom:0, action:'more_cowbell_callback'

def callback
	# called when Save is clicked
end
~~~


### Backgrounds

Sets the Screen's background to this image, stretched to fit.
~~~ruby

background_image "some-image"

~~~
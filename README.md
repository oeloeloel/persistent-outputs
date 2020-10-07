# persistent-outputs
Persistent Outputs for DragonRuby

This script makes it easy to output primitives to the screen and have them stay there without the slowdown that comes from having tons of primitives around.

Set up:
Drop the file persistent-outputs.rb into your mygame/app folder.

Add this line to the top of main.rb:
require 'app/persistent-outputs.rb'

Usage:
Exactly the same as with normal DragonRuby primitives except using args.persist instead of args.outputs.

For example:
  args.persist.sprites << [args.inputs.mouse.x, args.inputs.mouse.y, 100, 100, 'sprites/circle-orange.png']
  args.persist.primitives << [args.inputs.mouse.x, args.inputs.mouse.y, 100, 100, rand(255), rand(255), rand(255)].solid

To clear persistent outputs:
  args.persist.clear
  
All DragonRuby primitive types are supported. Solids do not behave as expected due to the ordering of primitives within DragonRuby. I suggest to send solids to args.persist.primitives instead. 

The script uses the 'double-buffer' render target technique pioneered by @Islacrusez (on the DragonRuby Discord).
The code to accomplish args.persist is adapted from original code by Amir Rajan (@amirrajan on the DragonRuby Discord).

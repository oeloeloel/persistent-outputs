require 'app/persistent-outputs.rb'

def tick(args)
  args.outputs.background_color = [63, 63, 63]
  args.outputs.debug << [10, 720, "FPS #{args.gtk.current_framerate.round}"].label

  # args.persist.borders << [args.inputs.mouse.x, args.inputs.mouse.y, 100, 100, rand(255), rand(255), rand(255)].solid
  args.persist.sprites << [args.inputs.mouse.x, args.inputs.mouse.y, 100, 100, 'sprites/circle-orange.png']
  # args.persist.labels << [args.inputs.mouse.x, args.inputs.mouse.y, 'DragonRuby Rocks!', rand(255), rand(255), rand(255)]
  # args.persist.lines << [args.inputs.mouse.x, args.inputs.mouse.y, 100, 100, rand(255), rand(255), rand(255)]
end

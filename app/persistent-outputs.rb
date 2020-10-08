class PersistentOutputs
  def init_persist
    # special touch
    @args.render_target(:flip)
    @args.render_target(:flop)

    @flip_flop = :flip

    @output_sprite = {
      w: @args.grid.w,
      h: @args.grid.h
    }
  end

  def tick(args)
    @args = args

    if @args.state.tick_count <= 0
      init_persist
      return
    end

    # if cleared, set back to full size
    @output_sprite.w = @output_sprite.w.greater(@args.grid.w)

    # set the path of output sprite to point at the current render target
    @output_sprite[:path] = @flip_flop
    # add the current render target to the non-current render target
    @args.render_target(swap(@flip_flop)).sprites << @output_sprite
    # display the current render target
    @args.outputs.sprites << @output_sprite
    # swap the render targets
    @flip_flop = swap(@flip_flop)
  end

  def clear
    @output_sprite.w = 0
  end

  # swaps flip_flop from :flip to :flop or :flop to :flip
  def swap(fl_p)
    fl_p == :flip ? :flop : :flip
  end

  def outputs_persist
    return @args.outputs if @args.state.tick_count <= 0

    @args.outputs[@flip_flop]
  end

  def solids
    outputs_persist.solids
  end

  def sprites
    outputs_persist.sprites
  end

  def primitives
    outputs_persist.primitives
  end

  def labels
    outputs_persist.labels
  end

  def lines
    outputs_persist.lines
  end

  def borders
    outputs_persist.borders
  end
end

# here be monkeys
class GTK::Args
  def tick_persist
    @persist ||= PersistentOutputs.new(self)
    @persist.tick(self)
  end

  def persist
    @persist
  end
end

module GTKRuntimePersistentOutputExtension
  def tick_core
    @args.tick_persist
    super
  end
end

GTK::Runtime.prepend GTKRuntimePersistentOutputExtension

class PersistentOutputs
  def init_persist
    # special touch
    @args.render_target(:flip)
    @args.render_target(:flop)
    # end special touch

    @flip_flop = :flop
  end

  def tick(args)
    @args = args

    if @args.state.tick_count <= 0
      init_persist
      return
    end

    output_sprite = {
      x: 0,
      y: 0,
      w: 1280,
      h: 720,
      path: @flip_flop,
      source_x: 0,
      source_y: 0,
      source_w: 1280,
      source_h: 720
    }

    @args.render_target(invert(@flip_flop)).sprites << output_sprite
    @args.outputs.sprites << output_sprite
    @flip_flop = invert(@flip_flop)
  end

  # inverts flip_flop from :flip to :flop or vice versa
  def invert(fl_p)
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

class GTK::Args
  def tick_persist
    @persist ||= PersistentOutputs.new(self)
    @persist.tick(self)
  end

  def persist
    @persist
  end
end

module GTK
  class Runtime
    alias_method :__original_tick_core__, :tick_core unless Runtime.instance_methods.include?(:__original_tick_core__)

    def tick_core
      @args.tick_persist
      __original_tick_core__

      return if @args.state.tick_count <= 0
    end
  end
end

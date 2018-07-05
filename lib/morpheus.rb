class Morpheus
  OPTS = {
    'S' => '-S',
    'N' => '-n',
    'D' => '-d',
    'E' => '-e',
    'K' => '-k',
    'L' => '-l',
    'P' => '-p',
    'V' => '-v',
  }

  def initialize(morphlib, executable)
    @morphlib = morphlib
    @executable = executable
  end

  def response(word, opts, lang)
    command = [executable, *lang_ops(lang), *options(opts)]

    IO.popen({ 'MORPHLIB' => morphlib }, command, 'r+') do |io|
      io.puts(word)
      io.close_write
      io.read
    end
  end

  private

  attr_reader :morphlib, :executable

  def lang_ops(lang)
    case lang
    when :Latin then ['-L']
    else []
    end
  end

  def options(opts)
    return [] unless opts

    opts.upcase.chars.uniq.map { |c| OPTS[c] }.compact.sort
  end
end

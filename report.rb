require 'benchmark'
require File.expand_path(File.join(File.dirname(__FILE__), 'foo'))

include Benchmark

Benchmark.benchmark(CAPTION, 15, FORMAT) do |b|
  b.report("not threaded") do
    f = Foo.new
    f.long
    f.longer
    f.longest
  end

  b.report("threaded") do 
    threads = []
    f = Foo.new
    threads << Thread.new do
      f.long
    end
    threads << Thread.new do
      f.longer
    end
    threads << Thread.new do
      f.longest
    end
    threads.each(&:join)
  end
end

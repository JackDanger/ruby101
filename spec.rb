module Kernel
  def method_missing(method_name, *args)
    if method = method_name.to_s.scan(/^test_(.*)/).flatten.first
      [method + "?", *args]
    else
      super
    end
  end

  def should(match)
    if send(*match)
      $test.successes << match
    else
      $test.failures << match
    end
  end

  def describe(object, &block)
    object.instance_exec(&block)
  end

  def it(name, &block)
    $test.test_cases << [name, block, self]
  end
end

class Test
  def failures
    @failures ||= []
  end

  def successes
    @successes ||= []
  end

  def test_cases
    @test_cases ||= []
  end

  def run!
    test_cases.each do |name, block, object|
      puts "Running: #{object} #{name}"
      begin
        object.instance_exec(&block)
      rescue => e
        failures << "#{name}: #{e.inspect}"
      end
    end
    if failures.empty?
      puts "All green!"
    else
      failures.each do |failure|
        puts "Failed: #{failure}"
      end
    end
    puts "Failed tests: #{failures.size}"
    puts "Passed tests: #{successes.size}"
  end
end

$test = Test.new

describe "This string" do
  it "blows up" do
    raise "cats!"
  end

  it "has valid encoding" do
    should test_valid_encoding
  end

  it "is definitely a string" do
    should test_kind_of(String)
  end
end

$test.run!

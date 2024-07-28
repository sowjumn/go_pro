class Layer
  # attr_accessor :properties
  def initialize(id, properties)
    @id = id
    @properties = properties
  end

  def id
    @id
  end

  def properties
    @properties
  end
end

class Document
  # Setup the initial document and all necessary data structures.
  def initialize(layers)
    # fill me in!
    # array, Hashmap, linkedList, Tree
    # layers is a hashmap with id => hashmap
    @layers = Hash.new { Layer.new }
    
    @apply_stack = Array.new { Array.new }
    @commit_stack = Array.new { Hash.new { Hash.new } } 
    # [['a','color','green']]
    layers.each do |layer|
      @layers[layer.id] = layer
    end
  end

  def to_s
    puts @layers.inspect
  end

  def layer_by_id(id)
    if @layers[id]
      return @layers[id]
    else
      raise 'Layer doesnt exist'
    end
    # if layer doesnt exist
  end

  def apply(id, property, value)
    # fill me in!
    layer_to_change = @layers[id]
    @apply_stack.push([id,property,layer_to_change.properties[property]])
    layer_to_change.properties[property] = value
  end

  def undo!
    # fill me in!
    prior_value = @apply_stack.pop
    layer_to_change = @layers[prior_value[0]]
    layer_to_change.properties[prior_value[1]] = prior_value[2]
  end

  def commit_batch() 
    last_apply = @apply_stack.pop
    tmp_hash = Hash.new { Hash.new }
    tmp_hash[last_apply[0]][last_apply[1]] = last_apply[2]
    @commit_stack.push(tmp_hash)
    puts @commit_stack
  end
end

# Part 2: add a method called `commit_batch()` that allows multiple changes to
# be batched together. The document is still changed during each 'apply()', but 
# each 'undo()' call reverts the last batch of changes.
# 
# You can assume that `commit_batch()` will _always_ be called before `undo()`.
def test_commit_batch()
  document = Document.new([
    Layer.new('a', { 'color' => 'red' }),
    Layer.new('b', { 'shape' => 'triangle' }),
  ])

  document.apply('a', 'color', 'green')
  document.apply('a', 'color', 'blue')
  document.apply('b', 'shape', 'square')
  document.commit_batch()

  document.apply('a', 'color', 'green')
  document.apply('a', 'color', 'blue')
  document.apply('a', 'color', 'white')
  document.apply('b', 'shape', 'square')
  document.commit_batch()

  # document.apply('a', 'color', 'purple')
  # document.apply('a', 'color', 'orange')
  # document.commit_batch()

  # document.undo!
  # raise unless document.layer_by_id('a').properties['color'] == 'blue'
  # raise unless document.layer_by_id('b').properties['shape'] == 'square'

  # document.undo!
  # raise unless document.layer_by_id('a').properties['color'] == 'red'
  # raise unless document.layer_by_id('b').properties['shape'] == 'triangle'
end

# def test_apply_and_undo()
#   document = Document.new([
#     Layer.new('a', { 'color' => 'red' }),
#     Layer.new('b', { 'shape' => 'triangle' }),
#   ])

#   # puts document
#   document.apply('a', 'color', 'green')
#   document.apply('b', 'shape', 'square')
#   document.apply('a', 'color', 'blue')
#   raise unless document.layer_by_id('a').properties['color'] == 'blue'

#   document.undo!
#   raise unless document.layer_by_id('a').properties['color'] == 'green'
#   raise unless document.layer_by_id('b').properties['shape'] == 'square'

#   document.apply('a', 'color', 'purple')
#   raise unless document.layer_by_id('a').properties['color'] == 'purple'
#   raise unless document.layer_by_id('b').properties['shape'] == 'square'

#   document.undo!
#   raise unless document.layer_by_id('a').properties['color'] == 'green'
#   raise unless document.layer_by_id('b').properties['shape'] == 'square'
  
#   document.undo!
#   raise unless document.layer_by_id('a').properties['color'] == 'green'
#   raise unless document.layer_by_id('b').properties['shape'] == 'triangle'

#   document.undo!
#   raise unless document.layer_by_id('a').properties['color'] == 'red'
#   raise unless document.layer_by_id('b').properties['shape'] == 'triangle'
# end

puts "Running the tests.."
test_commit_batch()
puts "Tests succeeded!"
func Heap
  #https://en.wikipedia.org/wiki/Heap_%28data_structure%29
  #http://www.comp.dit.ie/rlawlor/Alg_DS/heaps/PQs%20and%20Heaps.pdf
  #https://www.cprogramming.com/tutorial/computersciencetheory/heap.html

  # Key - a type, usually int, describes type of values in heap
  # int N - number of elements in array or heap
  # Key h[ ] - heap array of size N containing items of type Key.
  # The heap array h[] and N will be encapsulated inside the heap object.
  sub push(v, p)
    local key = {}
    key.v = v
    key.p = p
    self.heap << key
    upHeap(len(self.heap) - 1)
  end 

  # Key of node at position k may be less than that of its
  # children and may need to be moved down some levels
  # k is a position in the heap array h
  func pop()
    local key = self.heap[1]
    local i_end = len(self.heap) - 1
    self.heap[1] = self.heap[i_end]
    delete self.heap, i_end, 1
    if (i_end > 1) then
      downHeap(1)
    endif
    return key.v
  end

  # upHeap from position k. The key or node value at position k
  # may be less that that of its parent at k/2
  # k is a position in the heap array h
  sub upHeap(k)
    local key = self.heap[k]
    local pk = int(k / 2)
    while (k > 0 && key.p < self.heap[pk].p)
      self.heap[k] = self.heap[pk]
      k = pk
      pk = int(pk / 2)
    wend
    self.heap[k] = key
  end

  # Key of node at position k may be greater than that of its
  # children and may need to be moved down some levels
  # k is a position in the heap array h 
  sub downHeap(k)
    local key = self.heap[k]
    local N = len(self.heap) - 1
    local levels = int(N / 2)
    local j
    while (k <= levels) 
      # node at pos k has a left child node
      j = k * 2
      # select the highest node from left/right
      if (j < N and self.heap[j].p > self.heap[j + 1].p) then j++
      if (key.p < self.heap[j].p) then exit loop
      self.heap[k] = self.heap[j]
      k = j
    wend      
    self.heap[k] = key
  end

  local h = {}
  h.heap = [0]
  h.push = @push
  h.pop = @pop
  return h
end

sub TestHeap
  h = Heap()
  h.push("cat", 2)
  h.push("dog", 9)
  h.push("mouse", 1)
  h.push("blah1", 10)
  h.push("blah2", 11)
  h.push("blah3", 12)
  if (h.pop() <> "mouse") then throw "e1"
  if (h.pop() <> "cat") then throw "e2"
  if (h.pop() <> "dog") then throw "e3"
  if (h.pop() <> "blah1") then throw "e4"
  if (h.pop() <> "blah2") then throw "e5"
  if (h.pop() <> "blah3") then throw "e6"
end

TestHeap

#!/usr/bin/ruby

def enc(x)
  #puts x
  ((7*x)+3) % 26
end

def dec(x)
  (15*(x-3)) % 26
end

def tocharIndex(char)
  char + 1 - ?a
end

def uncharIndex(char)
  (char - 1 + ?a).chr
end

def transform(x)
  uncharIndex(enc(tocharIndex(x)))
end

def invtransform(x)
  uncharIndex(dec(tocharIndex(x)))
end



line = gets
line.strip!
res = ""
line.each_byte do |c|
  res += invtransform(c)
end

puts res



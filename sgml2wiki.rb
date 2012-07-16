#!usr/bin/env ruby 
#vendor Lars Nielsen


#ARGV[0] = source file
#ARGV[1] = destination file
#ARGV[2] = code language
def replaceStrings(toChange)
  
  ##Remove Title tags and replace with the correct 
  toChange.gsub!(/<title>/) { "====="  }
  toChange.gsub!(/<\/title>/) { "====="  }
  
  ##Image
  toChange.gsub!(/<graphic fileref="/) { "{{"  }
  toChange.gsub!(/<\/graphic>/) { "|}}"  }
  toChange.gsub!(/;.*>/) { ""  }
  
  
  ##Screen to code and internal tags
  if(ARGV[2] == nil)
    toChange.gsub!(/<screen>/) { "<code>"  }
  else
    toChange.gsub!(/<screen>/) { "<code "+ ARGV[2] +">"  }  
  end
  
  toChange.gsub!(/<\/screen>/) { "</code>"  }
  toChange.gsub!(/<prompt>/) { ""  }
  toChange.gsub!(/<\/prompt>/) { ""  }
  toChange.gsub!(/<userinput>/) { ""  }
  toChange.gsub!(/<\/userinput>/) { ""  }
  
  
  ##just remove
  toChange.gsub!(/<para>/) { ""  }
  toChange.gsub!(/<\/para>/) { ""  }
  toChange.gsub!(/<chapter .*>/) { ""  }
  toChange.gsub!(/<\/chapter>/) { ""  }
  toChange.gsub!(/<sect.*>/) { ""  }
  toChange.gsub!(/<\/sect.*>/) { ""  }
  toChange.gsub!(/<figure.*>/) { ""  }
  toChange.gsub!(/<\/figure>/) { ""  }
  toChange.gsub!(/<primary>.*<\/primary>/) { ""  }
  toChange.gsub!(/<secondary>.*<\/secondary>/) { ""  }
  toChange.gsub!(/<indexterm>/) { ""  }
  toChange.gsub!(/<\/indexterm>/) { ""  }
  
  
  ##Currently not working:
  toChange.gsub!(/<\!-- $Id$ -->/) { ""  }
  toChange.gsub!(/<\!--.*?-->/) { ""  }
  toChange.gsub!(/<\!-- .*? -->/) { ""  }
end

fileInput = ARGV[0]
fileOutput = ARGV[1]

document = File.readlines(fileInput)
puts fileInput
puts fileOutput
document.each { |e|  replaceStrings(e)}

n = document.length
#puts n.to_s

for i in 0..n 
  text = document[i].to_s + " " + document[i].to_s.length.to_s
  puts text
  if(document[i].to_s.length == 1)
    document.delete_at(i)
  end
end

testarray = Array.new

for i in 0..n
  if(document[i].to_s.length > 1)
    testarray.push(document[i])
  end
end

#n = document.length
#puts n.to_s

File.open(fileOutput, 'w'){
  #|f| f.write(document)
  |f| f.write(testarray)
  #|f| f.write(test)
}
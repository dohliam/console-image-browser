#!/usr/bin/env ruby

# Console Image Browser (cib) - An interactive wrapper for Terminal Image Viewer
# - Open from within image directory or specify directory/image as argument
# - Navigate using arrow keys or PgUp/PgDn etc.

require 'image_size'

def get_char
  state = `stty -g`
  `stty raw -echo -icanon isig`

  STDIN.getc.chr
ensure
  `stty #{state}`
end

def format_mb(size)
  conv = [ 'b', 'kb', 'mb', 'gb', 'tb', 'pb', 'eb' ];
  scale = 1024;

  ndx=1
  if( size < 2*(scale**ndx)  ) then
    return "#{(size)} #{conv[ndx-1]}"
  end
  size=size.to_f
  [2,3,4,5,6,7].each do |ndx|
    if( size < 2*(scale**ndx)  ) then
      return "#{'%.2f' % (size/(scale**(ndx-1)))} #{conv[ndx-1]}"
    end
  end
  ndx=7
  return "#{'%.2f' % (size/(scale**(ndx-1)))} #{conv[ndx-1]}"
end

def get_special_key
  k = ""
  e = get_char
  if e == "\["
    s = get_char
    if s == "A"
      k = "up"
    elsif s == "B"
      k = "down"
    elsif s == "C"
      k = "right"
    elsif s == "D"
      k = "left"
    elsif s == "5"
      k = "pgup"
    elsif s == "6"
      k = "pgdn"
    elsif s == "H"
      k = "home"
    elsif s == "F"
      k = "end"
    end
  end
  k
end

filetypes = [ "jpg", "png", "jpeg", "tif", "tiff", "bmp", "JPG", "PNG", "JPEG", "TIF", "TIFF", "BMP" ]
status_line = "(n)ext, (p)revious, (i)nfo, (b)rowse, (q)uit?"

base_dir = "./"
if ARGV[0]
  base_dir = ARGV[0]
end

path = File.absolute_path(base_dir)
if !File.directory?(path)
  if File.exist?(path)
    ext = File.extname(path).gsub(/^\./, "")
    if filetypes.include?(ext)
      puts `tiv "#{path}"`
      exit
    elsif ext.match(/^gif$/i)
      system("catimg #{path}")
      exit
    else
      abort("  This file is not a recognized image format.")
    end
  elsif base_dir.match(/^https*:/)
    puts `tiv #{base_dir}`
    exit
  else
    abort("  Not a directory, file, or URL.")
  end
end

files = Dir.glob(path + "/*.{#{filetypes.join(",")}}").sort
len = files.length
counter = 1

if len == 0
  abort("  No image files found.")
end

puts `tiv "#{files[0]}"`

while counter < len
  puts status_line
  nav = get_char
  if nav == "\e"
    nav = get_special_key
  end

  if nav == "n" || nav == "right" || nav == "down" || nav == "pgdn"
    counter += 1
    if counter > len - 1
      counter = 0
    end
    puts `tiv "#{files[counter]}"`
  elsif nav == "p" || nav == "left" || nav == "up" || nav == "pgup"
    counter -= 1
    if counter < 0
      counter = len - 1
    end
    puts `tiv "#{files[counter]}"`
  elsif nav == "home"
    counter = 0
    puts `tiv "#{files[counter]}"`
  elsif nav == "end"
    counter = len - 1
    puts `tiv "#{files[counter]}"`
  elsif nav == "b"
    exts = []
    files.each do |f|
      ext = File.extname(f)
      exts << ext
    end
    uniq_exts = exts.uniq
    ext_list = uniq_exts.join(" #{path}/*")
    if uniq_exts.length == 1
      ext_list = uniq_exts[0]
    end
    system("tiv #{path.gsub(/ /, "\\ ")}/*#{ext_list}")
  elsif nav == "0"
    counter = 10
    puts `tiv "#{files[counter]}"`
  elsif /\A\d+\z/.match(nav)
    counter = nav.to_i - 1
    puts `tiv "#{files[counter]}"`
  elsif nav == "i"
    f = files[counter]
    size = File.size(f)
    d = ImageSize.path(f)
    puts "Filename:\t" + f
    puts "Size:\t\t" + format_mb(size) + " (#{size} bytes)"
    puts "Dimensions:\t#{d.width} x #{d.height}"
  elsif nav == "q"
    puts "Goodbye!"
    exit
  else
    puts "Input not understood"
  end
end

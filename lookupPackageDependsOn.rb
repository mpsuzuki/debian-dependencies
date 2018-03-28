#!/usr/bin/env ruby1.9
Encoding.default_internal = "utf-8"
Encoding.default_external = "ISO8859-1"

require "./getOpts.rb"
require "json"

pat = Regexp.new( Opts.args.first )

if (Opts.packages)
  jsonFiles = Dir::glob("*_Packages.json")
elsif (Opts.sources)
  jsonFiles = Dir::glob("*_Sources.json")
end

if (Opts.debian_release_sed)
  Opts["rel2num"] = Hash.new
  f = File::open(Opts.debian_release_sed, "r")
  while (f.gets)
    toks = $_.chomp.split("/") # s/<src>/<dst>/
    Opts.rel2num[toks[1]] = toks[2]
  end
  f.close

  jsonFiles = jsonFiles.sort_by{|fp| Opts.rel2num[fp.split("_")[0]]}
end

jsonFiles.each do |jsPath|
  f = File::open(jsPath, "r")
  js = JSON.parse(f.read)
  f.close

  pkgReqIt = js.keys.select{|k|
    hs = js[k]
    if (Opts.packages && hs.include?("Depends"))
      hs["Depends"].any?{|refs| refs.any?{|aRef| pat.match(aRef["nm"])}}
    elsif (Opts.sources && hs.include?("Build-Depends"))
      hs["Build-Depends"].any?{|refs| refs.any?{|aRef| pat.match(aRef["nm"])}}
    end
  }

  toks = jsPath.split("_")
  rel = toks[0]
  grp = toks[1]

  if (pkgReqIt.length > 0)
    if (Opts.rel2num)
      puts [grp, Opts.rel2num[rel], rel, pkgReqIt.length.to_s, pkgReqIt.sort.join(",")].join("\t")
    else
      puts [grp, rel, pkgReqIt.length.to_s, pkgReqIt.sort.join(",")].join("\t")
    end
  end
end

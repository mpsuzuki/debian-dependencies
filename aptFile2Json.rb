#!/usr/bin/env ruby1.9
Encoding.default_internal = "utf-8"
Encoding.default_external = "ISO8859-1"

require "./getOpts.rb"
require "json"
require "./aptPkgRefSyntax.rb"

pkgs = [ {} ]

while (STDIN.gets)
  $_ = $_.chomp
  if ($_.gsub(/\s/, "").length == 0)
    pkgs.push(Hash.new)
  elsif ($_ =~ /^\s/)
    k = pkgs.last.keys.last
    if (pkgs.last[k] == nil)
      pkgs.last[k] = $_
    else
      pkgs.last[k] = (pkgs.last[k] + $_)
    end
  else
    k, v = $_.split(/:\s/, 2)
    pkgs.last[k] = v
  end
end

pkgs.each do |aPkg|
  [
    "Build-Depends", "Conflicts", "Depends", "Pre-Depends", "Provides", "Replaces", "Suggests"
  ].each do |k|
    if (aPkg.include?(k))
      aPkg[k] = AptPkgRefSet.new(aPkg[k]).to_a
    end
  end
end

if (Opts.minimize)
  pkgs = pkgs.collect{|aPkg|
    hs = Hash.new
    [
      "Package", "Version", "Filename",
      "Build-Depends", "Conflicts", "Depends", "Pre-Depends", "Provides", "Replaces", "Suggests"
    ].each do |k|
      if (aPkg.include?(k))
        hs[k] = aPkg[k]
      end
    end
    hs
  }
end

if (Opts.as_hash)
  pkgs_hs = Hash.new
  pkgs.each do |aPkg|
    pkgs_hs[aPkg["Package"]] = aPkg
  end
  pkgs = pkgs_hs
end


if (Opts.pretty)
  puts JSON.pretty_generate(pkgs)
else
  puts JSON.generate(pkgs)
end

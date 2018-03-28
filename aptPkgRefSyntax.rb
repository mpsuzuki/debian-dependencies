#!/usr/bin/env ruby

class AptVerRange
  attr_accessor(:is_eq, :is_gt, :is_lt, :version)
  def initialize(s)
    s = s.gsub("(", " ( ").gsub(")", " ) ").gsub("<", " < ").gsub(">", " > ").gsub("=", " = ").gsub(/^\s*/, "").gsub(/\s*$/, "")
    s = s.gsub(/([<>=])\s*([<>=])/, '\1\2').gsub(/\s+/, " ")
    if (s.include?("( <<"))
      @is_gt = true
    elsif (s.include?("( >>"))
      @is_lt = true
    elsif (s.include?("( <= "))
      @is_gt = true
      @is_eq = true
    elsif (s.include?("( >= "))
      @is_lt = true
      @is_eq = true
    ## maybe these syntaxes are wrong
    # elsif (s.include?(">>)"))
    #   @is_lt = true
    # elsif (s.include?("<<)"))
    #   @is_gt = true
    end

    toks = s.split(/\s+/)
    toks.pop # discard ")"
    @version = toks.last
  end

  def to_hs
    if (@is_gt && @is_eq)
      r = ">="
    elsif (@is_gt && !@is_eq)
      r = ">>"
    elsif (@is_lt && @is_eq)
      r = "<="
    elsif (@is_lt && !@is_eq)
      r = "<<"
    end
    if (r)
      return { "v" => @version, "r" => r }
    else
      return { "v" => @version }
    end
  end
end

# p AptVerRange.new("(= 0.11.dfsg1-4)").to_hs

class AptPkgRef
  attr_accessor(:name, :version_range)
  def initialize(s)
    @name, v = s.gsub(/^\s*/, "").gsub(/\s*$/, "").split(/\s*\(/, 2)
    if (v)
      @version_range = AptVerRange.new("(" + v) 
    end
  end

  def to_hs
    if (@version_range)
      return {"nm" => @name, "vr" => @version_range.to_hs}
    else
      return {"nm" => @name}
    end
  end
end

#
# AptPkgRefSet is a double-layered array, like:
#
# [ [ aptPkgRef_0, aptPkgRef_1 ], [ aptPkg_2 ], [ aptPkg_3 ], ... ]
#
# this set means "one of aptPkgRef_0 or aptPkgRef_1 is required, aptPkg_2 is required, aptPkg_3 is required..."
#
class AptPkgRefSet < Array
  def initialize(s)
    s.split(",").each do |s1|
      self.push([])
      s1.split("|").each do |s2|
        self.last.push(AptPkgRef.new(s2))
      end
    end
  end

  def to_a
    return self.collect{|m| m.collect{|a| a.to_hs}}
  end
end

# p AptPkgRefSet.new("a7xpg-data (= 0.11.dfsg1-4), libc6 (>= 2.7-1), libgcc1 (>= 1:4.1.1-21), libgl1-mesa-glx | libgl1, libsdl-mixer1.2 (>= 1.2.6), libsdl1.2debian (>= 1.2.10-1), zlib1g").to_a

module DifferenceLists

export dl, concat

"""
    DL(func)

Given function `func`, construct a difference list.
"""
struct DL
    func
end

"""
    dl(items...)::DL

Construct a difference list of `items`. Difference lists are immutable, concatenate and prepend in constant time, and iterate in time N.

# Examples
```jldoctest
julia> dl()
dl()

julia> dl(1)
dl(1)

julia> dl(1, 2, 3)
dl(1, 2, 3)

julia> dl(1, dl(2, 3), 4)
dl(1, dl(2, 3), 4)
```

A difference list itself can be used as shorthand for concat.

See also: [`concat`](@ref)

# Examples
```jldoctest
julia> dl(1, 2)(dl(3, 4), dl(5, 6, 7))
dl(1, 2, 3, 4, 5, 6, 7)
```
"""
function dl(items...)
  if length(items) == 0
      DL(last -> last)
  else
      DL(last -> (items[1], length(items) == 1 ? last : (2, items, last)))
  end
end

"""
    concat(lists::DL...)::DL

Concatenate difference lists in constant time

See also: [`dl`](@ref)

# Examples
```jldoctest
julia> concat(dl(1, 2), dl(3, 4))
dl(1, 2, 3, 4)
```
"""
concat(lists::DL...) = DL(last -> foldr((x, y) -> x.func(y), lists, init=last))

"""
    (a::DL)(lists::DL...)::DL

A difference list itself can be used as shorthand for concat.

See also: [`dl`](@ref)

# Examples
```jldoctest
julia> dl(1, 2)(dl(3, 4), dl(5, 6, 7))
dl(1, 2, 3, 4, 5, 6, 7)
```
"""
(a::DL)(lists::DL...) = concat(a, lists...)

# Iteration support
Base.iterate(d::DL) = d.func(nothing)
Base.iterate(::DL, cur::Tuple{Any, Any}) = cur[2]
Base.iterate(::DL, (index, items, last)::Tuple{Int, Tuple, Any}) =
    index > length(items) ? last : (items[index], (index + 1, items, last))
Base.iterate(::DL, ::Nothing) = nothing
Base.IteratorSize(::DL) = Base.SizeUnknown()

# value display support
Base.show(io::IO, dl::DL) = print(io, "dl(", join([sprint(show, x) for x = dl], ", "), ")")

end # module

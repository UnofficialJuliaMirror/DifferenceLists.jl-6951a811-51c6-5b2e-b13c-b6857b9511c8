# Difference Lists for Julia, (C) 2018 Bill Burdick (William R. Burdick Jr.)

Difference lists are simple, immutable, concatenate and prepend in constant time, and iterate in time N.

This small library provides them for Julia, so you can use them when you need to accumulate a list incrementally. Since difference lists are immutable, you can easily reuse common parts.

To create a difference list, use the dl(items...) function like this:

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


Difference lists can iterate so you can easily convert them to collections.

# Examples
```jldoctest
julia> [x for x = dl(1, 2, 3)]
3-element Array{Int64,1}:
 1
 2
 3
```

You can concatenate difference lists in constant time using concatenate(lists::DL...), like this:

```jldoctest
julia> concat(dl(1, 2), dl(3, 4))
dl(1, 2, 3, 4)
```

You can use a difference list itself as shorthand for concat, like this:
```jldoctest
julia> dl(1, 2)(dl(3, 4), dl(5, 6, 7))
dl(1, 2, 3, 4, 5, 6, 7)
```

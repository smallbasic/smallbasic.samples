
'# Properties.bas 
# Version 1.0 Chris Warren-Smith 24/7/2004

## example usage:
# import properties
# kat = properties.load("kat")
# dog = properties.load("dog")
# ? "cat=";kat
# ? "dog=";dog
# kat ="sheba"
# dog ="bundy"
# properties.store "kat", kat
# properties.store "dog", dog
#

unit Properties

export load, store, lvalue, rvalue

local props
local datafile

datafile = "sb.properties"

func lvalue(s) 
    local i
    i = instr(1, s, "=")
    if (i != 0) then
        lvalue = left(s, i-1)
    else 
        lvalue = ""
    fi
end

func rvalue(s)
    local i
    i = instr(1, s, "=")
    if (i != 0) then
        rvalue = mid(s, i+1)
    else 
        rvalue = ""
    fi
end

func load(name, defvalue)
    local index

    index = 0
    for p in props
        if (lvalue(props(index)) = name) then
            load = rvalue(props(index))
            exit func
        fi
        index++
    next
    load = defvalue
end

sub store(name, value)
    local index, found

    found = 0
    index = 0
    for p in props
        if (lvalue(props(index)) = name) then
            props(index) = name+"="+value
            found = 1
            exit for
        fi
        index++
    next

    if (found = 0) then
        props << name+"="+value
    fi
    tsave datafile, props
end

if (exist(datafile)) then
   tload datafile, props
fi

'

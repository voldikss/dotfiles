define cls
    shell clear
end
document cls
    Clears the screen with a simple command.
end

define bpl
    info breakpoints
end
document bpl
    List breakpoints
end

define bp
    set $SHOW_CONTEXT = 1
    break * $arg0
end
document bp
    Set a breakpoint on address
    Usage: bp addr
end

define bpc
    clear $arg0
end
document bpc
    Clear breakpoint at function/address
    Usage: bpc addr
end

define bpe
    enable $arg0
end
document bpe
    Enable breakpoint #
    Usage: bpe num
end

define bpd
    disable $arg0
end
document bpd
    Disable breakpoint #
    Usage: bpd num
end

define bpt
    set $SHOW_CONTEXT = 1
    tbreak $arg0
end
document bpt
    Set a temporary breakpoint on address
    Usage: bpt addr
end

define bpm
    set $SHOW_CONTEXT = 1
    awatch $arg0
end
document bpm
    Set a read/write breakpoint on address
    Usage: bpm addr
end

define argv
    show args
end
document argv
    Print program arguments
end

define stack
    info stack
end
document stack
    Print call stack
end

define frame
    info frame
    info args
    info locals
end
document frame
    Print stack frame
end

define flags
    if (($eflags >> 0xB) & 1 )
        printf "O "
    else
        printf "o "
    end

    if (($eflags >> 0xA) & 1 )
        printf "D "
    else
        printf "d "
    end
    if (($eflags >> 9) & 1 )
        printf "I "
    else
        printf "i "
    end
    if (($eflags >> 8) & 1 )
        printf "T "
    else
        printf "t "
    end
    if (($eflags >> 7) & 1 )
        printf "S "
    else
        printf "s "
    end
    if (($eflags >> 6) & 1 )
        printf "Z "
    else
        printf "z "
    end
    if (($eflags >> 4) & 1 )
        printf "A "
    else
        printf "a "
    end
    if (($eflags >> 2) & 1 )
        printf "P "
    else
        printf "p "
    end
    if ($eflags & 1)
        printf "C "
    else
        printf "c "
    end
    printf "\n"
end
document flags
    Print flags register
end

define eflags
    printf "     OF <%d>  DF <%d>  IF <%d>  TF <%d>",\
    (($eflags >> 0xB) & 1 ), (($eflags >> 0xA) & 1 ), \
    (($eflags >> 9) & 1 ), (($eflags >> 8) & 1 )
    printf "  SF <%d>  ZF <%d>  AF <%d>  PF <%d>  CF <%d>\n",\
    (($eflags >> 7) & 1 ), (($eflags >> 6) & 1 ),\
    (($eflags >> 4) & 1 ), (($eflags >> 2) & 1 ), ($eflags & 1)
    printf "     ID <%d>  VIP <%d> VIF <%d> AC <%d>",\
    (($eflags >> 0x15) & 1 ), (($eflags >> 0x14) & 1 ), \
    (($eflags >> 0x13) & 1 ), (($eflags >> 0x12) & 1 )
    printf "  VM <%d>  RF <%d>  NT <%d>  IOPL <%d>\n",\
    (($eflags >> 0x11) & 1 ), (($eflags >> 0x10) & 1 ),\
    (($eflags >> 0xE) & 1 ), (($eflags >> 0xC) & 3 )
end
document eflags
    Print entire eflags register
end

define reg
    printf "     eax:%08X ebx:%08X  ecx:%08X ",  $eax, $ebx, $ecx
    printf " edx:%08X     eflags:%08X\n",  $edx, $eflags
    printf "     esi:%08X edi:%08X  esp:%08X ",  $esi, $edi, $esp
    printf " ebp:%08X     eip:%08X\n", $ebp, $eip
    printf "     cs:%04X  ds:%04X  es:%04X", $cs, $ds, $es
    printf "  fs:%04X  gs:%04X  ss:%04X    ", $fs, $gs, $ss
    flags
end
document reg
    Print CPU registers
end

define func
    info functions
end
document func
    Print functions in target
end

define var
    info variables
end
document var
    Print variables (symbols) in target
end

define lib
    info sharedlibrary
end
document lib
    Print shared libraries linked to target
end

define sig
    info signals
end
document sig
    Print signal actions for target
end

define thread
    info threads
end
document thread
    Print threads in target
end

define u
    info udot
end
document u
    Print kernel 'user' struct for target
end

define dis
    disassemble $arg0
end
document dis
    Disassemble address
    Usage: dis addr
end

define ascii_char
    set $_c=*(unsigned char *)($arg0)
    if ( $_c < 0x20 || $_c > 0x7E )
        printf "."
    else
        printf "%c", $_c
    end
end
document ascii_char
    Print the ASCII value of arg0 or '.' if value is unprintable
end

define hex_quad
    printf "%02X %02X %02X %02X  %02X %02X %02X %02X",                          \
    *(unsigned char*)($arg0), *(unsigned char*)($arg0 + 1),      \
    *(unsigned char*)($arg0 + 2), *(unsigned char*)($arg0 + 3),  \
    *(unsigned char*)($arg0 + 4), *(unsigned char*)($arg0 + 5),  \
    *(unsigned char*)($arg0 + 6), *(unsigned char*)($arg0 + 7)
end
document hex_quad
    Print eight hexadecimal bytes starting at arg0
end

define hexdump
    printf "%08X : ", $arg0
    hex_quad $arg0
    printf " - "
    hex_quad ($arg0+8)
    printf " "

    ascii_char ($arg0)
    ascii_char ($arg0+1)
    ascii_char ($arg0+2)
    ascii_char ($arg0+3)
    ascii_char ($arg0+4)
    ascii_char ($arg0+5)
    ascii_char ($arg0+6)
    ascii_char ($arg0+7)
    ascii_char ($arg0+8)
    ascii_char ($arg0+9)
    ascii_char ($arg0+0xA)
    ascii_char ($arg0+0xB)
    ascii_char ($arg0+0xC)
    ascii_char ($arg0+0xD)
    ascii_char ($arg0+0xE)
    ascii_char ($arg0+0xF)

    printf "\n"
end
document hexdump
    Display a 16-byte hex/ASCII dump of arg0
end

define ddump
    printf "[%04X:%08X]------------------------", $ds, $data_addr
    printf "---------------------------------[ data]\n"
    set $_count=0
    while ( $_count < $arg0 )
        set $_i=($_count*0x10)
        hexdump ($data_addr+$_i)
        set $_count++
    end
end
document ddump
    Display $arg0 lines of hexdump for address $data_addr
end

define dd
    if ( ($arg0 & 0x40000000) || ($arg0 & 0x08000000) || ($arg0 & 0xBF000000) )
        set $data_addr=$arg0
        ddump 0x10
    else
        printf "Invalid address: %08X\n", $arg0
    end
end
document dd
    Display 16 lines of a hex dump for $arg0
end

define datawin
    if ( ($esi & 0x40000000) || ($esi & 0x08000000) || ($esi & 0xBF000000) )
        set $data_addr=$esi
    else
        if ( ($edi & 0x40000000) || ($edi & 0x08000000) || ($edi & 0xBF000000) )
            set $data_addr=$edi
        else
            if ( ($eax & 0x40000000) || ($eax & 0x08000000) || \
                ($eax & 0xBF000000) )
                set $data_addr=$eax
            else
                set $data_addr=$esp
            end
        end
    end
    ddump 2
end
document datawin
    Display esi, edi, eax, or esp in the data window
end


define context
    printf "_______________________________________"
    printf "________________________________________\n"
    reg
    printf "[%04X:%08X]------------------------", $ss, $esp
    printf "---------------------------------[stack]\n"
    hexdump $sp+0x30
    hexdump $sp+0x20
    hexdump $sp+0x10
    hexdump $sp
    datawin
    printf "[%04X:%08X]------------------------", $cs, $eip
    printf "---------------------------------[ code]\n"
    x /6i $pc
    printf "---------------------------------------"
    printf "---------------------------------------\n"
end
document context
    Print regs, stack, ds:esi, and disassemble cs:eip
end

define context-on
    set $SHOW_CONTEXT = 1
end
document context-on
    Enable display of context on every program stop
end

define context-off
    set $SHOW_CONTEXT = 1
end
document context-on
    Disable display of context on every program stop
end

# Calls "context" at every breakpoint.
define hook-stop
    context
end

# Init parameters
set output-radix 0x10
set input-radix 0x10
set disassembly-flavor intel


# Save history commands
set history filename ~/.gdb_history
set history save on

# Quit without prompt
set confirm off

# Print objects according to derived types
set print object on

# Print array's index
set print array-indexes on

# Pretty print
set print pretty on

"""Placeholder description."""

from other import do_something_else

SOME_CONSTANT = 42

def main():
    print(SOME_CONSTANT ** 2)
    do_something()
    do_something_else()
    do_something_boring()
    
    lots_of_inline_logic = SOME_CONSTANT ** 2 + 1
    still_doing_lots_of_stuff = lots_of_inline_logic + 1
    but_all_this_stuff_is_related = still_doing_lots_of_stuff + 1

    print(but_all_this_stuff_is_related)

    MAX_16_BIT_INTEGER = 65535
    result = do_something_fancy(MAX_16_BIT_INTEGER)
    print(result)
    ...

def do_something():
    ...

def do_something_boring():
    ...

def do_something_fancy(an_argument: int) -> float:
    print(an_argument)
    return float(an_argument)
  
if __name__ == "__main__":
    main()

package main

import "core:fmt"
import "core:strings"
import "core:unicode"
import "core:strconv"
import "core:unicode/utf8"

// number struct
Nr :: struct {
  val : rune, // actual character (number),
  ind : int, // position in the line,
}

day1 :: proc(data_path: string) {
  data := get_input(data_path);
  dataArr := strings.split(string(data), "\n");
  sum := 0;
  for line in dataArr {
    sum += combine_runes_to_int(sort_nr_by_ind(get_numbers_from_line(line, true)));  
  }

  fmt.println("Part 1:: ", sum)
  sum = 0;
  for line in dataArr {
    sum += combine_runes_to_int(sort_nr_by_ind(get_numbers_from_line(line, false)));  
  }
  fmt.println("Part 2:: ", sum)
}

sort_nr_by_ind :: proc(nrs:[]Nr) -> (rune, rune){
  // sort the numbers by their index with bubble sort
  for n1, i in nrs {
    for n2, j in nrs {
      if nrs[i].ind > nrs[j].ind {
        nrs[i], nrs[j] = nrs[j], nrs[i]
      }
    }
  }
  r1, r2 : rune
  switch len(nrs) {
    case 0: 
      r1, r2 = '0', '0'
    case 1: 
      r1, r2 = nrs[0].val, nrs[0].val
    case: 
      r1, r2 = nrs[0].val, nrs[len(nrs)-1].val
  } 
  return r2, r1;
}

get_numbers_from_line :: proc(line: string, just_numbers: bool) -> ([]Nr) {
  ret : [dynamic]Nr;

  for r, i in line { // r is rune, i is index
    if unicode.is_number(r) { 
      append(&ret, Nr{r, i}); 
    } 
  }
  if just_numbers {
    return ret[:];
  } else {

    num_names := make(map[string]rune)
    num_names["one"] = '1'
    num_names["two"] = '2'
    num_names["three"] = '3'
    num_names["four"] = '4'
    num_names["five"] = '5'
    num_names["six"] = '6'
    num_names["seven"] = '7'
    num_names["eight"] = '8'
    num_names["nine"] = '9'
    for num in num_names {
      n := strings.index(line, num)
      if n != -1 {
        append(&ret, Nr{
          num_names[num],
          n,
        })
      } 
    }
    return ret[:];
  }
  panic("Something went wrong");
}

combine_runes_to_int :: proc(r1, r2: rune) -> int {
  ra := []rune {r1, r2};
  n, ok := strconv.parse_int(utf8.runes_to_string(ra)); // get the ints from the runes
  if !ok { panic("could not parse"); } // safety check
  return n;
}

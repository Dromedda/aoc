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
    sum += combine_runes_to_int(get_first_and_last_digit(get_numbers_from_line(line)));  
  }
  fmt.println(sum)
}

get_first_and_last_digit :: proc(nums: []Nr) -> (rune, rune) {
  switch len(nums) {
    case 0:
      return '0', '0';
    case 1: 
      return nums[0].val, nums[0].val;
    case: 
      return nums[0].val, nums[len(nums)-1].val;
  }
  panic("this shit does not have a number");
}

get_numbers_from_line :: proc(line: string) -> ([]Nr) {
  ret : [dynamic]Nr;
  for r, i in line { // r is rune, i is index
    if unicode.is_number(r) {
      append(&ret, Nr{r, i});
    } 
  }
  return ret[:];
}

combine_runes_to_int :: proc(r1, r2: rune) -> int {
  ra := []rune {r1, r2};
  n, ok := strconv.parse_int(utf8.runes_to_string(ra)); // get the ints from the runes
  if !ok { panic("could not parse"); } // safety check
  return n;
}

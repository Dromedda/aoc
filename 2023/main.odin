package main 

import "core:fmt"
import "core:os"

Silent := false 

main :: proc() {
  assert(len(os.args) > 1, "\nplease specify a day to run");
  switch os.args[1] {
  case "1":
    fmt.println("Running Day 1");
    day1("data/day1.txt");
  case "2":
    fmt.println("Running Day 2");
    day1("data/day2.txt");
  case: 
    fmt.println("Couldn't find day ::", os.args[1]);
    fmt.println("please try again");
  }
}

// reads a txt file and returns the data in an array of bytes 
get_input :: proc(filename : string) -> []u8 {
  data, ok := os.read_entire_file_from_filename(filename);
  if !ok {
    panic("could not read file");
  }
  return data;
}


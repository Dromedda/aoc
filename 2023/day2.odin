package main

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:unicode"

Game :: struct {
  id : int,
  sets : []Set,
  possible: bool,
}

Set :: struct {
  reds : int,
  greens : int,
  blues : int,
}

day2 :: proc(input_path: string) {
  data := get_input(input_path);
  data_arr := strings.split(string(data), "\n");
  g : [dynamic]Game

  for line in data_arr {
    g_temp := parse_line_into_game(line);
    append(&g, g_temp)
  }
  fmt.println("Part 1:: ", sum_ids(g[:]))

  sum := 0
  for game in g {
    r, g, b := get_min(game.sets[:]) 
    fmt.println(game)
    fmt.println(r, g, b)
    power := r * g * b
    fmt.println(power)
    sum += power
  }
  fmt.println("Part 2:: ", sum)

  assert(sum_ids(g[:]) == 2505, "part 1 failed");
  assert(sum_ids(g[:]) == 70265, "part 2 failed");
}

get_min :: proc(sets : []Set) -> (int, int, int) {
  r, g, b := 0, 0, 0;
  for s in sets {
    if s.reds > r { r = s.reds; }
    if s.greens > g { g = s.greens; }
    if s.blues > b { b = s.blues; } 
  }
  return r, g, b;
}

parse_line_into_game :: proc(line: string) -> (Game) {
  s : [dynamic]Set
  g : Game
  MAX_REDS :: 12; 
  MAX_GREENS :: 13; 
  MAX_BLUES :: 14;

  if len(line) == 0 { return g; }

  id_end_ind := strings.index(line, ":") ;
  g.id, _ = strconv.parse_int(line[5:id_end_ind]);
  g.possible = true
  game_inf := line[id_end_ind+2:]
  games := (strings.split(game_inf, "; "));

  for game in games {
    if len(game) == 0 { continue; }
    red := get_color_nums(game, "red");
    green := get_color_nums(game, "green");
    blue := get_color_nums(game, "blue");

    if red > MAX_REDS || green > MAX_GREENS || blue > MAX_BLUES { g.possible = false; } 
    _s := Set { red, green, blue, }
    append(&s, _s);
  }
  g.sets = s[:]
  return g 
}

sum_ids :: proc(g: []Game) -> int {
  sum := 0;
  for game in g {
    if game.possible {
      sum += game.id;
    }
  }
  return sum
}

get_color_nums :: proc(str, s : string) -> int {
  ind := strings.index(str, s);
  if ind == -1 { return -1; }
  ret := -1

  if ind == 2 {
    ret, _ = strconv.parse_int(str[0:ind-1]);

  } else {
    if str[ind-3] != ' ' {
      ret, _ = strconv.parse_int(str[ind-3: ind-1]);
    } else {
      ret, _ = strconv.parse_int(str[ind-2: ind-1]);
    }
  }
  return ret
}


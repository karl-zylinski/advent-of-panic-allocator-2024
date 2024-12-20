package advent

import "core:strings"
import "core:strconv"
import "core:fmt"
import "base:runtime"

main :: proc() {
	context.allocator = runtime.panic_allocator()
	input_data := #load("input")
	input := string(input_data)
	res: int
	Num_Set :: bit_set[0..=99]
	rules: [99]Num_Set
	processing_rules := true

	lines_iterator := input
	outer: for l in strings.split_lines_iterator(&lines_iterator) {
		if l == "" {
			processing_rules = false
			continue
		}

		if processing_rules {
			key := strconv.atoi(l[:2])
			val := strconv.atoi(l[3:])
			rules[key] += {val}
		} else {
			seen: Num_Set
			num := (len(l)-2)/3+1
			idx: int
			mid: int

			comma_iterator := l
			for n_str in strings.split_iterator(&comma_iterator, ",") {
				n := strconv.atoi(n_str)

				if idx == num/2 {
					mid = n
				}

				if rules[n] & seen != {} {
					continue outer
				}

				seen += {n}
				idx += 1
			}

			res += mid
		}
	}

	fmt.println(res) // 5651
}
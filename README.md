## Original challenge
The challenge description and full rules can be found [here](https://gist.github.com/kayluhb/5d39cb3ccddaec0d54ee).

## Rules and conditions

1. First row from input text, `N`, is the number of pattern matching options
1. After N + 1 rows, we will read in another integer `M`, which represents the number of paths to match
1. For each path, we must determine the "best match" pattern from rows 1 through `N` + 1.
  - Program execution will look like: `cat input_file | ruby pattern_match.rb > output_file`
  - The best-matching pattern is the one which matches the path using the fewest wildcards.

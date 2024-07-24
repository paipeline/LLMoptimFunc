# Requirements

To run the backtesting framework, you need to have the following packages installed in Julia:

- DataFrames
- JSON

You can install these packages by running the following commands in the Julia REPL:

```julia
using Pkg
Pkg.add("DataFrames")
Pkg.add("JSON")
```

# How to Run

1. Ensure that you have Julia installed on your system. You can download it from [the official Julia website](https://julialang.org/downloads/).

2. Place the `example.json` file in the same directory as your `run_backtest.jl` script.

3. Open a terminal and navigate to the directory containing your scripts.

4. Run the following command to execute the backtesting script:

```bash
julia run_backtest.jl
```

This will execute the backtesting process, and you should see the results printed in the terminal.

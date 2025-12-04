# Vned Runtime
# Run .vned scripts or enter interactive REPL

import sys, os, random

variables = {}
functions = {}
installed_modules = {}

def execute_line(line):
    tokens = line.strip().split()
    if not tokens:
        return

    cmd = tokens[0].upper()

    try:
        # --- Core Commands ---
        if cmd == "PRINT":
            expr = " ".join(tokens[1:])
            expr = replace_vars(expr)
            print(eval(expr))
        
        elif cmd == "SET":
            var_name = tokens[1]
            value = " ".join(tokens[2:])
            value = replace_vars(value)
            variables[var_name] = eval(value)
        
        elif cmd == "ADD":
            var_name = tokens[1]
            value = " ".join(tokens[2:])
            value = replace_vars(value)
            variables[var_name] += eval(value)

        elif cmd == "EXIT":
            print("Exiting Vned...")
            return "EXIT"

        # --- Conditionals ---
        elif cmd == "IF":
            if "THEN" not in tokens:
                print("Syntax: IF condition THEN command")
                return
            then_index = tokens.index("THEN")
            condition = " ".join(tokens[1:then_index])
            command = " ".join(tokens[then_index+1:])
            if eval(replace_vars(condition)):
                execute_line(command)

        # --- Loops ---
        elif cmd == "WHILE":
            if "DO" not in tokens:
                print("Syntax: WHILE condition DO command")
                return
            do_index = tokens.index("DO")
            condition = " ".join(tokens[1:do_index])
            command = " ".join(tokens[do_index+1:])
            while eval(replace_vars(condition)):
                execute_line(command)

        # --- Functions ---
        elif cmd == "DEF":
            func_name = tokens[1]
            func_body = " ".join(tokens[2:])
            functions[func_name.upper()] = func_body

        elif cmd in functions:
            execute_line(functions[cmd])

        # --- Built-in Library ---
        elif cmd == "RANDOM":
            min_val = int(tokens[1])
            max_val = int(tokens[2])
            print(random.randint(min_val, max_val))

        elif cmd == "LEN":
            var_name = tokens[1]
            print(len(str(variables.get(var_name, ""))))

        # --- INSTALL Command ---
        elif cmd == "VNED":
            if len(tokens) >= 3 and tokens[1].upper() == "INSTALL":
                module_name = tokens[2].lower()
                install_module(module_name)
            else:
                print("Syntax: VNED INSTALL <module>")

        else:
            print(f"Unknown command: {cmd}")

    except Exception as e:
        print("Error:", e)

# Helper to replace variables in expressions
def replace_vars(expr):
    for var in variables:
        expr = expr.replace(var, str(variables[var]))
    return expr

# Installer function: loads modules from .vned files
def install_module(name):
    if name in installed_modules:
        print(f"Module '{name}' is already installed.")
        return
    
    filename = f"{name}.vned"
    if not os.path.exists(filename):
        print(f"Module file '{filename}' not found.")
        return
    
    with open(filename, "r") as f:
        code = f.read().splitlines()
        for line in code:
            execute_line(line)  # define functions or variables
    
    installed_modules[name] = True
    print(f"Installed module: {name}")

# Run .vned file
def run_file(filename):
    if not os.path.exists(filename):
        print(f"File '{filename}' not found.")
        return
    with open(filename, "r") as f:
        code = f.read().splitlines()
        for line in code:
            if execute_line(line) == "EXIT":
                break

# REPL mode
def vned_repl():
    print("Welcome to Vned! Type EXIT to quit.")
    while True:
        line = input("Vned> ")
        if execute_line(line) == "EXIT":
            break

# --- Entry point ---
if __name__ == "__main__":
    if len(sys.argv) > 1:
        run_file(sys.argv[1])  # run script file
    else:
        vned_repl()  # start REPL

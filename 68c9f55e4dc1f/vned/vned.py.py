# Vned Interpreter with package system
import random

variables = {}
functions = {}
installed_packages = []

# Dynamic package commands
package_commands = {}

def replace_vars(expr):
    for var in variables:
        expr = expr.replace(var, str(variables[var]))
    return expr

def execute_line(line):
    tokens = line.strip().split()
    if not tokens:
        return

    cmd = tokens[0].upper()

    try:
        # ---------------- Core Commands ----------------
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
        
        elif cmd == "IF":
            if "THEN" not in tokens:
                print("Syntax: IF condition THEN command")
                return
            then_index = tokens.index("THEN")
            condition = " ".join(tokens[1:then_index])
            command = " ".join(tokens[then_index+1:])
            condition = replace_vars(condition)
            if eval(condition):
                execute_line(command)
        
        elif cmd == "WHILE":
            if "DO" not in tokens:
                print("Syntax: WHILE condition DO command")
                return
            do_index = tokens.index("DO")
            condition = " ".join(tokens[1:do_index])
            command = " ".join(tokens[do_index+1:])
            while eval(replace_vars(condition)):
                execute_line(command)

        elif cmd == "DEF":
            func_name = tokens[1]
            func_body = " ".join(tokens[2:])
            functions[func_name] = func_body
        
        elif cmd in functions:
            execute_line(functions[cmd])

        # ---------------- Built-in Library ----------------
        elif cmd == "RANDOM":
            min_val = int(tokens[1])
            max_val = int(tokens[2])
            print(random.randint(min_val, max_val))

        elif cmd == "LEN":
            var_name = tokens[1]
            print(len(str(variables.get(var_name, ""))))

        # ---------------- Package Manager ----------------
        elif cmd == "INSTALL":
            package = tokens[1].lower()
            if package not in installed_packages:
                installed_packages.append(package)
                print(f"Installed {package} successfully!")

                # Add new commands depending on package
                if package == "graphics":
                    package_commands["DRAW"] = lambda: print("Drawing a square 🟥")
                elif package == "sound":
                    package_commands["BEEP"] = lambda: print("Beep! 🎵")
                elif package == "webloader game enging":
                    package_commands["SQRT"] = lambda x: print(f"√{x} = {x**0.5}")

            else:
                print(f"{package} is already installed.")

        elif cmd == "LIST":
            print("Installed packages:", installed_packages)

        # ---------------- Exit ----------------
        elif cmd == "EXIT":
            print("Exiting Vned...")
            return "EXIT"

        # ---------------- Dynamic Package Commands ----------------
        elif cmd in package_commands:
            # Call package-specific command
            args = tokens[1:]
            if args:
                args = [eval(replace_vars(a)) for a in args]
                package_commands[cmd](*args)
            else:
                package_commands[cmd]()

        else:
            print(f"Unknown command: {cmd}")
    except Exception as e:
        print("Error:", e)

def vned_repl():
    print("Welcome to Vned with packages! Type EXIT to quit.")
    while True:
        line = input("Vned> ")
        if execute_line(line) == "EXIT":
            break

# Start the REPL
vned_repl()

# Vned REPL with Logo Display
import os
import random
import subprocess

variables = {}
functions = {}
installed_packages = []
logo_path = os.path.join(os.path.dirname(__file__), "vned_logo.png")

def show_logo():
    if os.path.exists(logo_path):
        print("Opening Vned logo...")
        try:
            if os.name == "nt":  # Windows
                os.startfile(logo_path)
            else:
                subprocess.run(["open", logo_path])  # macOS
        except:
            print(f"Logo located at {logo_path}")
    else:
        print("Vned logo not found.")

def replace_vars(expr):
    for var in variables:
        expr = expr.replace(var, str(variables[var]))
    return expr

def execute_line(line):
    tokens = line.strip().split()
    if not tokens:
        return

    cmd = tokens[0].upper()
    try:
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
        else:
            print(f"Unknown command: {cmd}")
    except Exception as e:
        print("Error:", e)

def vned_repl():
    show_logo()
    print("Welcome to Vned! Type EXIT to quit.")
    while True:
        line = input("Vned> ")
        if execute_line(line) == "EXIT":
            break

vned_repl()

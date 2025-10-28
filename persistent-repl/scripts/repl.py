#!/usr/bin/env python3
import sys
import dill
import os

STATE_FILE = ".repl_state.pkl"


def load_state():
    """Load previous REPL state if it exists"""
    if os.path.exists(STATE_FILE):
        with open(STATE_FILE, "rb") as f:
            dill.load_session(f)


def save_state():
    """Save current REPL state"""
    with open(STATE_FILE, "wb") as f:
        dill.dump_session(f)


def execute_code(code):
    """Execute Python code in the current environment"""
    exec(code, globals())


def main():
    if len(sys.argv) < 2:
        print("Usage: repl.py '<code>' or repl.py <file.py>")
        sys.exit(1)

    # Load previous state
    load_state()

    arg = sys.argv[1]

    # Check if argument is a file
    if os.path.isfile(arg):
        with open(arg, "r") as f:
            code = f.read()
        execute_code(code)
    else:
        # Treat as direct code string
        execute_code(arg)

    # Save state
    save_state()


if __name__ == "__main__":
    main()

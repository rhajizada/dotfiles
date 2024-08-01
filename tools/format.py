#!/usr/bin/env python3

import argparse
import os
import re
from typing import Optional

DEFINITION_PATTERN = re.compile(r"^[A-Z_][A-Z0-9_]+\s+.\=\s.+$", re.MULTILINE)
TARGET_PATTERN = re.compile(
    r"^(?:\.PHONY:\s*(\S+)\s*)?(?:##\s*(.*)\s*)?(\S+):(.*?)(\n\t[^\n]+(?:\n\t[^\n]+)*)?$",
    re.MULTILINE,
)


class Target:
    def __init__(
        self,
        name: str,
        help: Optional[str] = None,
        rule_target: Optional[str] = None,
        rule_prereqs: Optional[str] = None,
        recipe: Optional[str] = None,
    ):
        self.name = name
        self.help = help
        self.rule_target = rule_target
        self.rule_prereqs = rule_prereqs
        self.recipe = recipe

    def __str__(self):
        s = f".PHONY: {self.name}"
        if self.help:
            s += f"\n## {self.help}"
        if self.rule_target:
            s += (
                f"\n{self.rule_target}:{self.rule_prereqs if self.rule_prereqs else ''}"
            )
        if self.recipe:
            s += f"{self.recipe}"
        return s

    def __lt__(self, other):
        return self.name < other.name

    def __eq__(self, other):
        return self.name == other.name


class Makefile:
    def __init__(self, f: os.PathLike):
        self.__file = f
        with open(self.__file, "r") as fp:
            self.__contents = fp.read()

        self.definitions = re.findall(DEFINITION_PATTERN, self.__contents)
        self.targets = [Target(*i) for i in re.findall(TARGET_PATTERN, self.__contents)]

    def sort(self):
        self.targets = sorted(self.targets)

    def __str__(self):
        s = "\n".join(self.definitions)
        if self.targets:
            s += "\n\n"
            s += "\n\n".join([str(i) for i in self.targets])
        s += "\n"
        return s

    def dump(self, f):
        if f is None:
            f = self.__file
        with open(f, "w") as fp:
            fp.write(str(self))


def file_exists(f):
    if not os.path.isfile(f):
        raise argparse.ArgumentTypeError(
            f"Error: file '{f}' does not exist. Please verify the file path and try again."
        )
    return f


def main():
    parser = argparse.ArgumentParser(description="Format Makefile")
    parser.add_argument(
        "-i", "--input", type=file_exists, required=True, help="Path to the Makefile"
    )
    parser.add_argument(
        "-o", "--output", type=str, help="Output file to save the formatted Makefile"
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Run the formatter without making any changes",
    )
    args = parser.parse_args()
    mf = Makefile(args.input)
    mf.sort()
    if args.dry_run:
        print(str(mf))
    else:
        mf.dump(args.output)


if __name__ == "__main__":
    main()

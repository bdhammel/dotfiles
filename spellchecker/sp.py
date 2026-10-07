#!/usr/bin/env python3
# /// script
# requires-python = ">=3.12"
# dependencies = ["pydantic-ai", "anthropic[bedrock]"]
# ///

import os
import sys

from pydantic_ai import Agent

SYSTEM_PROMPT = """\
You are a spelling correction tool for a dyslexic user. Given a sentence with \
possible misspellings, identify each misspelled word and provide the correction.

Output ONLY the corrected words, one per line, formatted as:
misspelled -> corrected

If nothing is misspelled, output exactly: No misspellings found.

Do not add explanations, commentary, or extra formatting.\
"""

DEFAULT_MODEL = "bedrock:us.anthropic.claude-haiku-4-5-20251001-v1:0"

SP_MODEL_ALIASES = {
    "haiku": "bedrock:us.anthropic.claude-haiku-4-5-20251001-v1:0",
    "sonnet": "bedrock:us.anthropic.claude-sonnet-4-6",
    "opus": "bedrock:us.anthropic.claude-opus-4-6-v1",
}


def main():
    if len(sys.argv) < 2:
        print("Usage: sp <sentence with misspelled words>", file=sys.stderr)
        sys.exit(1)

    sentence = " ".join(sys.argv[1:])
    model_raw = os.environ.get("SP_MODEL", DEFAULT_MODEL)
    model = SP_MODEL_ALIASES.get(model_raw, model_raw)

    agent = Agent(model=model, system_prompt=SYSTEM_PROMPT)
    result = agent.run_sync(sentence)
    print(result.output)


if __name__ == "__main__":
    main()

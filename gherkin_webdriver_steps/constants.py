"""Constants used in regular expressions."""

# Sentinel value.
# Useful to differentiate between an argument that has not been provided, and an
# argument provided with the value `None`.
SENTINEL_VALUE = object()


UNQUOTED_STRING = r'[^\s]+'
CAPTURE_UNQUOTED_STRING = r'[^\s]+'

ESCAPED_QUOTED_STRING = r""""(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*'"""
# Using this will capture a string with their surrounding quotes.
# e.g. "can't" will be captured as `"can't"` instead of `can't`.
CAPTURE_ESCAPED_QUOTED_STRING = r"({})".format(ESCAPED_QUOTED_STRING)

QUOTED_STRING = r"""(?:'|").*(?:'|")"""
CAPTURE_QUOTED_STRING = r"""(?:'|")(.*)(?:'|")"""


AVAILABLE_REGEXES = {
    'UNQUOTED_STRING': UNQUOTED_STRING,
    'CAPTURE_UNQUOTED_STRING': CAPTURE_UNQUOTED_STRING,
    'CAPTURE_STRING': CAPTURE_QUOTED_STRING,
    'STRING': QUOTED_STRING,
}

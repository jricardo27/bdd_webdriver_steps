"""Register steps depending on which Gherkin runner is available."""

from __future__ import absolute_import

from .constants import AVAILABLE_REGEXES

__all__ = []


try:
    from aloe import step as aloe_step
    from aloe.testclass import TestStep

    ALOE_INSTALLED = True
except ImportError:
    ALOE_INSTALLED = False

try:
    from behave import step as behave_step, use_step_matcher
    from behave.runner import Context

    BEHAVE_INSTALLED = True
except ImportError:
    BEHAVE_INSTALLED = False


def meta_step(step_sentence):
    """Register a step with Aloe and Behave."""

    # Expand the regex keywords in the step sentence.
    step_sentence = step_sentence.format(**AVAILABLE_REGEXES)

    def decorator(func):
        """The real decorator."""

        if ALOE_INSTALLED:
            aloe_step(step_sentence)(func)
        if BEHAVE_INSTALLED:
            use_step_matcher('re')
            behave_step(step_sentence)(func)

        return func

    return decorator


def is_aloe(self):
    """Check if the given context belongs to Aloe."""

    return isinstance(self, TestStep)


def is_behave(context):
    """Check if the given context belongs to Behave."""

    return isinstance(context, Context)

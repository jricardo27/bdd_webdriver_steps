"""Steps used for testing."""

from gherkin_webdriver_steps.context import CommonContext
from gherkin_webdriver_steps.register import meta_step


def noop(*args, **kwargs):
    """A function that does nothing."""


meta_step('we have a BDD runner installed')(noop)
meta_step('we implement a test')(noop)
meta_step('the BDD runner will test it for us!')(noop)


@meta_step(r'I store the value {CAPTURE_STRING} in the context')
def store_in_context(self, value):
    """Store a value in the context."""

    if not getattr(CommonContext, 'stored_values', None):
        CommonContext.stored_values = []

    CommonContext.stored_values.append(value)


@meta_step(r'the value {CAPTURE_STRING} should be in the context')
def check_stored_value_in_context(self, value):
    """Check that a value is stored in the context."""

    assert value in CommonContext.stored_values, (
        "Value '{}' doesn't exists in the context.".format(value)
    )

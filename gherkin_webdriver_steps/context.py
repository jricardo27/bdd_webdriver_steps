"""Common global context for all BDD runners."""


class CommonContext(object):
    """Common global context for all BDD runners."""

    def __new__(cls, *args, **kwargs):
        if cls is CommonContext:
            raise TypeError('CommonContext class may not be instantiated')
        return object.__new__(cls, *args, **kwargs)

    @classmethod
    def reset(cls):
        """Remove all the stored values."""

        for attr_name in dir(cls):
            if not attr_name.startswith('__'):
                delattr(cls, attr_name)

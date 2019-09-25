"""Setup script."""

from setuptools import find_packages, setup

if __name__ == '__main__':
    with open('README.md', 'r') as fh:
        LONG_DESCRIPTION = fh.read()

    with open('requirements.txt', 'r') as fh:
        REQUERIMENTS = fh.readlines()

    setup(
        name='gherkin_webdriver_steps',
        description='Gherkin steps for Web Testing with Selenium.',
        author='Ricardo Perez',
        author_email='ric.perez.dev@gmail.com',
        url='https://github.com/jricardo27/gherkin_webdriver_steps',
        long_description=LONG_DESCRIPTION,
        long_description_content_type="text/markdown",
        classifiers=[
            'Development Status :: 1 - Planning',
            'Programming Language :: Python',
            'Programming Language :: Python :: 3',
            'Topic :: Software Development :: Testing',
            'Operating System :: MacOS',
            'Operating System :: POSIX :: Linux',
            'Topic :: Software Development :: Testing :: BDD',
            'License :: OSI Approved :: MIT License',
        ],
        license="GPL-3.0",

        packages=find_packages(exclude=['tests']),
        include_package_data=True,

        setup_requires=['setuptools_scm'],
        use_scm_version=True,

        install_requires=REQUERIMENTS,
    )

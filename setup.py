"""Setup script."""

from setuptools import setup, find_packages


if __name__ == '__main__':
    with open('README.md', 'r') as fh:
        long_description = fh.read()

    with open('requirements.txt', 'r') as fh:
        requirements = fh.readlines()

    setup(
        name='gherkin_webdriver_steps',
        description='Gherkin steps for Web Testing with Selenium.',
        author='Ricardo Perez',
        author_email='ric.perez.dev@gmail.com',
        url='https://github.com/jricardo27/gherkin_webdriver_steps',
        long_description=long_description,
        long_description_content_type="text/markdown",
        classifiers=[
            'Development Status :: 1 - Planning',
            'Programming Language :: Python',
            'Programming Language :: Python :: 2',
            'Programming Language :: Python :: 3',
            'Topic :: Software Development :: Testing',
            'Operating System :: MacOS',
            'Operating System :: POSIX :: Linux',
            'Topic :: Software Development :: Testing :: BDD',
            'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        ],
        license="GPL-3.0",

        packages=find_packages(exclude=['tests']),
        include_package_data=True,

        setup_requires=['setuptools_scm'],
        use_scm_version=True,

        install_requires=requirements,
    )

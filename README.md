# automated-project-template-setup

# Overview

A `bash` setup script which automatically builds a base data science project template in a private GitHub repository. 

The repository should look something like this: [automated-project-template](https://github.com/carecodeconnect/automated-project-template) 

# Requirements

- **`bash`**: Shell environment for executing the script.
- **`git`**: Required for version control operations.
- **GitHub CLI (`gh`)**: For creating repositories on GitHub.
- **`conda`**: For managing Python environments.
- **Python**: The programming language used in the environment.
- **`tree`**: For generating directory structure in `README.md`.
- **`ssh`**: For setting up SSH keys with GitHub.
- **`chmod`**: To change the script's permissions to make it executable.

# Files & Folders

The script creates a template folder structure with files suitable for a base data science project:

```
.
├── data
├── docs
├── environment.yml
├── main.py
├── notebooks
├── pyproject.toml
├── README.md
├── requirements.txt
├── src
│   └── __init__.py
├── tests
│   └── environment.py
└── tox.ini

6 directories, 8 files
```

# Environment & Packages

The template sets up the following base environment:

- **Python Version**: 3.10
- **Conda Version**: 23.11.0

- **Installed Packages**:
  - **`ipykernel`**: For Jupyter notebook integration.
  - **`sphinx`**: For generating project documentation.
  - **`flake8`**: For code linting.
  - **`mypy`**: For static type checking.
  - **`behave`**: For acceptance testing.
  - **`pip-tools`**: For managing Python package dependencies.
  - **`pytest`**: For running Python unit tests.
  - **`pytest-cov`**: For test coverage reporting.
  - **`tox`**: For testing in multiple environments.

## Requirements File
- The script generates a [requirements.txt](https://github.com/carecodeconnect/automated-project-template/blob/main/requirements.txt) file.
- This file lists the Python packages installed in the Conda environment, providing a snapshot of the environment for reproducibility.

## Project Configuration File
- The script creates a `pyproject.toml` file.
- As of the current script version, `pyproject.toml` is created as an empty file. It is not automatically populated by the script.
- `pyproject.toml` can be manually edited to specify build system requirements or other project configurations as per [PEP 518](https://www.python.org/dev/peps/pep-0518/).

## Sphinx Documentation
- The script sets up a basic [Sphynx](https://www.sphinx-doc.org/) documentation structure.
- This is done by executing `sphinx-quickstart` in the `docs` directory, which creates the necessary configuration files and directories for Sphinx.
- The generated Sphinx documentation serves as a starting point and can be further customized and expanded to document the project.


# Setup

To setup the **automated-project-template-setup** project, open a terminal, navigate to your projects directory:

```
# with HTTPS
git clone https://github.com/carecodeconnect/automated-project-template-setup.git
# with SSH 
git clone git@github.com:carecodeconnect/automated-project-template-setup.git
# make the file executable
chmod +x setup_project.sh
```

# Usage

The `bash` script requires the argument which is the name of the project.

To setup a project directory called `my_project` (which will also be the name of the GitHub repository for the project):

```
./setup_project.sh my_project
```
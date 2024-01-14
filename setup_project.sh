#!/bin/bash

# Check if project name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

make_folders_files() {
    echo "Creating project directories ..."
    mkdir "$PROJECT_NAME"
    cd "$PROJECT_NAME"
    mkdir data docs notebooks src tests
    echo "Creating initial files ..."
    touch main.py environment.yml pyproject.toml README.md requirements.txt tox.ini .gitignore src/__init__.py tests/environment.py
}

setup_conda() {
    echo "Creating the Conda environment ..."
    conda create -p "$ENV_PATH" -c conda-forge python=3.10

    echo "Activating the Conda environment ..."
    eval "$(conda shell.bash hook)"
    conda activate "$ENV_PATH"

    echo "Installing packages ..."
    conda install ipykernel sphinx

    echo "Installing packages ..."
    python -m pip install behave flake8 mypy pip-tools pytest pytest-cov tox

    echo "Documenting requirements ..."
    conda list -e > requirements.txt
}

update_readme() {
    echo "Updating README.md"
    echo "# $PROJECT_NAME" > README.md

    # Append sections to README.md
    echo "# Overview" >> README.md
    echo "" >> README.md
    echo "# Requirements" >> README.md
    echo "" >> README.md
    echo "# Dataset" >> README.md
    echo "" >> README.md
    echo "# Methods" >> README.md
    echo "" >> README.md
    echo "# Tools" >> README.md
    echo "" >> README.md
    echo "# Results" >> README.md
    echo "" >> README.md

    # Append the Files and Folders section and start of the code block
    echo "# Files and Folders" >> README.md
    echo "" >> README.md
    echo "\`\`\`" >> README.md

    # Append the output of the tree command to README.md
    echo "Generating directory structure..."
    tree -I "envs|.git" >> README.md

    # Close the code block
    echo "\`\`\`" >> README.md

    # Append the remaining sections to README.md
    echo "# Setup" >> README.md
    echo "" >> README.md
    echo "# Usage" >> README.md
    echo "" >> README.md
    echo "# Testing" >> README.md
}

setup_git() {
    echo "Updating .gitignore"
    echo "
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*.pyd

# C extensions
*.so

# Jupyter Notebook
.ipynb_checkpoints

# Python virtual environment
envs/
.venv
.env
*.sqlite3

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# pytest
.pytest_cache/
htmlcov/
.coverage
.coverage.*
*.cover
*.py,cover
.cache
nosetests.xml
coverage.xml
*,cover
.hypothesis/

# pyenv
.python-version

# tox
.tox/
.log
local/

# Operating System Files
.DS_Store
Thumbs.db

# IDE/Editor specific files
.idea/
.vscode/
*.swp
*~
*.bak
*.tmp

# Build artifacts
build/
dist/
*.egg-info/
*.egg
MANIFEST
*manifest.in

# Logs and databases
*.log
*.sql
*.sqlite

# Other
instance/
*.bak
*.swp
*.swo

# Testing artifacts
*.cover
*.coverage.*
.coverage
.coverage.*
cache
nosetests.xml
coverage.xml
*.py,cover
.hypothesis/
.pytest_cache/

# Distribution / packaging
.Python
develop-eggs/
eggs/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/
.coverage.*
*.coverage
*.cache
nosetests.xml
coverage.xml
*.py,cover
.hypothesis/
.pytest_cache/" >> .gitignore

    echo "Initializing git repository ..."
    git init

    echo "Tracking files with git ..."
    git add .

    echo "Commiting files with git ..."
    git commit -m "Initial commit"
}

setup_sphynx() {
    # Setup Sphinx documentation
    cd docs
    sphinx-quickstart
    cd ..
}

setup_github(){
    gh repo create $PROJECT_NAME --private --description "Repository for the $PROJECT_NAME project"

    git remote add origin git@github.com:carecodeconnect/$PROJECT_NAME.git

    git push -u origin main
}


echo "Setting PROJECT_NAME variable ..."
PROJECT_NAME=$1

echo "Creating project called $PROJECT_NAME"

make_folders_files

echo "Setting environment path ..."
ENV_PATH="$(pwd)/envs/.${PROJECT_NAME}_env"

setup_conda

update_readme

setup_sphynx

setup_git

setup_github

echo "$PROJECT_NAME created"

echo "activate this environment with conda activate $ENV_PATH"

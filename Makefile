.PHONY: test lint clean clean-pyc clean-build clean-test docs docker-build

init:
	python setup.py install

# TODO: fix here
test:
	python setup.py test

lint:
	flake8 ophydia tests --ignore=E122,E124,E127,E128,E501,E731

clean: clean-build clean-pyc clean-test

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rmdir {} +

clean-test:
	find . -name 'htmlcov' -exec rm -rf {} +

docs:
	rm -f docs/ophydia.rst
	rm -f docs/modules.rst
	sphinx-apidoc -o docs/ -d 2 ophydia/
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	open docs/_build/html/index.html

docker-build:
	@docker build -t ophydia \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` 
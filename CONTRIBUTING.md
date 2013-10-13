# How to contribute

Please follow these simple guidelines,
and question them if they don't make sense.


## Overview

* the `master` branch
    * contains the source = [http.fsm.cosmogol](http.fsm.cosmogol) (and [http.graffle](http.graffle) for now)
    * contains the distribution = the auto-generated [http.fsm.json](http.fsm.json)
and [http.png](http.png)
    * contains the documentation = the markdown files
    * the source (WIP) and the distribution may obviously be out-of-sync in the
      HEAD
* the `generator` branch
    * contains support scripts to regenerate the distribution in the `master`
      branch based on the source files in the same `master` branch

Corollary:

* if you want to add/change the FSM, use `master` as base, and only submit changes to the source or documentation


## How to prepare

* You need a [GitHub account](https://github.com/signup/free)
* [Submit an issue](https://github.com/for-GET/http-decision-diagram/issues) if
  the not submitted beforehand.
	* Describe the issue.
	* Ensure that you're using the latest version.
* Fork the repository on GitHub


## Make Changes

* In your forked repository, create a topic branch for your upcoming patch based
  on one of the two main branches: `master` or `generator`.
* Make commits of logical units and describe them properly.


## Submit Changes

* Push your changes to a topic branch in your fork of the repository.
* Open a pull request to the original repository and choose the right original branch you want to patch.
* If not done in commit messages (which you really should do) please reference and update your issue with the code changes.
* Even if you have write access to the repository, do not directly push or merge pull-requests. Let another team member review your pull request and approve.


Note: these guidelines are closely following [vagrant's contributing guidelines](https://raw.github.com/mitchellh/vagrant/master/CONTRIBUTING.md)

Makefile snippets (aka "makelets" :smile:) that I use for building golang projects.
Everyone likes their own, I like these :bowtie:  Just wanted a public
place to put them so I don't end up with scattered copies everywhere.

For full batteries-included simplicity, use in a makefile as follows
(make sure you replace the spaces with a tab).

````
-include $(GOPATH)/src/github.com/boyvinall/gomake/batteries.mk
$(GOPATH)/src/github.com/boyvinall/gomake/batteries.mk:
	go get github.com/boyvinall/gomake
````

Included in this repo is complete working [Makefile](example/Makefile), just
drop that file in the root of your go project.

Take a look in that file to see the make rules included.  If you want more
control over things then you can instead include just the tool definitions:

````
-include $(GOPATH)/src/github.com/boyvinall/gomake/gotools.mk
$(GOPATH)/src/github.com/boyvinall/gomake/gotools.mk:
	go get github.com/boyvinall/gomake
````

# Supported Tools

## glide

There are a plethora of package managers / vendoring tools for go at the moment.
I currently use [glide](https://github.com/Masterminds/glide).

## gometalinter

Superb wrapper to simplify running a whole bunch of linters on your code.
See [gometalinter](https://github.com/alecthomas/gometalinter)

This makelet defines a few settings which you can override before you include
gomake.

## goconvey

The [goconvey](https://github.com/smartystreets/goconvey) makelet needs no other
integration in your main makefile. Just run as follows (from your repo):

````
$ make goconvey
````

And it should install itself and fire up a webpage on http://127.0.0.1:8080.
All your `go test` tests will be run on any code change, and you can
get browser notifications when a test fails.

## gocov

[gocov](https://github.com/axw/gocov) provides a nice wrapper around `go test`
by simplifying the process of getting code coverage on a per-package basis.
The [gocov-html](https://github.com/matm/gocov-html) generates a nice HTML file
where you can easily see which source lines are not tested.

## rice
Useful to embed directories of static files into binaries.
See [go.rice](https://github.com/GeertJohan/go.rice)

## gopherjs
golang in the browser #FTW. See [gopherjs](https://github.com/gopherjs/gopherjs)

## gravitational/version
Allows you to print the git tag/hash of the repo when your app runs.

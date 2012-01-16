This is the source for David Carlton's "fragments" microblogging platform: see [this blog post](http://malvasiabianca.org/archives/2011/11/fragments/) for explanation of what it's about.

If anybody else cares enough to want to use it, let me know and I'll provide more explanation; the short version is that `${FRAGMENTS_TEXT}` should refer to a directory containing subdirectories `fragments` and `mosaics`. The former should contain one file for each fragment (in [Markdown](http://daringfireball.net/projects/markdown/syntax) format), the latter should contain one file for each mosaic, where the file contains the list of fragments making up the mosaic, using initial asterisks for indentation. When you have a fragment/mosaic ready for public consumpution (possibly with the help of `bin/preview.sh`), pass it to `bin/publish.sh`; eventually, you'll want to run `bin/publish_apache.sh` to publish the whole lot.

Right now, mosaics aren't supported as well as regular fragments: in particular, neither they nor their feed shows up on the front page.

This depends on the `redcarpet` and `atom-tools` gems; for the former, you'll need a 2.x version, which (as of this writing) means that you'll need to explicitly specify a beta version.

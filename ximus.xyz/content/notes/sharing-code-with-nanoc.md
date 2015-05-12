---
title: How to share common code and layouts between nanoc projects
description: How to share common code and layouts between nanoc projects
keywords: nanoc, sharing, share, code, common, layouts, filters, helpers, ruby
layout: notes
kind: article
---

You may want to share common code among a few [Nanoc](http://nanoc.ws/) projects.

Here is an easy way I did it.

To share common ruby filters and helpers, put this in each project's `lib/default.rb`:

~~~ ruby
Dir["../../shared/lib/*"].each { |path| require path }
~~~

To share common layouts and content, add the following data source to your `nanoc.yml` file:

~~~ yaml
-
  # data source for shared items
  layouts_dir: ../../shared/layouts
  content_dir: ../../shared/content
~~~
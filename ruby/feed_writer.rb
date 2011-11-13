require 'rubygems'
require 'atom/feed'

class FeedWriter
  def initialize(title, paths)
    @title = title
    @paths = paths
    @entries = Set.new
  end

  MaxEntries = 50

  def add(name, text, timestamp)
    entry = Atom::Entry.new

    add_id_link(entry, @paths.fragment(name))
    entry.content = text
    entry.content.type = "html"
    entry.updated = timestamp

    @entries << entry
  end

  def write
    sorted_entries = @entries.sort { |a, b| b.updated <=> a.updated }.take(MaxEntries)
    feed = Atom::Feed.new
    feed.title = "Malvasian Fragments: #{@title}"
    author = Atom::Author.new
    author.name = "David Carlton"
    feed.authors << author
    add_id_link(feed, @paths.fragments)
    feed.updated = sorted_entries[0].updated
    sorted_entries.map { |entry| feed << entry }
    "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n#{feed.to_s}"
  end

  def add_id_link(element, location)
    element.id = location
    link = Atom::Link.new
    link.href = location
    link.type = "text/html"
    link.rel = "alternate"
    element.links << link    
  end
end

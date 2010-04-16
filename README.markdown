MailFaKK2
=========

A email to fax gateway for asterisk. It will work as a procmail filter.


Motivation
==========

After trying out several other email to fax gateways we came to the conclusion that not any of them

 * does not need java
 * is compatible with asterisk 1.6
 * does not cost money
 * has tests
 * just works

MailFaKK2 tries to live up to all these requirements.


Installation
============

Debian / Ubuntu
---------------

 * sudo apt-get install ruby ruby-dev gs unoconv openoffice.org-headless rubygems xvfb librmagick-ruby 
 * sudo gem install mailfakk2

Cons
====

If you plan to spam by fax you should consider another product. MailFaKK2 is
kind of slow. This is caused by launching OpenOffice.org for every conversion.
Speed is not a priority for us (yet).

TODO
====

 * [x] generate cover sheet TIFF frame from email body
 * [x] append OpenOffice.org documents 
 * [ ] append MS Office documents
 * [ ] write TIFF and callfile
 * [-] procmail mode (untested)
 * [ ] header and footer for every frame
 * [ ] gemspec
 * [ ] check if fax was delivered (callfile moved to outgoing_done)

Meta
====

This product is proudly presented to you by [Planetary Networks](http://planetary-networks.de).

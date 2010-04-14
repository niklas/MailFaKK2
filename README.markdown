MailFaKK2
=========

A email to fax gateway for asterisk. It will work as a procmail filter.


Motivation
==========

After trying out several other gateways we did not find any which
 * does not need java
 * is compatible with asterisk 1.6
 * does not cost money
 * has no tests
 * just works


Installation
============

Debian / Ubuntu
---------------
 * sudo apt-get install imagemagick gs unoconv openoffice.org-headless rubygems
 * sudo gem install active_support andand rmagick mail prawn

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
 * [ ] procmail mode
 * [ ] header and footer for every frame


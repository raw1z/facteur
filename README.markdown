# facteur #

Facteur allows you add a messages management system in your Rails 3. You can create many mailboxes for your users. They will be able to send and receive messages.

## Installation ##

Just run the following command :

    gem install facteur
    
## Usage ##

Install the gem as described above, then run the executable :

    parchemin BLOG_NAME AUTHOR_NAME
    
Any Rack-compliant server can run your newly created blog. For example, run the following command from inside the blog directory :

    thin start
    
Then just add your articles in the articles directory. Parchemin only support Markdown as markup language. So your articles files must have a '.markdown' extension. Don't forget to add a meta-data header at the top of every files you add. For example :

    <!-- title : "Lorem ipsum" -->
    <!-- created_at : Date.civil(2010, 3, 23) -->
    <!-- abstract : "Lorem ipsum dolor sit amet, consectetur adipisicing elit...mollit anim id est laborum." -->
    <!-- tags : %w(tutorial sinatra) -->
    
That's all!! You will find some examples in GEM_PATH/bin/articles. For more information, visit [http://parchemin.raw1z.fr](http://parchemin.raw1z.fr).

## Note on Patches/Pull Requests ##
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright ##

Copyright (c) 2010 Rawane ZOSSOU. See LICENSE for details.

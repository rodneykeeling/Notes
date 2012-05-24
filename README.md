# Notes
Notes is a simple to-do app built on Sinatra. Features include basic user accounts with private notes (ability to make notes public coming soon), option to mark a note as complete/incomplete, currently a read-only JSON and XML API, and all create, edit, and delete functionality.

Currently, Notes is functional, but still under heavy development. Features under development include an admin panel to control user accounts and settings, a user settings page with relevant setting options, and an option to mark notes as public or private (public notes are displayed on the homepage when a user is logged out). This is more of a personal project than anything, so take it for what it is. :]

To use, simply go to the root directory of the project, and run <code>bundle install</code>, then <code>ruby index.rb</code>. Then  visit <code>localhost:4567</code> in your browser. Currently, this project uses the following gems: sinatra, bcrypt-ruby, and datamapper.

![Screenshot](http://i.imgur.com/WGTQA.png)

MigBash
=======

Simple way to accumulate and use bash utilities

### Just provide **-h** parameter to show help info ###

```
#!bash

$ ./migbash -h
Usage:
      ./migbash [-m] [-h]
      ./migbash [module_name] [module_method] [options]...

```
Obviously one can use short form, just type: 

```
#!bash

$ mv ./migbash.sh mb
```
and then use it:

```
#!bash

$ ./mb -h or whatever
```
Use **-m** parameter to show list of available modules with methods/submodules:

```
#!bash

$ ./migbash.sh -m
```

![modules list](http://dl.dropboxusercontent.com/u/44917065/MigBash/MigBash_1.png)

You can simply use listed modules e.g.:

```
#!bash

$ ./migbash.sh db backup
$ ./migbash.sh wp add_user
$ ./migbash.sh migrate migrate
etc...
```
# How to create simple module: #
Go to migbash/modules folder. Feel free to create new folder if it's necessary or use existing one.
Let's create new folder, it will be your module's name:
```
#!bash

$ mkdir foobar
```
Create file, e.g. my_module: touch my_module
Write down next strings:

```
#!bash

showme() {
    echo "Hello from My module!"
}
```
Go to the folder where migbash.sh is placed:

```
#!bash

$ cd ../../
```
Run your module:

```
#!bash

$ ./migbash.sh foobar showme
```
As a result you'll see the string:

```
#!bash

Hello from My module!
```
Add the following method into your module:

```
#!bash

my_module_help() {
    echo -e "$(MigBash::color showme cyan black)$(MigBash::margin 16) – My first module ShowMe"
}
```
Now if you type *$ ./migbash -m* you will see simple info about your module:

![MigBash modules list](http://dl.dropboxusercontent.com/u/44917065/MigBash/MigBash_2.png)

# MigBash internal methods: #
Using **MigBash::getVal paramName** method you can retrieve value for provided parameter from a configuration file

```
#!bash

# path to config file
local settings='modules/'${module}'/db.ini'
local db_user=$(MigBash::getVal db_user ${settings})
local db_pass=$(MigBash::getVal db_pass ${settings})
local config_path=$(MigBash::getVal path ${settings})
```
And here is an example of db.ini configuration file:

```
#!bash

[backup]
db_user=user
db_pass=pass
db_host=127.0.0.1
db_port=3306
path=/home/path/to/smth/
```
You can use **MigBash::color** function to colorize output:

MigBash::color 'some text' *foreground_color background_color*

```
#!bash

$(MigBash::color showme cyan black)
```
For the moment available colors are: *black, red, green, yellow, blue, magenta, cyan, white*

Also you can use **MigBash::margin** function to make margins for your text:

*next call will shift the text position into 16 points*

```
#!bash

MigBash::margin 16
```
## Some examples: ##
### Using db backup module ###
You can make database backup with this command:

```
#!bash

$ ./migbash.sh db backup your_db_name /path/to/save/backup
```
Or you can just call:

```
#!bash

$ ./migbash.sh db backup
```
and make a backup via simple dialog:

![MigBash db backup](http://dl.dropboxusercontent.com/u/44917065/MigBash/MigBash_3.png)

Path to place database backup:

![MigBash db backup](http://dl.dropboxusercontent.com/u/44917065/MigBash/MigBash_4.png)


The same way you can use , e.g. wordpress modules:

```
#!bash

$ ./migbash.sh wp add_user
$ ./migbash.sh wp change_domain
etc...
```
Or you can provide parameters to the modules if you don't want to use dialogs

# dotfiles

My own dotfiles.

## Usage

### On \$HOME

```
$ git clone git@github.com:orangevtr/dotfiles.git ~/.dotfiles
$ .dotfiles/bootstrap.sh
```

### If cannot taint $HOME 

```
$ cd dir_only_for_me
$ git clone git@github.com:orangevtr/dotfiles.git ~/.dotfiles
$ ln -sfv .dotfiles/start_myenv.sh
$ ./start_myenv.sh
$ .dotfiles/bootstrap.sh
```

## Options

### --with-anyenv

Install anyenv when bootstrap

```
$ .dotfiles/bootstrap.sh --with-anyenv
```

Repoman
=======
A command tool to add, update or remove packages from your personal Arch Linux repository.

## Configuration
You have to set properly your repoman configuration: you must edit _/etc/repoman.conf_ or copy it as _~/.repoman.conf_

## Examples

    $ repoman -S --new foo //Add foo to your new repo
    $ repoman -R foo //Remove foo from your repo
    $ repoman -Se foo //Add foo to your repo, do not extract source tarball (using $workspace/pkgs/foo/src dir)
    $ repoman -Svb foo //Add foo to your repo, verbose, overwrite the existing foo package if exists in in $workspace/
    $ repoman -Sfl foo //Add foo to your repo although it is already in your repo and with the same version, log makepkg output
    $ repoman -S foo --nochangelog --noconfirm //Add a package, do not use a changelog file, do not ask
    $ repoman -Sp foo //Add a package to your repo built using the PKGBUILD from $workspace/pkgs/foo/PKGBUILD

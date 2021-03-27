# Packaging a shell script using Nix

We have a simple [`hello.sh`](bin/hello.sh) Bash script with a normal sha bang:

```
$ mkdir bin
$ vim bin/hello.sh
$ cat bin/hello.sh 
#! /usr/bin/env bash

echo Hello.
$ chmod +x bin/hello.sh 
$ bin/hello.sh 
Hello.
```

Note that the script, which is very simple, works on any machine, even without
Nix installed.

We can write a [`default.nix`](default.nix) file to create a derivation that
provides our script when built.

```
$ vim default.nix
$ nix-build 
...
/nix/store/am1pnyvrdv433v33j2f9bfh8v28azr34-hello
```

The path in the Nix store depends on the content of the `hello.sh` script and
the Nix derivation, which uses nixpkgs. This means that a different nixpkgs
might generate a different path.

On the other hand, even if we add comments to the `default.nix` file or modify
the content of this `README.md` file, repeating the `nix-build` command again
will produce the same path in the Nix store every time, and Nix will reuse the
existing result:

```
$ nix-build 
/nix/store/am1pnyvrdv433v33j2f9bfh8v28azr34-hello
```

Note that we have decided to name the file `hello` instead of `hello.sh` when
we packaged it (but we're not forced to do so), and that Nix will rewrite the
sha bang to depend on a specific Bash interpreter:

```
$ cat /nix/store/am1pnyvrdv433v33j2f9bfh8v28azr34-hello/bin/hello 
#!/nix/store/9ywr69qi622lrmx5nn88gk8jpmihy0dz-bash-4.4-p23/bin/bash

echo Hello.
```

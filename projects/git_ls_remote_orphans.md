# Requesting a list of all Git commits from a forge

The documentation for gitnamespaces has this in its [security section](https://git-scm.com/docs/gitnamespaces#_security):

> The fetch and push protocols are not designed to prevent one side from
> stealing data from the other repository that was not intended to be shared. If
> you have private data that you need to protect from a malicious peer, your
> best option is to store it in another repository. This applies to both clients
> and servers. In particular, namespaces on a server are not effective for read
> access control; you should only grant read access to a namespace to clients
> that you would trust with read access to the entire repository.
>
> The known attack vectors are as follows:
>
> 1. The victim sends "have" lines advertising the IDs of objects it has that
>    are not explicitly intended to be shared but can be used to optimize the
>    transfer if the peer also has them. The attacker chooses an object ID X to
>    steal and sends a ref to X, but isn’t required to send the content of X
>    because the victim already has it. Now the victim believes that the
>    attacker has X, and it sends the content of X back to the attacker later.
>    (This attack is most straightforward for a client to perform on a server,
>    by creating a ref to X in the namespace the client has access to and then
>    fetching it. The most likely way for a server to perform it on a client is
>    to "merge" X into a public branch and hope that the user does additional
>    work on this branch and pushes it back to the server without noticing the
>    merge.)
>
> 2. As in #1, the attacker chooses an object ID X to steal. The victim sends an
>    object Y that the attacker already has, and the attacker falsely claims to
>    have X and not Y, so the victim sends Y as a delta against X. The delta
>    reveals regions of X that are similar to Y to the attacker.

Where in the Git protocol are these “have” lines exposed? Is it available in
libgit2 (I assume not)? Could it be extracted to a separate routine?

## Git

- `do_fetch(_, _, _)` (fetch.c)
  - `must_list_refs = 1`: Must execute a branch that sets this
  - `transport_get_remote_refs(_, _)` (transport.c)
    - `transport->vtable->get_refs_list(_, for_push = 0, _)`
      - `vtable.get_refs_list = get_refs_list` (transport-helper.c)
        - Set by `transport_helper_init` (transport-helper.c), called in
          `transport_get` (transport.c) when the remote is a foreign VCS
      - `builtin_smart_vtable->get_refs_list = get_refs_via_connect` (transport.c)
        - Set in `transport_get` (transport.c)
        - `get_refs_via_connect` (transport.c)
          - `handshake(_, _, _, must_list_refs = 1)` (transport.c)
            - Server protocol v2:
              `get_remote_refs(_, _, _, for_push = 0, _, _, _)` (connect.c)
            - Server protocol v0 or v1:
              `get_remote_heads(_, _, 0, _, _)` (connect.c)
      - `taken_over_vtable->get_refs_list = get_refs_via_connect` (transport.c)
        - Set by `do_take_over` (transport-helper.c)
        - (see above)
      - `bundle_vtable->get_refs_list = get_refs_from_bundle` (transport.c)
        - Set in `transport_get` (transport.c)
        - `get_refs_from_bundle(_, for_push = 0, _)` (transport.c)
          - `get_refs_from_bundle_inner` (transport.c)

## libgit2

- [`git_remote_ls`](https://libgit2.org/libgit2/#HEAD/group/remote/git_remote_ls)
  (src/libgit2/remote.c, include/git2/remote.h)
  - `remote->transport->ls` (`struct git_transport` in include/git2/sys/transport.h)
    - `.ls = git_smart__ls` (`git_transport_smart` in src/libgit2/transports/smart.c)
      - `git_smart__ls` (src/libgit2/transports/smart.c)
        - The data has already been retrieved
    - `.ls = local_ls` (`git_transport_local` in src/libgit2/transports/local.c)
      - `local_ls` (src/libgit2/transports/local.c)
        - The data has already been retrieved

`git_remote_ls` just retrieves the already-fetched refs from the transport. This
list is available after connection and until a new connection is initiated.

## Use case: Quine Relay

[Quine Relay](https://github.com/mame/quine-relay) is a quine that cycles
through 128 languages, starting and ending with a Ruby program. On its master
branch, only QR.rb is committed, along with the helper scripts to generate it,
because the author [considers](https://github.com/mame/quine-relay/issues/9) the
intermediate sources to be large and awkward. The [spoiler branch](https://github.com/mame/quine-relay/tree/spoiler)
was created to address this, which is pushed to by a build job that kicks off
after every push to master; however, spoiler is force pushed, so it has no
history. The build is very slow and fraught with resolving old versions of
dependencies, despite having a Dockerfile.

With a full list of commits once pushed to GitHub, these now-orphaned spoiler
commits could be retrieved. I've [gathered](https://github.com/thaliaarchi/repo-archival/blob/main/scripts/quine-relay.sh)
what spoiler commits are publicly visible using ad hoc sources, such as forks,
GitHub actions logs, the GitHub events API, and snapshots on the Software
Heritage archive, but many are missing.

Another approach I had not earlier considered could be to build an interpreter
for the features used by each language in the chain. This assumes each simply
uses repeated print routines, like QR.ws does.

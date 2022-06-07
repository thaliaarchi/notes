# Trivia about Rust Types

by Jon Gjengset [[Twitter](https://twitter.com/jonhoo/status/1532761983606411264)]
[[r/rust](https://www.reddit.com/r/rust/comments/v4dnaj/twitter_thread_with_trivia_about_rust_types/)]

transcribed by Jimmy Hartzell [[blog](https://www.thecodedmessage.com/posts/trivia-rust-types/)]

## `std::fmt::Debug`

Did you know that the Formatter argument to `Debug::fmt` makes it really easy to
customize debug representations for structs, enums, lists, and sets? See the
`debug_*` methods on it.

## `Formatter`

Did you know that `std::fmt::Formatter` is super easy to use if you want more
control over debugging for a custom type? For example, to emit a “list-like”
type, just `Formatter::debug_list().entries(self.0.iter()).finish()`.

## `Option<T>`

Did you know that `Option<T>` implements `IntoIterator` yielding 0/1 elements,
and you can then call `Iterator::flatten` to make that be 0/n elements if T:
IntoIterator?

## `type EmptyTupleList = Vec<()>`

Did you know that since `()` is a zero-sized type, and the vector never actually
has to store any data, the capacity of `Vec<()>` is `usize::MAX`!

## `T`

Did you know that `T` doesn’t imply ownership? When we say a type is generic
over `T`, that `T` can just as easily be a reference to something on the stack,
and the type system will still be happy. Even `T: 'static` doesn’t imply owned —
consider `&'static str` for example.

[Reminds me of this [excellent article](https://github.com/pretzelhammer/rust-blog/blob/master/posts/common-rust-lifetime-misconceptions.md)
-Jimmy]

## `std::sync::mpsc::channel::Sender`

Did you know that `std::sync::mpsc` has had a [known bug since 2017](https://github.com/rust-lang/rust/issues/39364),
and that the implementation may actually be replaced entirely with the crossbeam
channel implementation? https://github.com/rust-lang/rust/pull/93563

## `u128`

Did you know that even though we got `u128` a long time ago now, we still don’t
have `repr(128)`? https://github.com/rust-lang/rust/issues/56071

## `std::ffi::OsString`

Did you know that there are per-platform extension traits for `OsString` that
bake in the assumptions you can safely make on that platform? Such as
[strings being `[u8]` on Unix](https://doc.rust-lang.org/std/os/unix/ffi/trait.OsStringExt.html)
and [UTF-16 on Windows](https://doc.rust-lang.org/std/os/windows/ffi/trait.OsStringExt.html).

## `std::ptr::NonNull`

Did you know that one of the super neat features of `NonNull` is that it enables
the same niche optimization that regular references and the `NonZero*` types get
where `Option<NonNull<T>>` is the same size as `*mut T`?

## `Cow<T>`

Did you know that there used to be a special `IntoCow` trait, but it was
deprecated before 1.0 was released!
https://github.com/rust-lang/rust/issues/27735

## `Box<T>`

Did you know that `Box<T>` is a `#[fundamental]` type, which means that it’s
exempt from the normal rules that don’t allow you to implement foreign traits
for foreign types (assuming T is a local type)?

## `std::process::Child`

Did you know that `std` has [three different ways](https://github.com/rust-lang/rust/blob/master/library/std/src/sys/unix/process/process_unix.rs)
to spawn a child process on Linux (`posix_spawn`, `clone3`/`exec`,
`fork`/`exec`) depending on what capabilities your kernel version has?

## `Pin<T>`

Did you know that the name `Pin` (and the name `Unpin`) where both heavily
debated? Pin was almost called Pinned, for example. [The discussion](https://github.com/rust-lang/rust/issues/55766#issuecomment-438789462)
is an interesting read now after the fact.

## `Vec<T>`

Did you know that `Vec::swap_remove` is way faster than `Vec::remove` if you can
tolerate changes to ordering?

Did you know that the smallest non-zero capacity for a `Vec<T>`
[depends on the size of `T`](https://github.com/rust-lang/rust/blob/9a74608543d499bcc7dd505e195e8bfab9447315/library/alloc/src/raw_vec.rs#L106-L110)?

## `CStr`

Did you know that `CStr::default` creates a `CStr` that points to a const string
`"\0"` stored in the binary text segment, which means all default `CStr`s point
to the same (non-null) string!

## `for<'a> SomeTrait<'a>`

Did you know that you can use `for<'a>` to say that a bound has to hold for any
lifetime `'a`, not just a specific lifetime you happen to have available at the
time. For example, `<T> for<'a>: &'a T: Read` says that any shared reference to
a `T` must implement `Read`.

## [`This monstrous warp type`](https://gist.githubusercontent.com/fasterthanlime/de0955a8b29d0d66110983ebb5fae442/raw/1827a3afbca01cd42eafd0905cfdc451da805cb7/gistfile1.txt)

Did you know that the trailing commas you see in some places in there, `,)`, are
to [distinguish one-element tuples from regular parenthetical expressions](https://doc.rust-lang.org/nightly/reference/expressions/tuple-expr.html)?

## `FnOnce`

Did you know that until Rust 1.35, you couldn’t call a `Box<dyn FnOnce>` and
needed a special type (`FnBox`) for it! This was because it requires “unsized
rvalues” to implement, which are still unstable today.
https://github.com/rust-lang/rust/issues/28796 +
https://github.com/rust-lang/rust/issues/48055

## `f32`

Did you know that in Rust 1.62 we’ll get a deterministic ordering function for
floating point numbers? https://github.com/rust-lang/rust/pull/95431

## `Arc<T>`

Did you know that `Arc` has a `make_mut` method that effectively gives you
copy-on-write? Given a `&mut Arc<T>`, it will either give you `&mut T` if there
are no other `Arc`s, or it will clone `T`, make the `Arc<T>` point to that new
`T`, and then give you a `&mut` to it!

## `!`

Did you know that `std::convert::Infallible` is the “original” `!`, and that the
plan is to one day replace `Infallible` with a type alias for `!`?

## `fn`

Specifically, did you know that the name of a function is not an `fn`? It’s a
`FnDef`, which can then be [coerced to a `FnPtr`](https://github.com/rust-lang/rust/issues/86654#issuecomment-869173835)?

## `PhantomData`

Did you know that it’s actually kind of tricky to define `PhantomData` yourself:
https://github.com/dtolnay/ghost

## `u32`

Did you know that `u32` now has associated constants for `MIN` and `MAX`, so you
no longer need to use `std::u32::MIN` and can use `u32::MIN` directly instead?

## `bool`

Did you know that bool isn’t just “stored as a byte”, the compiler straight up
declares its representation as [the same as that of u8](https://github.com/rust-lang/rust/blob/master/compiler/rustc_middle/src/ty/layout.rs#L676-L682)?

## `Any`

Did you know that `Any` is *really* non-magical? It just has a blanket
implementation for all `T` that returns `TypeId::of::<T>()`, and to downcast it
simply compares the return value of that trait method to see if it’s safe to
cast to downcast to a type! `TypeId` is magic though.

## `Self`

Did you know that `fn foo(self)` is syntactic sugar for `fn foo(self: Self)`,
and that one day you’ll be able to use other types for `self` that involve
`Self`, like `fn foo(self: Arc<Self>)`?
https://github.com/rust-lang/rust/issues/44874

## `()`

Did you know that `()` implements `FromIterator`, so you can
`.collect::<Result<(), E>>` to just see if anything in an iterator erred?

[Note that this doesn’t say whether or not this is a good idea. -Jimmy]

## `struct S`

Did you know that `struct S` implicitly declares a constant called `S`, which is
why you can make one using just `S`?

## `RefCell`

Did you know that RefCell allows you to replace a value in-place directly (like
`std::mem::replace`)?
https://doc.rust-lang.org/std/cell/struct.RefCell.html#method.replace

## `core::num::Wrapping`

Did you know that there used to also be a trait accompanying `Wrapping`,
`WrappingOps`, that was removed last minute before 1.0?
https://github.com/rust-lang/rust/pull/23549

## `*const T`

Did you know that, at least for the time being, `*const T` and `*mut T` are more
or less equivalent?
https://github.com/rust-lang/unsafe-code-guidelines/issues/257

## `std::os::unix::net::UnixStream`

Did you know that (on nightly) you can pass UNIX file descriptors over
UnixStreams too, and thereby [give another process access](https://doc.rust-lang.org/std/os/unix/net/struct.SocketAncillary.html#method.add_fds)
to a file it may not otherwise be able to open?

## `std::sync::Condvar`/`Mutex`

Did you know that Mara is doing some awesome work on making `Condvar` (and
`Mutex` and `RwLock`) much better on a wide array on platforms?
https://github.com/rust-lang/rust/issues/93740

## `std::task::Waker`

Did you know that `Waker` is secretly just a `dyn std::task::Wake + Clone` done
in a way that doesn’t require a wide pointer or support for multi-trait dynamic
dispatch? See https://doc.rust-lang.org/std/task/struct.RawWakerVTable.html

## `impl Trait`

Did you know that `impl Trait` in argument position and `impl Trait` in return
position represent completely different type constructs, even though they “feel”
related? https://doc.rust-lang.org/nightly/reference/types/impl-trait.html

## `BTreeMap<K, V>`

Did you know that `BTreeMap` is one of the few collections that still doesn’t
have a `drain` method? https://github.com/rust-lang/rust/issues/81074

## `struct InvariantLifetime<'id>(PhantomData<*mut &'id ()>);`

Did you know that `PhantomData<T>` has variance like `T`, and `*mut T` is
invariant over `T`, and so by placing a lifetime inside `T` you make the outer
type invariant over that lifetime?

## `Rc<T>`

Did you know that the `Rc` type was among the arguments for why
`std::mem::forget` shouldn’t be marked as unsafe?
https://github.com/rust-lang/rust/issues/24456

## `std::future::Ready`

Did you know that these days you can just use `async move { x }` instead of
`future::ready(x)`. The main reason to still use `future::ready(x)` is that you
can name the future it returns, which is harder with `async` (without
`type_alias_impl_trait` that is).

## `usize`

Did you know that `usize` isn’t really “the size of a pointer”. Instead, it’s
more like “the size of a pointer address difference”, and the two can be fairly
different! https://github.com/rust-lang/rust/issues/95228

## `std::thread::Thread`

Did you know that the `ThreadId` that’s available for each `Thread` is entirely
a `std` construct? Creating a `ThreadId` simply increments a global static
counter under a lock.

## `std::ops::ControlFlow`

Did you know that `ControlFlow` is really a stepping stone towards making `?`
work for other types than `Option` and `Result`? The full design has gone
through a lot of iterations, but the latest and greatest is
[RFC3058](https://github.com/rust-lang/rust/issues/84277).

## `File`

Did you know that there are implementations of `Read`, `Write`, and `Seek` for
`&File` as well, so multiple threads can share a single `File` and call those
concurrently. Whether they should is a different question of course.

## `Result<T, E>`

Did you know that Rust originally (pre-1.0) had both Result and an Either type?
They decided to remove Either [way back in 2013](https://github.com/rust-lang/rust/issues/9157)

## `Cow<str>`

Did you know that because `Cow<'a, T>` is covariant in `'a`, you can always
assign `Cow::Borrowed("some string")` to one no matter what it originally held?

## `PanicInfo`

Did you know that since `PanicInfo` is in core, its `Display` implementation
cannot access the panic data if it’s a `String` (since it can’t name that type),
so trying to print the `PanicInfo` after a
`std::panic::panic_any(format!("x y z"))` won’t print `"x y z"`?
[Source link.](https://github.com/rust-lang/rust/blob/352e621368c31d7b4a6362e081586cdb931ba020/library/core/src/panic/panic_info.rs#L159-L162)

## `std::ffi::c_void`

Did you know that the whole `c_void` type is a collection of hacks to try to
work around the lack for extern types?
https://github.com/rust-lang/rust/issues/43467

## `#[feature(raw_ref_op)] &raw const T`

Definitely cheating :p But did you know that originally the intention was to
have `&const raw` variable be just a MIR construct and let
`&variable as *const _` be automatically changed to `&const raw`?
https://github.com/RalfJung/rfcs/blob/fd4b4cd769300cfde5d54865d227990b71b762d1/text/0000-raw-reference-operator.md

## `u256`

Did you know that because Rust compiles through LLVM, we’re sort of constrained
to the primitive types LLVM supports, and [LLVM itself only goes up to 128](https://llvm.org/doxygen/classllvm_1_1Type.html#pub-static-methods)?

## `_`

Did you know that whether or not `let _ = x` should move `x` is actually fairly
subtle? https://github.com/rust-lang/rust/issues/10488

## `MaybeUninit`

Did you know that `MaybeUninit` arose because the previous mechanism,
`std::mem::uninitialized`, produced immediate undefined behavior when invoked
with most types (like `uninitialized::<bool>()`).

## `struct T<const C: usize>`

Did you know that with Rust 1.59.0 you can now [give `C` a default value](https://blog.rust-lang.org/2022/02/24/Rust-1.59.0.html#const-generics-defaults-and-interleaving)?

## `Weak<T>`

Did you know that actual deallocation logic for `Arc<T>` is implemented in
`Weak<T>`, and is invoked by considering all copies of a particular `Arc<T>` to
collectively hold a single `Weak<T>` between them? [Source link.](https://github.com/rust-lang/rust/blob/7e9b92cb43a489b34e2bcb8d21f36198e02eedbc/library/alloc/src/sync.rs#L1108-L1109)

## `[T; N]`

Did you know that while *most* trait implementations for arrays now use const
generics to impl for any length `N`, [we can’t *yet* do the same for `Default`](https://github.com/rust-lang/rust/blob/e40d5e83dc133d093c22c7ff016b10daa4f40dcf/library/core/src/array/mod.rs#L371-L394).

## `u8`

Did you know that as of Rust 1.60, you can now use `u8::escape_ascii` to
[get an iterator of the bytes needed to escape that byte character in most contexts](https://doc.rust-lang.org/std/ascii/fn.escape_default.html).

## `HashMap<K, V>`

Did you know that the Rust devs are working on a “raw” entry API for `HashMap`
that allows you to (unsafely) avoid re-hashing a key you’ve already hashed?
https://github.com/rust-lang/rust/issues/56167

## `&mut T`

Did you know that while `&mut T` is defined as meaning “mutable reference” in
the Rust reference, you’re often better off thinking of it as “mutually
exclusive reference”. [Quoth David Tolnay](https://docs.rs/dtolnay/latest/dtolnay/macro._02__reference_types.html).

## `std::ops::Range`

Did you know that there’s been a lot of debate around whether or not the `Range`
types should be `Copy`? https://github.com/rust-lang/rust/pull/21846

## `AtomicU32`

Did you know that you’ll often want `compare_exchange_weak` over
`compare_exchange` to get [more efficient code on ARM cores](https://devblogs.microsoft.com/oldnewthing/20180329-00/?p=98375).

## `std::ops::Hash`

Did you know that Hash is responsible for not just
[one](https://github.com/rust-lang/rust/issues/29263) , but
[two](https://github.com/rust-lang/rust/issues/65744) of the issues on the “rust
2 breakage wishlist”?

## `{integer}`

Did you know that fasterthanlime’s [most recent article](https://fasterthanli.me/articles/the-curse-of-strong-typing#different-kinds-of-numbers)
does a great job at explaining `{integer}`?

## `Fn`

Did you know that until Rust 1.35.0, `Box<T> where T: Fn` did not `impl Fn`, so
you couldn’t (easily) call boxed closures!
https://github.com/rust-lang/rust/pull/55431

## `((), ())`

Did you know that `((), ())` and `()` have the same hash? [Playground link.](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=894b78e8ee2721440aa8dea5e35f9dc3)

## `[T]`

Did you know that `&[u8]` implements `Read` and `Write`? So for anything that
takes `impl Read`, you can provide `&mut` slice instead! Comes in handy for
testing. Note that the slice itself is shortened for each read, hence
`&mut &[u8]`.

## `*`

Did you know that `*` is (mostly) just syntax sugar for the std::ops::Mul trait?

## `UnsafeCell<T>`

Did you know that `UnsafeCell` is one of those types that the compiler needs
“special magic” for because it has to instruct LLVM to not assume Rust’s normal
aliasing rules hold once code traverses the boundary of any `UnsafeCell`?
